; Auto-generated. Do not edit!


(cl:in-package upros_message-msg)


;//! \htmlinclude SingleServo.msg.html

(cl:defclass <SingleServo> (roslisp-msg-protocol:ros-message)
  ((ID
    :reader ID
    :initarg :ID
    :type cl:fixnum
    :initform 0)
   (Target_position_Angle
    :reader Target_position_Angle
    :initarg :Target_position_Angle
    :type cl:fixnum
    :initform 0)
   (Rotation_Speed
    :reader Rotation_Speed
    :initarg :Rotation_Speed
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SingleServo (<SingleServo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SingleServo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SingleServo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name upros_message-msg:<SingleServo> is deprecated: use upros_message-msg:SingleServo instead.")))

(cl:ensure-generic-function 'ID-val :lambda-list '(m))
(cl:defmethod ID-val ((m <SingleServo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ID-val is deprecated.  Use upros_message-msg:ID instead.")
  (ID m))

(cl:ensure-generic-function 'Target_position_Angle-val :lambda-list '(m))
(cl:defmethod Target_position_Angle-val ((m <SingleServo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:Target_position_Angle-val is deprecated.  Use upros_message-msg:Target_position_Angle instead.")
  (Target_position_Angle m))

(cl:ensure-generic-function 'Rotation_Speed-val :lambda-list '(m))
(cl:defmethod Rotation_Speed-val ((m <SingleServo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:Rotation_Speed-val is deprecated.  Use upros_message-msg:Rotation_Speed instead.")
  (Rotation_Speed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SingleServo>) ostream)
  "Serializes a message object of type '<SingleServo>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ID)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'Target_position_Angle)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Rotation_Speed)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Rotation_Speed)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SingleServo>) istream)
  "Deserializes a message object of type '<SingleServo>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ID)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Target_position_Angle) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Rotation_Speed)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Rotation_Speed)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SingleServo>)))
  "Returns string type for a message object of type '<SingleServo>"
  "upros_message/SingleServo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SingleServo)))
  "Returns string type for a message object of type 'SingleServo"
  "upros_message/SingleServo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SingleServo>)))
  "Returns md5sum for a message object of type '<SingleServo>"
  "5ef01d0888da8fe2f6daabf595b55418")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SingleServo)))
  "Returns md5sum for a message object of type 'SingleServo"
  "5ef01d0888da8fe2f6daabf595b55418")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SingleServo>)))
  "Returns full string definition for message of type '<SingleServo>"
  (cl:format cl:nil "uint8 ID~%int16 Target_position_Angle~%uint16 Rotation_Speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SingleServo)))
  "Returns full string definition for message of type 'SingleServo"
  (cl:format cl:nil "uint8 ID~%int16 Target_position_Angle~%uint16 Rotation_Speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SingleServo>))
  (cl:+ 0
     1
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SingleServo>))
  "Converts a ROS message object to a list"
  (cl:list 'SingleServo
    (cl:cons ':ID (ID msg))
    (cl:cons ':Target_position_Angle (Target_position_Angle msg))
    (cl:cons ':Rotation_Speed (Rotation_Speed msg))
))
