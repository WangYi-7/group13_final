#!/usr/bin/env python3
import rospy
from std_msgs.msg import String
from tag_detect import get_tag_status

pub = rospy.Publisher("/talk", String, queue_size=10)

def speak(text):
    msg = String()
    msg.data = text
    pub.publish(msg)
    print("播报：", text)

if __name__ == "__main__":
    rospy.init_node("speaker_node")
    rospy.sleep(1)  # 等一下启动
    
    # 现在就检测一次，然后播报
    if get_tag_status():
        speak("已找到目标")
    else:
        speak("未找到目标")
    
    rospy.spin()
