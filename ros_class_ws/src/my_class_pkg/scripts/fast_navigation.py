#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import actionlib
import numpy as np
import cv2
import threading
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from sensor_msgs.msg import LaserScan, Image
from geometry_msgs.msg import Twist, PoseWithCovarianceStamped
from std_msgs.msg import String
from cv_bridge import CvBridge, CvBridgeError
import apriltag

# ====================== 【用你最新正确日志的极限坐标，直接运行】 ======================
ROOMS = [
    # 第1房间：导航起点 + 地图极限停止点（桌子位置）
    {"start":{"x":2.53,"y":0.98,"yaw":1.23}, "stop":{"x":2.727068,"y":1.715139,"yaw":1.23}},
    # 第2房间：导航起点 + 地图极限停止点
    {"start":{"x":-2.79,"y":1.50,"yaw":-1.54}, "stop":{"x":2.227027,"y":2.2255,"yaw":-1.54}},
]
FINAL_POINT = {"x":0.97,"y":3.16,"yaw":2.97}

# 速度：赶路快，识别慢（省考试时间）
NAV_FAST_SPEED = 0.6
RECOG_SLOW_SPEED = 0.25

# 参数
SAFE_AVOID_DIST = 0.05    # 雷达正常兜底防撞
FRONT_ANGLE_RANGE = 15
DETECTOR = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
FOLLOW_TAG_ID = 1
DETECT_CONSECUTIVE = 3
MAP_STOP_THRESHOLD = 0.2
# =====================================================================

class State:
    IDLE = 0
    NAVIGATING = 1
    DYNAMIC_RECOGNIZE = 2
    FINISHED = 4

class ExamNavigation:
    def __init__(self):
        self.state = State.IDLE
        self.current_room = 0
        self.final_obstacle_found = False
        self.avoid_min_dist = float('inf')
        self.tag_consecutive_count = 0
        self.emergency_stop = False
        self.robot_x = 0.0
        self.robot_y = 0.0

        self.bridge = CvBridge()
        self.latest_image = None
        self.tag_found = False

        self.cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)
        self.talk_pub = rospy.Publisher("/talk", String, queue_size=10)

        self.move_base = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        rospy.loginfo("等待导航服务器启动...")
        self.move_base.wait_for_server(rospy.Duration(10))

        # 雷达全程正常订阅、正常工作
        rospy.Subscriber('/scan', LaserScan, self.laser_cb, queue_size=1)
        rospy.Subscriber("/camera/color/image_raw", Image, self.image_callback)
        rospy.Subscriber("/amcl_pose", PoseWithCovarianceStamped, self.amcl_cb)

        self.avoid_thread = threading.Thread(target=self.avoid_loop)
        self.avoid_thread.daemon = True
        self.avoid_thread.start()

        rospy.loginfo("✅ 系统初始化完成")
        self.speak("导航系统启动，准备开始任务")

    def amcl_cb(self, msg):
        self.robot_x = msg.pose.pose.position.x
        self.robot_y = msg.pose.pose.position.y

    def speak(self, text):
        rospy.loginfo(f"🔊 播报：{text}")
        self.talk_pub.publish(text)
        rospy.sleep(0.4)

    def image_callback(self, msg):
        try:
            cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")
            self.latest_image = cv_image.copy()
            gray_frame = cv2.cvtColor(cv_image, cv2.COLOR_BGR2GRAY)
            tags = DETECTOR.detect(gray_frame)
            self.tag_found = False
            for tag in tags:
                if tag.tag_id == FOLLOW_TAG_ID:
                    self.tag_found = True
                    break
        except CvBridgeError as e:
            rospy.logerr(f"图像错误: {e}")

    def laser_cb(self, scan):
        """【雷达全程正常启用，正常避障】仅不参与识别停止判断"""
        angle_min = scan.angle_min
        angle_inc = scan.angle_increment
        center_idx = int((-angle_min) / angle_inc)
        half_avoid = int(np.radians(FRONT_ANGLE_RANGE) / angle_inc)
        a_start = max(0, center_idx - half_avoid)
        a_end = min(len(scan.ranges), center_idx + half_avoid)
        a_ranges = np.array(scan.ranges[a_start:a_end])
        a_ranges = a_ranges[np.isfinite(a_ranges)]
        a_ranges = a_ranges[a_ranges > 0.02]
        self.avoid_min_dist = np.min(a_ranges) if len(a_ranges) > 0 else float('inf')

    def avoid_loop(self):
        """雷达正常兜底防撞"""
        rate = rospy.Rate(50)
        while not rospy.is_shutdown():
            if self.state in [State.NAVIGATING, State.DYNAMIC_RECOGNIZE]:
                if self.avoid_min_dist < SAFE_AVOID_DIST:
                    self.emergency_stop = True
                    self.cmd_vel_pub.publish(Twist())
                else:
                    self.emergency_stop = False
            rate.sleep()

    def send_goal(self, x, y, yaw):
        self.move_base.cancel_all_goals()
        rospy.sleep(0.2)
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = x
        goal.target_pose.pose.position.y = y
        goal.target_pose.pose.orientation.z = np.sin(yaw/2)
        goal.target_pose.pose.orientation.w = np.cos(yaw/2)
        self.move_base.send_goal(goal)

    def dynamic_recognize_task(self, room_idx):
        room = ROOMS[room_idx]
        stop_x, stop_y = room["stop"]["x"], room["stop"]["y"]
        rospy.loginfo(f"🔍 进入第{room_idx+1}房间，向地图极限点动态识别")
        self.speak(f"进入第{room_idx+1}房间，开始识别")
        self.state = State.DYNAMIC_RECOGNIZE
        self.tag_consecutive_count = 0
        self.move_base.cancel_all_goals()

        twist = Twist()
        twist.linear.x = RECOG_SLOW_SPEED

        while not rospy.is_shutdown():
            if self.emergency_stop:
                self.cmd_vel_pub.publish(Twist())
                rospy.sleep(0.1)
                continue

            # 核心：走到地图极限坐标，**不管找没找到，强制停止播报未找到**
            dist_to_stop = np.hypot(self.robot_x - stop_x, self.robot_y - stop_y)
            if dist_to_stop < MAP_STOP_THRESHOLD:
                self.cmd_vel_pub.publish(Twist())
                rospy.loginfo(f"🧱 到达地图极限停止点，结束识别")
                self.speak(f"第{room_idx+1}个房间未检测到障碍物")
                return

            if self.tag_found:
                self.tag_consecutive_count += 1
                if self.tag_consecutive_count >= DETECT_CONSECUTIVE:
                    self.final_obstacle_found = True
                    self.speak(f"第{room_idx+1}个房间检测到障碍物")
                    self.tag_consecutive_count = 0
            else:
                self.tag_consecutive_count = 0

            self.cmd_vel_pub.publish(twist)
            rospy.sleep(0.1)

    def run(self):
        self.state = State.NAVIGATING
        # 强制顺序：1房→2房→终点，必须走完
        for i in range(2):
            self.current_room = i
            room = ROOMS[i]
            self.send_goal(room["start"]["x"], room["start"]["y"], room["start"]["yaw"])
            while not rospy.is_shutdown():
                if self.move_base.get_state() == actionlib.GoalStatus.SUCCEEDED:
                    break
                rospy.sleep(0.1)
            self.dynamic_recognize_task(i)
        
        self.send_goal(FINAL_POINT["x"], FINAL_POINT["y"], FINAL_POINT["yaw"])
        while not rospy.is_shutdown():
            if self.move_base.get_state() == actionlib.GoalStatus.SUCCEEDED:
                break
            rospy.sleep(0.1)

        self.state = State.FINISHED
        self.cmd_vel_pub.publish(Twist())
        if self.final_obstacle_found:
            res = "最终结果：找到障碍物"
        else:
            res = "最终结果：两个房间均未找到障碍物"
        rospy.loginfo(f"🏁 {res}")
        self.speak(res)
        self.speak("任务完成，到达终点")

if __name__ == '__main__':
    try:
        rospy.init_node('exam_final_node')
        node = ExamNavigation()
        node.run()
    except rospy.ROSInterruptException:
        rospy.loginfo("节点中断")
