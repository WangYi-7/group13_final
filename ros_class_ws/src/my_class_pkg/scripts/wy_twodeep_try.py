#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import actionlib
import cv2
import tf.transformations
import math
from geometry_msgs.msg import PoseStamped
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

NAV_TIMEOUT = 35
RETRY_DELAY = 0.8

class HighScorePatrol:
    def __init__(self):
        rospy.init_node('high_score_patrol', anonymous=False)

        self.detector = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
        self.bridge = CvBridge()
        self.tag_detected = False

        self.image_sub = rospy.Subscriber('/camera/color/image_raw', Image, self.image_cb)
        self.speech_pub = rospy.Publisher('/talk', String, queue_size=10)
        self.odom_sub = rospy.Subscriber('/odom', Odometry, self.odom_cb)

        self.move_base = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        rospy.loginfo("等待 move_base...")
        self.move_base.wait_for_server()
        rospy.loginfo("move_base 就绪")

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
        self.current_x = msg.pose.pose.position.x
        self.current_y = msg.pose.pose.position.y
        q = msg.pose.pose.orientation
        _, _, yaw = tf.transformations.euler_from_quaternion([q.x, q.y, q.z, q.w])
        self.current_yaw = yaw

    def speak(self, text):
        # 仅用于房间识别结果播报
        rospy.loginfo(f"[语音] {text}")
        self.speech_pub.publish(String(data=text))
        rospy.sleep(0.1)

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
        goal.target_pose.pose.orientation.w = 1.0
        return goal

    def state_to_string(self, state):
        if state == actionlib.GoalStatus.PENDING:
            return "PENDING"
        elif state == actionlib.GoalStatus.ACTIVE:
            return "ACTIVE"
        elif state == actionlib.GoalStatus.SUCCEEDED:
            return "SUCCEEDED"
        elif state == actionlib.GoalStatus.ABORTED:
            return "ABORTED"
        elif state == actionlib.GoalStatus.REJECTED:
            return "REJECTED"
        elif state == actionlib.GoalStatus.LOST:
            return "LOST"
        else:
            return f"UNKNOWN({state})"

    def find_nearest_reachable(self, orig_x, orig_y, timeout=2.0):
        radii = [0.2, 0.4, 0.6, 0.8, 1.0, 1.2]
        for r in radii:
            for angle in range(0, 360, 45):
                rad = math.radians(angle)
                tx = orig_x + r * math.cos(rad)
                ty = orig_y + r * math.sin(rad)
                test_goal = MoveBaseGoal()
                test_goal.target_pose.header.frame_id = "map"
                test_goal.target_pose.header.stamp = rospy.Time.now()
                test_goal.target_pose.pose.position.x = tx
                test_goal.target_pose.pose.position.y = ty
                test_goal.target_pose.pose.orientation.w = 1.0
                self.move_base.send_goal(test_goal)
                finished = self.move_base.wait_for_result(rospy.Duration(timeout))
                state = self.move_base.get_state()
                self.move_base.cancel_goal()
                rospy.sleep(0.2)
                if finished and state == actionlib.GoalStatus.SUCCEEDED:
                    rospy.loginfo(f"找到可达点: ({tx:.3f}, {ty:.3f}) 半径 {r}m")
                    return (tx, ty)
        rospy.logerr("未找到可达点")
        return None

    def navigate_with_fallback(self, goal_func, description, is_room=False):
        original_goal = None
        fallback_used = False
        while not rospy.is_shutdown():
            if original_goal is None:
                goal = goal_func()
                original_goal = goal
            else:
                goal = original_goal if not fallback_used else fallback_goal

            rospy.loginfo(f"导航至 {description}，目标点: ({goal.target_pose.pose.position.x:.3f}, {goal.target_pose.pose.position.y:.3f})")
            self.move_base.send_goal(goal)
            finished = self.move_base.wait_for_result(rospy.Duration(NAV_TIMEOUT))
            state = self.move_base.get_state()

            if finished and state == actionlib.GoalStatus.SUCCEEDED:
                rospy.loginfo(f"成功到达 {description}")
                if is_room:
                    # 等待1秒稳定图像（原0.2秒改为1秒）
                    rospy.sleep(1.0)
                    found = self.tag_detected
                    self.speak("已找到目标" if found else "未找到目标")
                    return found
                else:
                    return True
            else:
                state_str = self.state_to_string(state)
                rospy.logwarn(f"导航失败: {state_str}")
                rospy.logwarn(f"当前位姿: x={self.current_x:.3f}, y={self.current_y:.3f}, yaw={self.current_yaw:.3f}")
                dist = math.hypot(self.current_x - goal.target_pose.pose.position.x,
                                  self.current_y - goal.target_pose.pose.position.y)
                rospy.logwarn(f"距离目标点 {dist:.2f} 米")

                if not fallback_used and (state == actionlib.GoalStatus.ABORTED or state == actionlib.GoalStatus.REJECTED):
                    rospy.logwarn("目标点不可达，尝试搜索附近可达点...")
                    target_x = goal.target_pose.pose.position.x
                    target_y = goal.target_pose.pose.position.y
                    reachable = self.find_nearest_reachable(target_x, target_y)
                    if reachable is not None:
                        fallback_goal = self.make_goal_no_yaw(reachable[0], reachable[1])
                        fallback_used = True
                        rospy.loginfo(f"使用 fallback 目标点: ({reachable[0]:.3f}, {reachable[1]:.3f})")
                        continue
                    else:
                        rospy.logerr("未找到可达点，继续使用原目标重试")
                self.move_base.cancel_goal()
                rospy.loginfo(f"{RETRY_DELAY}秒后重试...")
                rospy.sleep(RETRY_DELAY)
        return False if is_room else False

    def run(self):
        rospy.sleep(1)
        rospy.loginfo("任务开始")   # 仅日志

        # 房间1
        self.navigate_with_fallback(
            lambda: self.make_goal_with_yaw(ROOM1["x"], ROOM1["y"], ROOM1["yaw"]),
            "房间1", is_room=True)
        # 房间2
        self.navigate_with_fallback(
            lambda: self.make_goal_with_yaw(ROOM2["x"], ROOM2["y"], ROOM2["yaw"]),
            "房间2", is_room=True)

        # 途径点
        self.navigate_with_fallback(
            lambda: self.make_goal_no_yaw(WAYPOINT["x"], WAYPOINT["y"]),
            "途径点", is_room=False)

        # 终点
        self.navigate_with_fallback(
            lambda: self.make_goal_no_yaw(END["x"], END["y"]),
            "终点", is_room=False)

        rospy.loginfo("任务结束")   # 仅日志

if __name__ == '__main__':
    try:
        HighScorePatrol().run()
    except rospy.ROSInterruptException:
        pass

