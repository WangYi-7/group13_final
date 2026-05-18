#!/usr/bin/env python3
import rospy
import actionlib
import numpy as np
import cv2
import time
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from sensor_msgs.msg import LaserScan, Image
from geometry_msgs.msg import Twist, PoseWithCovarianceStamped
from std_msgs.msg import String
from cv_bridge import CvBridge, CvBridgeError
import apriltag

# ====================== 【固定识别参数，完全复制你给的示例代码】 ======================
DETECTOR = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
FOLLOW_TAG_ID = 1  # 只识别 AT1（ID=1）
NAV_TIMEOUT = 8    # 导航超时8秒，超时判定失败
STABLE_DELAY = 0.8 # 到达点位后稳定延时，保证图像稳定识别

# ====================== 【考试点位：仅房间1/2强制YAW，其余无朝向约束】 ======================
POINTS = [
    {"name":"房间1识别点", "x":2.881598, "y":1.646838, "yaw":-0.6},   # 强制朝向，对准标签
    {"name":"房间2识别点", "x":1.836224, "y":3.062882, "yaw":-1.41},  # 强制朝向，对准标签
    {"name":"途经点",     "x":2.055595, "y":3.055595, "yaw":None},     # 无朝向约束
    {"name":"终点",       "x":-0.3077,  "y":2.612976, "yaw":None}      # 无朝向约束
]

# 全局变量（和示例代码保持一致）
bridge = CvBridge()
latest_image = None
tag_found = False
pub_talk = None

# 【图像回调函数：100%复制你示例代码逻辑，无修改】
def image_callback(msg):
    global latest_image, tag_found
    try:
        cv_image = bridge.imgmsg_to_cv2(msg, "bgr8")
        latest_image = cv_image.copy()
        gray_frame = cv2.cvtColor(cv_image, cv2.COLOR_BGR2GRAY)
        tags = DETECTOR.detect(gray_frame)
        
        tag_found = False
        for tag in tags:
            if tag.tag_id == FOLLOW_TAG_ID:
                tag_found = True
                break
                
    except CvBridgeError as e:
        rospy.logerr(f"[{time.time():.2f}] 图像转换异常: {e}")

# 【导航函数：带详细日志，区分是否强制YAW】
def nav_to(point_info):
    x, y, yaw = point_info["x"], point_info["y"], point_info["yaw"]
    point_name = point_info["name"]
    rospy.loginfo(f"\n[{time.time():.2f}] ====== 开始导航：{point_name} ======")
    rospy.loginfo(f"[{time.time():.2f}] 目标坐标: x={x:.4f}, y={y:.4f}, 强制朝向: {yaw if yaw is not None else '无'}")
    
    client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
    client.wait_for_server(rospy.Duration(5))
    
    goal = MoveBaseGoal()
    goal.target_pose.header.frame_id = "map"
    goal.target_pose.header.stamp = rospy.Time.now()
    goal.target_pose.pose.position.x = x
    goal.target_pose.pose.position.y = y
    
    # 只有房间1/2识别点才强制YAW，途经点/终点不约束朝向
    if yaw is not None:
        goal.target_pose.pose.orientation.z = np.sin(yaw / 2)
        goal.target_pose.pose.orientation.w = np.cos(yaw / 2)
        rospy.loginfo(f"[{time.time():.2f}] 已设置强制航向角 yaw={yaw:.2f} rad")
    else:
        rospy.loginfo(f"[{time.time():.2f}] 不约束航向角，由导航自由规划")
    
    client.send_goal(goal)
    finished = client.wait_for_result(rospy.Duration(NAV_TIMEOUT))
    state = client.get_state()
    
    # 输出导航结果日志，方便排查
    if finished and state == actionlib.GoalStatus.SUCCEEDED:
        rospy.loginfo(f"[{time.time():.2f}] ✅ {point_name} 导航成功，已到达")
        return True
    else:
        rospy.logwarn(f"[{time.time():.2f}] ❌ {point_name} 导航失败/超时，状态码={state}")
        return False

# 【识别+语音播报：固定文案，详细日志】
def detect_and_speak(point_name):
    global tag_found, pub_talk
    rospy.loginfo(f"\n[{time.time():.2f}] ====== 开始识别：{point_name} ======")
    rospy.sleep(STABLE_DELAY)  # 等待图像稳定
    
    if tag_found:
        text = "已找到目标"
        rospy.loginfo(f"[{time.time():.2f}] ✅ 检测结果：成功识别到 AT1 标签")
    else:
        text = "未找到目标"
        rospy.loginfo(f"[{time.time():.2f}] ❌ 检测结果：未识别到 AT1 标签")
    
    pub_talk.publish(text)
    rospy.loginfo(f"[{time.time():.2f}] 🔊 语音播报完成：{text}")

if __name__ == '__main__':
    rospy.init_node('exam_final_node', anonymous=True, log_level=rospy.INFO)
    pub_talk = rospy.Publisher("/talk", String, queue_size=10)
    rospy.Subscriber("/camera/color/image_raw", Image, image_callback)
    
    rospy.loginfo("="*60)
    rospy.loginfo(f"[{time.time():.2f}] 🚀 考试任务启动 | 识别逻辑与示例代码完全一致")
    rospy.loginfo("="*60)
    rospy.sleep(1)
    
    # 1. 房间1识别（强制YAW）
    nav_to(POINTS[0])
    detect_and_speak("房间1")
    
    # 2. 房间2识别（强制YAW）
    nav_to(POINTS[1])
    detect_and_speak("房间2")
    
    # 3. 途经点（无YAW）
    nav_to(POINTS[2])
    
    # 4. 终点（无YAW）
    nav_to(POINTS[3])
    
    rospy.loginfo("\n" + "="*60)
    rospy.loginfo(f"[{time.time():.2f}] 🎯 全部考试任务执行完毕！")
    rospy.loginfo("="*60)
