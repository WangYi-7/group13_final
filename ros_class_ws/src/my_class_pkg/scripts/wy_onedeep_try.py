#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import actionlib
import cv2
import tf.transformations
import time
import math
from geometry_msgs.msg import PoseStamped, Twist
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from std_msgs.msg import String
from sensor_msgs.msg import Image
from nav_msgs.msg import Odometry
from cv_bridge import CvBridge
import apriltag

# ====================== 坐标（根据你最新四张图） ======================
# 图1：房间1观察点（需要朝向）
ROOM1 = {"x": 2.58560, "y": 1.100056, "yaw": 1.311280}
# 图2：房间2观察点（需要朝向）
ROOM2 = {"x": 2.773239, "y": 3.325241, "yaw": -1.506445}
# 图3：障碍物中间区域（途径点，无需朝向）
WAYPOINT = {"x": 1.221321, "y": 3.116894}
# 图4：终点（无需朝向）
END = {"x": -0.415656, "y": 2.584656}
# ================================================================

NAV_TIMEOUT = 40         # 每次导航超时秒数
RETRY_DELAY = 1.0        # 重试前等待秒数

class ExamInfiniteRetry:
    def __init__(self):
        rospy.init_node('exam_infinite_retry', anonymous=False)

        # AprilTag 检测器
        self.detector = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
        self.bridge = CvBridge()
        self.tag_detected = False

        self.image_sub = rospy.Subscriber('/camera/color/image_raw', Image, self.image_cb)
        self.speech_pub = rospy.Publisher('/talk', String, queue_size=10)
        
        # 用于后退的cmd_vel发布器和里程计订阅
        self.cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
        self.odom_sub = rospy.Subscriber('/odom', Odometry, self.odom_cb)

        self.move_base = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        rospy.loginfo("等待 move_base...")
        self.move_base.wait_for_server()
        rospy.loginfo("move_base 就绪")
        
        # 当前位姿
        self.current_x = 0.0
        self.current_y = 0.0
        self.current_yaw = 0.0

    def image_cb(self, msg):
        try:
            cv_img = self.bridge.imgmsg_to_cv2(msg, "bgr8")
            gray = cv2.cvtColor(cv_img, cv2.COLOR_BGR2GRAY)
            tags = self.detector.detect(gray)
            self.tag_detected = any(t.tag_id == 1 for t in tags)
        except Exception as e:
            rospy.logwarn_throttle(1, f"图像错误: {e}")

    def odom_cb(self, msg):
        """获取里程计数据"""
        self.current_x = msg.pose.pose.position.x
        self.current_y = msg.pose.pose.position.y
        q = msg.pose.pose.orientation
        _, _, yaw = tf.transformations.euler_from_quaternion([q.x, q.y, q.z, q.w])
        self.current_yaw = yaw

    def speak(self, text):
        rospy.loginfo(f"[语音] {text}")
        self.speech_pub.publish(String(data=text))
        rospy.sleep(0.2)

    def make_goal_with_yaw(self, x, y, yaw):
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

    def make_goal_no_yaw(self, x, y):
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = x
        goal.target_pose.pose.position.y = y
        goal.target_pose.pose.orientation.w = 1.0   # 保持当前朝向
        return goal

    def navigate_forever(self, goal, description):
        """无限重试，直到导航成功"""
        while not rospy.is_shutdown():
            rospy.loginfo(f"导航至 {description}")
            self.move_base.send_goal(goal)
            finished = self.move_base.wait_for_result(rospy.Duration(NAV_TIMEOUT))
            state = self.move_base.get_state()
            if finished and state == actionlib.GoalStatus.SUCCEEDED:
                rospy.loginfo(f"导航成功: {description}")
                return True
            else:
                rospy.logwarn(f"导航失败 (状态码: {state})，{RETRY_DELAY}秒后重试")
                self.move_base.cancel_goal()
                rospy.sleep(RETRY_DELAY)
        return False  # 节点关闭时退出

    def retreat(self, distance=0.8, speed=0.5):
        """
        直线后退指定距离（米）
        :param distance: 后退距离，默认0.3米
        :param speed: 后退速度，默认0.2米/秒
        """
        rospy.loginfo(f"开始后退 {distance} 米...")
        
        # 记录后退开始位置
        start_x = self.current_x
        start_y = self.current_y
        
        # 发布后退指令
        twist = Twist()
        twist.linear.x = -speed  # 负值表示后退
        twist.angular.z = 0.0
        
        rate = rospy.Rate(20)  # 20Hz
        
        retreated_dist = 0.0
        while not rospy.is_shutdown() and retreated_dist < distance:
            self.cmd_vel_pub.publish(twist)
            
            # 计算已经后退的距离（基于里程计）
            current_dist = math.hypot(self.current_x - start_x, self.current_y - start_y)
            retreated_dist = current_dist
            
            rate.sleep()
        
        # 停止机器人
        twist.linear.x = 0.0
        self.cmd_vel_pub.publish(twist)
        
        rospy.loginfo(f"后退完成，实际后退距离: {retreated_dist:.3f} 米")
        rospy.sleep(0.2)  # 稳定一下

    def detect_once(self):
        """等待1秒获取一帧图像，返回是否检测到 AprilTag"""
        rospy.sleep(1.0)
        return self.tag_detected

    def run(self):
        rospy.sleep(2)

        # 1. 前往房间1
        goal1 = self.make_goal_with_yaw(ROOM1["x"], ROOM1["y"], ROOM1["yaw"])
        self.navigate_forever(goal1, "房间1")
        found = self.detect_once()
        self.speak("已找到目标" if found else "未找到目标")
        # 房间1后退30cm
        self.retreat(0.3)

        # 2. 前往房间2
        goal2 = self.make_goal_with_yaw(ROOM2["x"], ROOM2["y"], ROOM2["yaw"])
        self.navigate_forever(goal2, "房间2")
        found = self.detect_once()
        self.speak("已找到目标" if found else "未找到目标")
        # 房间2后退30cm
        self.retreat(0.3)

        # 3. 前往途径点（障碍物中间区域）
        goal3 = self.make_goal_no_yaw(WAYPOINT["x"], WAYPOINT["y"])
        rospy.loginfo("前往障碍物中间区域（途径点）")
        self.navigate_forever(goal3, "途径点")

        # 4. 前往终点
        goal4 = self.make_goal_no_yaw(END["x"], END["y"])
        rospy.loginfo("前往终点")
        self.navigate_forever(goal4, "终点")

        rospy.loginfo("所有任务完成")

if __name__ == '__main__':
    try:
        ExamInfiniteRetry().run()
    except rospy.ROSInterruptException:
        pass
