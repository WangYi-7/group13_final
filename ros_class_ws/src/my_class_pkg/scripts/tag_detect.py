#!/usr/bin/env python3
import rospy
from apriltag_ros.msg import AprilTagDetectionArray

tag_found = False

def tag_callback(msg):
    global tag_found
    tag_found = False
    for detection in msg.detections:
        if detection.id[0] == 1:
            tag_found = True
            break

def get_tag_status():
    return tag_found

if __name__ == "__main__":
    rospy.init_node("tag_detect_node")
    rospy.Subscriber("/tag_detections", AprilTagDetectionArray, tag_callback)
    rospy.spin()
