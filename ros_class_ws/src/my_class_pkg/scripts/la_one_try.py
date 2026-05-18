#!/usr/bin/env python3
import rospy
import cv2
from sensor_msgs.msg import Image
from std_msgs.msg import String
from geometry_msgs.msg import Quaternion
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
import actionlib
from cv_bridge import CvBridge, CvBridgeError
import apriltag
import math

# ====================== 你的坐标 ======================
ROOM1_X = 2.676187
ROOM1_Y = 1.646838
ROOM1_YAW = 1.549641

ROOM2_X = 2.801581
ROOM2_Y = 3.055595
ROOM2_YAW = -1.413798

OBSTACLE_X = 1.036243
OBSTACLE_Y = 3.062882
OBSTACLE_YAW = -2.670107

END_X = -0.387744
END_Y = 2.612976
END_YAW = 2.976391

# ====================== AprilTag 检测配置 ======================
DETECTOR = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
TARGET_TAG_ID = 1

# ====================== 全局变量 ======================
bridge = CvBridge()
tag_found = False
voice_pub = None
move_base_client = None

# ---------------------- 角度转四元数 ----------------------
def yaw_to_quaternion(yaw):
    q = Quaternion()
    q.z = math.sin(yaw / 2)
    q.w = math.cos(yaw / 2)
    return q

# ---------------------- 导航函数 ----------------------
def go_to_point(x, y, yaw, timeout=25.0):  # 改短：比赛限时5分钟
    if rospy.is_shutdown():
        return False

    goal = MoveBaseGoal()
    goal.target_pose.header.frame_id = "map"
    goal.target_pose.header.stamp = rospy.Time.now()
    goal.target_pose.pose.position.x = x
    goal.target_pose.pose.position.y = y
    goal.target_pose.pose.orientation = yaw_to_quaternion(yaw)

    rospy.loginfo(f"🚗 导航去目标: x={x:.2f}, y={y:.2f}")
    move_base_client.send_goal(goal)
    
    finished = move_base_client.wait_for_result(rospy.Duration(timeout))
    
    if not finished:
        rospy.logwarn("⏰ 导航超时")
        move_base_client.cancel_goal()
        return False
    
    state = move_base_client.get_state()
    if state == actionlib.GoalStatus.SUCCEEDED:
        rospy.loginfo("✅ 到达目标点")
        return True
    else:
        rospy.logwarn(f"❌ 导航失败，状态码: {state}")
        return False

# ---------------------- 语音播报 ----------------------
def speak(text):
    rospy.loginfo(f"🔊 {text}")
    voice_pub.publish(text)

# ---------------------- AprilTag 检测回调 ----------------------
def image_callback(msg):
    global tag_found
    try:
        cv_img = bridge.imgmsg_to_cv2(msg, "bgr8")
        gray = cv2.cvtColor(cv_img, cv2.COLOR_BGR2GRAY)
        tags = DETECTOR.detect(gray)
        
        found = False
        for t in tags:
            if t.tag_id == TARGET_TAG_ID:
                found = True
                break
        tag_found = found

    except CvBridgeError as e:
        rospy.logerr(f"图像错误: {e}")

# ---------------------- 房间检测 + 播报 ----------------------
def check_and_speak(room_name):
    global tag_found
    rospy.loginfo(f"🔍 在{room_name}检测AprilTag...")

    # 🔴 删掉这里的 tag_found = False，会导致检测失效！
    
    rospy.sleep(2.0)  # 画面稳定
    
    detect_start = rospy.Time.now()
    detect_timeout = rospy.Duration(3.0)
    
    while rospy.Time.now() - detect_start < detect_timeout:
        if tag_found:
            speak(f"{room_name}：已识别到目标")
            return True
        rospy.sleep(0.1)
    
    speak(f"{room_name}：无法识别目标")
    return False

# ====================== 主任务流程 ======================
def mission():
    rospy.loginfo("🚀 开始期末实战任务")
    rospy.sleep(0.5)

    # 1. 出发
    speak("开始巡逻")
    rospy.loginfo("🚩 离开启动区 +10分")

    # 2. 去第一个房间
    rospy.loginfo("==== 前往第一个房间 ====")
    success = go_to_point(ROOM1_X, ROOM1_Y, ROOM1_YAW)
    if success:
        check_and_speak("第一个房间")
    else:
        rospy.logwarn("未到达房间1，跳过检测继续执行")
        speak("第一个房间：未到达，跳过")

    # 3. 去第二个房间
    rospy.loginfo("==== 前往第二个房间 ====")
    success = go_to_point(ROOM2_X, ROOM2_Y, ROOM2_YAW)
    if success:
        check_and_speak("第二个房间")
    else:
        rospy.logwarn("未到达房间2，跳过检测继续执行")
        speak("第二个房间：未到达，跳过")

    # 4. 过障碍区域
    rospy.loginfo("==== 通过障碍区域 ====")
    success = go_to_point(OBSTACLE_X, OBSTACLE_Y, OBSTACLE_YAW)
    if success:
        speak("已通过障碍物区域")
    else:
        speak("障碍物区域通行异常")

    # 5. 回终点
    rospy.loginfo("==== 返回终点 ====")
    success = go_to_point(END_X, END_Y, END_YAW)
    if success:
        speak("已回到终点，任务完成")
        rospy.loginfo("🎯 任务全部完成")
    else:
        speak("返回终点失败，任务异常结束")
        rospy.logwarn("⚠️ 任务未完成")

# ====================== 主函数 ======================
if __name__ == "__main__":
    rospy.init_node("final_navigation_node")

    move_base_client = actionlib.SimpleActionClient("move_base", MoveBaseAction)
    rospy.loginfo("⏳ 等待 move_base 服务...")
    move_base_client.wait_for_server()
    rospy.loginfo("✅ move_base 服务已连接")

    voice_pub = rospy.Publisher("/talk", String, queue_size=10)
    rospy.Subscriber("/camera/color/image_raw", Image, image_callback)

    rospy.sleep(1.0)
    mission()
    rospy.spin()
