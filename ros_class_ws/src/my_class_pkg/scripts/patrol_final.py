#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import actionlib
import math
import cv2
import tf.transformations
import threading
from geometry_msgs.msg import Twist, PoseStamped
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from std_msgs.msg import String
from sensor_msgs.msg import Image, LaserScan
from cv_bridge import CvBridge
import apriltag

# ======================== 坐标（请手动验证可达性） ========================
ROOM1_OBSERVE = {"x": 2.535627, "y": 0.981352, "yaw": 1.2287}
ROOM1_LIMIT   = {"x": 2.599659, "y": 1.715139}   # 极限点，用于前进识别
ROOM2_OBSERVE = {"x": 2.78057,  "y": 3.668734, "yaw": -1.540637}
ROOM2_LIMIT   = {"x": 2.008559, "y": 3.128346}
END           = {"x": 0.968913, "y": 3.155856, "yaw": 2.973232}
BARRIER = None   # 障碍物中间点

# 识别参数
MOVE_SPEED = 0.2            # 前进速度
LIMIT_TOLERANCE = 0.1       # 到达极限点容差
EMERGENCY_DIST = 0.3        # 紧急停车距离（正前方 < 0.3m 时停车）
# =====================================================================

class PureMoveBasePatrol:
    def __init__(self):
        rospy.init_node('pure_movebase_patrol', anonymous=False)

        # AprilTag 检测
        self.detector = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
        self.bridge = CvBridge()
        self.tag_found = False

        # 订阅
        self.image_sub = rospy.Subscriber('/camera/color/image_raw', Image, self.image_cb)
        self.scan_sub = rospy.Subscriber('/scan', LaserScan, self.scan_cb)
        self.speech_pub = rospy.Publisher('/talk', String, queue_size=10)
        self.cmd_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

        # move_base 客户端（完全依赖课件）
        self.move_base = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        rospy.loginfo("等待 move_base 服务器...")
        self.move_base.wait_for_server()
        rospy.loginfo("move_base 已连接")

        # 紧急停车标志（仅用于动态障碍物）
        self.emergency = False
        self.emergency_thread = threading.Thread(target=self.emergency_monitor, daemon=True)
        self.emergency_thread.start()

        self.current_x = 0.0
        self.current_y = 0.0
        rospy.loginfo("纯 move_base 巡逻节点启动（无自定义导航逻辑）")

    def image_cb(self, msg):
        try:
            cv_img = self.bridge.imgmsg_to_cv2(msg, "bgr8")
            gray = cv2.cvtColor(cv_img, cv2.COLOR_BGR2GRAY)
            tags = self.detector.detect(gray)
            self.tag_found = any(t.tag_id == 1 for t in tags)
        except:
            pass

    def scan_cb(self, msg):
        # 仅用于紧急停车：计算正前方最小距离
        angle_min = msg.angle_min
        angle_inc = msg.angle_increment
        center_idx = int(-angle_min / angle_inc) if angle_min < 0 else 0
        half = int(math.radians(15) / angle_inc)
        start = max(0, center_idx - half)
        end = min(len(msg.ranges), center_idx + half)
        ranges = [r for r in msg.ranges[start:end] if math.isfinite(r) and r > 0.05]
        front = min(ranges) if ranges else float('inf')
        # 当正前方太近且 move_base 正在导航时，触发紧急停车
        if front < EMERGENCY_DIST and self.move_base.get_state() == actionlib.GoalStatus.ACTIVE:
            if not self.emergency:
                rospy.logwarn(f"紧急停车！前方 {front:.2f}m")
                self.cmd_pub.publish(Twist())
                self.emergency = True
        else:
            self.emergency = False

    def emergency_monitor(self):
        # 单独线程：如果紧急标志为真，持续发布空速度
        rate = rospy.Rate(20)
        while not rospy.is_shutdown():
            if self.emergency:
                self.cmd_pub.publish(Twist())
            rate.sleep()

    def speak(self, text):
        rospy.loginfo(f"[语音] {text}")
        self.speech_pub.publish(String(data=text))
        rospy.sleep(0.2)

    def stop(self):
        self.cmd_pub.publish(Twist())

    def make_goal(self, x, y, yaw):
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = x
        goal.target_pose.pose.position.y = y
        q = tf.transformations.quaternion_from_euler(0, 0, yaw)
        goal.target_pose.pose.orientation.x = q[0]
        goal.target_pose.pose.orientation.y = q[1]
        goal.target_pose.pose.orientation.z = q[2]
        goal.target_pose.pose.orientation.w = q[3]
        return goal

    def navigate_to(self, x, y, yaw, timeout=40):
        """发送导航目标，等待成功或失败，不做额外处理"""
        goal = self.make_goal(x, y, yaw)
        self.move_base.send_goal(goal)
        rospy.loginfo(f"发送导航目标: ({x:.3f}, {y:.3f}) yaw={yaw:.2f}")
        finished = self.move_base.wait_for_result(rospy.Duration(timeout))
        state = self.move_base.get_state()
        if finished and state == actionlib.GoalStatus.SUCCEEDED:
            rospy.loginfo("导航成功到达目标点")
            return True
        else:
            rospy.logerr(f"导航失败，状态码: {state} (0=PENDING,1=ACTIVE,2=SUCCEEDED,3=ABORTED,4=REJECTED,5=LOST)")
            self.move_base.cancel_goal()
            return False

    def advance_to_limit(self, limit_x, limit_y):
        """直线走向极限点，检测 AprilTag（不使用 move_base）"""
        self.stop()
        rospy.sleep(0.5)
        self.speak("开始识别")
        dx = limit_x - self.current_x
        dy = limit_y - self.current_y
        dist = math.hypot(dx, dy)
        if dist < LIMIT_TOLERANCE:
            rospy.logwarn("已在极限点附近，跳过前进")
            return False
        twist = Twist()
        twist.linear.x = MOVE_SPEED
        rate = rospy.Rate(20)
        rospy.loginfo(f"从 ({self.current_x:.3f}, {self.current_y:.3f}) 走向极限点 ({limit_x:.3f}, {limit_y:.3f})")
        while not rospy.is_shutdown():
            now_dist = math.hypot(self.current_x - limit_x, self.current_y - limit_y)
            if now_dist < LIMIT_TOLERANCE:
                self.stop()
                rospy.loginfo("到达极限点，未检测到目标")
                return False
            if self.tag_found:
                self.stop()
                rospy.loginfo("检测到 AprilTag！")
                return True
            # 如果紧急停车触发，等待恢复（动态障碍物）
            if self.emergency:
                rospy.sleep(0.1)
                continue
            self.cmd_pub.publish(twist)
            rate.sleep()

    def run(self):
        rospy.sleep(2)  # 等待话题稳定
        self.speak("任务开始")

        # 房间1
        rospy.loginfo("=== 前往房间1观察点 ===")
        if self.navigate_to(ROOM1_OBSERVE["x"], ROOM1_OBSERVE["y"], ROOM1_OBSERVE["yaw"]):
            self.speak("到达第一个房间")
            found = self.advance_to_limit(ROOM1_LIMIT["x"], ROOM1_LIMIT["y"])
            self.speak("已找到目标" if found else "未找到目标")
        else:
            rospy.logerr("房间1导航失败，放弃任务")
            return

        # 房间2
        rospy.loginfo("=== 前往房间2观察点 ===")
        if self.navigate_to(ROOM2_OBSERVE["x"], ROOM2_OBSERVE["y"], ROOM2_OBSERVE["yaw"]):
            self.speak("到达第二个房间")
            found = self.advance_to_limit(ROOM2_LIMIT["x"], ROOM2_LIMIT["y"])
            self.speak("已找到目标" if found else "未找到目标")
        else:
            rospy.logerr("房间2导航失败，放弃任务")
            return

        # 障碍物中间区域（可选）
        if BARRIER is not None:
            rospy.loginfo("=== 前往障碍物中间区域 ===")
            self.navigate_to(BARRIER["x"], BARRIER["y"], BARRIER["yaw"], timeout=25)
            self.speak("已通过障碍物区域")

        # 终点
        rospy.loginfo("=== 前往终点 ===")
        self.navigate_to(END["x"], END["y"], END["yaw"], timeout=35)
        self.speak("到达终点，任务完成")
        self.stop()
        rospy.loginfo("所有任务完成")

if __name__ == '__main__':
    try:
        PureMoveBasePatrol().run()
    except rospy.ROSInterruptException:
        pass
