; Auto-generated. Do not edit!


(cl:in-package upros_message-msg)


;//! \htmlinclude MultipleServo.msg.html

(cl:defclass <MultipleServo> (roslisp-msg-protocol:ros-message)
  ((servo_gather
    :reader servo_gather
    :initarg :servo_gather
    :type (cl:vector upros_message-msg:SingleServo)
   :initform (cl:make-array 0 :element-type 'upros_message-msg:SingleServo :initial-element (cl:make-instance 'upros_message-msg:SingleServo))))
)

(cl:defclass MultipleServo (<MultipleServo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MultipleServo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MultipleServo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name upros_message-msg:<MultipleServo> is deprecated: use upros_message-msg:MultipleServo instead.")))

(cl:ensure-generic-function 'servo_gather-val :lambda-list '(m))
(cl:defmethod servo_gather-val ((m <MultipleServo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:servo_gather-val is deprecated.  Use upros_message-msg:servo_gather instead.")
  (servo_gather m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MultipleServo>) ostream)
  "Serializes a message object of type '<MultipleServo>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'servo_gather))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'servo_gather))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MultipleServo>) istream)
  "Deserializes a message object of type '<MultipleServo>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'servo_gather) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'servo_gather)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'upros_message-msg:SingleServo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MultipleServo>)))
  "Returns string type for a message object of type '<MultipleServo>"
  "upros_message/MultipleServo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MultipleServo)))
  "Returns string type for a message object of type 'MultipleServo"
  "upros_message/MultipleServo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MultipleServo>)))
  "Returns md5sum for a message object of type '<MultipleServo>"
  "b0bba86e4a57a4c36bff2c5c90926b54")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MultipleServo)))
  "Returns md5sum for a message object of type 'MultipleServo"
  "b0bba86e4a57a4c36bff2c5c90926b54")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MultipleServo>)))
  "Returns full string definition for message of type '<MultipleServo>"
  (cl:format cl:nil "SingleServo[] servo_gather~%================================================================================~%MSG: upros_message/SingleServo~%uint8 ID~%int16 Target_position_Angle~%uint16 Rotation_Speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MultipleServo)))
  "Returns full string definition for message of type 'MultipleServo"
  (cl:format cl:nil "SingleServo[] servo_gather~%================================================================================~%MSG: upros_message/SingleServo~%uint8 ID~%int16 Target_position_Angle~%uint16 Rotation_Speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MultipleServo>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'servo_gather) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MultipleServo>))
  "Converts a ROS message object to a list"
  (cl:list 'MultipleServo
    (cl:cons ':servo_gather (servo_gather msg))
))
