#!/usr/bin/env python3
import rospy
import cv2
from sensor_msgs.msg import Image
from std_msgs.msg import String
from cv_bridge import CvBridge, CvBridgeError
import apriltag

# 【完全复制你跟踪代码的检测参数】
DETECTOR = apriltag.Detector(apriltag.DetectorOptions(families='tag36h11'))
FOLLOW_TAG_ID = 1  # 只识别1号标签
TEST_INTERVAL = 10  # 30秒重测一次

# 全局变量
bridge = CvBridge()
latest_image = None
tag_found = False

# 【完全复制你跟踪代码的图像回调逻辑】
def image_callback(msg):
    global latest_image, tag_found
    try:
        cv_image = bridge.imgmsg_to_cv2(msg, "bgr8")
        latest_image = cv_image.copy()
        gray_frame = cv2.cvtColor(cv_image, cv2.COLOR_BGR2GRAY)
        tags = DETECTOR.detect(gray_frame)
        
        # 和跟踪代码一样的判断逻辑
        tag_found = False
        for tag in tags:
            if tag.tag_id == FOLLOW_TAG_ID:
                tag_found = True
                break
                
    except CvBridgeError as e:
        rospy.logerr(f"图像转换错误: {e}")

# 自动重测+播报
def auto_test(event):
    global tag_found
    pub = rospy.Publisher("/talk", String, queue_size=10)
    
    if tag_found:
        text = "已找到目标"
        rospy.loginfo(f"✅ 检测结果：找到1号AprilTag")
    else:
        text = "未找到目标"
        rospy.loginfo(f"❌ 检测结果：未找到1号AprilTag")
    
    pub.publish(text)
    rospy.loginfo(f"🔊 已播报：{text}")
    rospy.loginfo(f"下一次检测：{TEST_INTERVAL}秒后\n")

if __name__ == "__main__":
    rospy.init_node("final_test_node")
    
    # 【和跟踪代码一样订阅摄像头图像】
    rospy.Subscriber("/camera/color/image_raw", Image, image_callback)
    
    # 启动时等1秒，然后立刻测一次
    rospy.sleep(1)
    auto_test(None)
    
    # 每30秒自动重测
    rospy.Timer(rospy.Duration(TEST_INTERVAL), auto_test)
    
    rospy.loginfo("✅ 自动测试已启动（和跟踪代码用完全相同的检测逻辑）")
    rospy.loginfo("按 Ctrl+C 停止\n")
    rospy.spin()
