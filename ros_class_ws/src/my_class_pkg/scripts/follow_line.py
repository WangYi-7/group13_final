#!/usr/bin/env python3
import rospy
import cv2
import numpy as np
from sensor_msgs.msg import Image
from geometry_msgs.msg import Twist
from std_msgs.msg import Int16
from cv_bridge import CvBridge, CvBridgeError


class ImageSubscriberNode:
    def __init__(self):
        # 初始化ROS节点
        rospy.init_node('image_subscriber_node', anonymous=True)

        # 蓝色线条HSV阈值参数
        self.hmin = 20
        self.smin = 100
        self.vmin = 160
        self.hmax = 40
        self.smax = 255
        self.vmax = 255

        # 机器人移动使能标志
        self.enable_move = False

        # 初始化OpenCV与ROS图像转换工具
        self.bridge = CvBridge()

        # 订阅者
        self.image_sub = rospy.Subscriber('/camera/color/image_raw', Image, self.image_callback)
        self.enable_sub = rospy.Subscriber('/enable_move', Int16, self.enable_callback)

        # 发布者
        self.image_mask_pub = rospy.Publisher('/image_mask', Image, queue_size=10)
        self.image_result_pub = rospy.Publisher('/image_result', Image, queue_size=10)
        self.cmd_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

    def enable_callback(self, msg):
        """使能信号回调函数"""
        if msg.data == 1:
            self.enable_move = True

    def image_callback(self, msg):
        """图像话题回调函数"""
        try:
            cv_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")
            src = cv_image.copy()
            self.update_frame(src, self.hmin, self.hmax, self.smin, self.smax, self.vmin, self.vmax)
        except CvBridgeError as e:
            rospy.logerr(e)
            return

    def update_frame(self, img, h_min, h_max, s_min, s_max, v_min, v_max):
        """图像处理与运动控制主逻辑"""
        result = img
        hsv_frame = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

        # 颜色阈值二值化
        low_color = np.array([h_min, s_min, v_min])
        high_color = np.array([h_max, s_max, v_max])
        mask_color = cv2.inRange(hsv_frame, low_color, high_color)

        # 中值滤波去噪
        mask_color = cv2.medianBlur(mask_color, 7)

        # 只保留图像下方区域，排除上方干扰
        h, w = img.shape[:2]
        search_top = 5 * h // 6
        mask_color[0:search_top, 0:w] = 0

        # 发布掩膜图像
        ros_mask_image = self.bridge.cv2_to_imgmsg(mask_color, "8UC1")
        self.image_mask_pub.publish(ros_mask_image)

        # 计算轮廓中心
        M = cv2.moments(mask_color)
        if M['m00'] > 0:
            cx = int(M['m10'] / M['m00'])
            cy = int(M['m01'] / M['m00'])

            # 计算偏差并输出速度
            err = cx - w / 2
            linear_x = 0.2
            angular_z = -float(err) / 250
            self.move_up(linear_x, 0.0, angular_z)

            # 绘制中心点
            cv2.circle(result, (cx, cy), 20, (0, 0, 255), -1)
        else:
            # 未检测到线条时停止
            self.move_up(0.0, 0.0, 0.0)

        # 发布结果图像
        ros_result_image = self.bridge.cv2_to_imgmsg(result, "bgr8")
        self.image_result_pub.publish(ros_result_image)

    def move_up(self, x, y, th):
        """发布机器人运动指令"""
        t = Twist()
        t.linear.x = x
        t.linear.y = y
        t.angular.z = th

        if self.enable_move:
            self.cmd_pub.publish(t)

    def spin(self):
        """保持节点运行"""
        rospy.spin()


if __name__ == '__main__':
    try:
        node = ImageSubscriberNode()
        node.spin()
    except rospy.ROSInterruptException:
        pass
