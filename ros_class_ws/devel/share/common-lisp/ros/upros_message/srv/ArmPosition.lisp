; Auto-generated. Do not edit!


(cl:in-package upros_message-srv)


;//! \htmlinclude ArmPosition-request.msg.html

(cl:defclass <ArmPosition-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0))
)

(cl:defclass ArmPosition-request (<ArmPosition-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ArmPosition-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ArmPosition-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name upros_message-srv:<ArmPosition-request> is deprecated: use upros_message-srv:ArmPosition-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <ArmPosition-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-srv:x-val is deprecated.  Use upros_message-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <ArmPosition-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-srv:y-val is deprecated.  Use upros_message-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <ArmPosition-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-srv:z-val is deprecated.  Use upros_message-srv:z instead.")
  (z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ArmPosition-request>) ostream)
  "Serializes a message object of type '<ArmPosition-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ArmPosition-request>) istream)
  "Deserializes a message object of type '<ArmPosition-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ArmPosition-request>)))
  "Returns string type for a service object of type '<ArmPosition-request>"
  "upros_message/ArmPositionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArmPosition-request)))
  "Returns string type for a service object of type 'ArmPosition-request"
  "upros_message/ArmPositionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ArmPosition-request>)))
  "Returns md5sum for a message object of type '<ArmPosition-request>"
  "0666436500748dda2dc9db59684c43ec")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ArmPosition-request)))
  "Returns md5sum for a message object of type 'ArmPosition-request"
  "0666436500748dda2dc9db59684c43ec")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ArmPosition-request>)))
  "Returns full string definition for message of type '<ArmPosition-request>"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ArmPosition-request)))
  "Returns full string definition for message of type 'ArmPosition-request"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ArmPosition-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ArmPosition-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ArmPosition-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
))
;//! \htmlinclude ArmPosition-response.msg.html

(cl:defclass <ArmPosition-response> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ArmPosition-response (<ArmPosition-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ArmPosition-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ArmPosition-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name upros_message-srv:<ArmPosition-response> is deprecated: use upros_message-srv:ArmPosition-response instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <ArmPosition-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-srv:status-val is deprecated.  Use upros_message-srv:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ArmPosition-response>) ostream)
  "Serializes a message object of type '<ArmPosition-response>"
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ArmPosition-response>) istream)
  "Deserializes a message object of type '<ArmPosition-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ArmPosition-response>)))
  "Returns string type for a service object of type '<ArmPosition-response>"
  "upros_message/ArmPositionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArmPosition-response)))
  "Returns string type for a service object of type 'ArmPosition-response"
  "upros_message/ArmPositionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ArmPosition-response>)))
  "Returns md5sum for a message object of type '<ArmPosition-response>"
  "0666436500748dda2dc9db59684c43ec")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ArmPosition-response)))
  "Returns md5sum for a message object of type 'ArmPosition-response"
  "0666436500748dda2dc9db59684c43ec")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ArmPosition-response>)))
  "Returns full string definition for message of type '<ArmPosition-response>"
  (cl:format cl:nil "int8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ArmPosition-response)))
  "Returns full string definition for message of type 'ArmPosition-response"
  (cl:format cl:nil "int8 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ArmPosition-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ArmPosition-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ArmPosition-response
    (cl:cons ':status (status msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ArmPosition)))
  'ArmPosition-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ArmPosition)))
  'ArmPosition-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArmPosition)))
  "Returns string type for a service object of type '<ArmPosition>"
  "upros_message/ArmPosition")