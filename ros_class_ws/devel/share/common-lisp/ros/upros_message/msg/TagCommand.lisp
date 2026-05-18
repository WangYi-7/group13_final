; Auto-generated. Do not edit!


(cl:in-package upros_message-msg)


;//! \htmlinclude TagCommand.msg.html

(cl:defclass <TagCommand> (roslisp-msg-protocol:ros-message)
  ((intent
    :reader intent
    :initarg :intent
    :type cl:string
    :initform "")
   (target
    :reader target
    :initarg :target
    :type cl:integer
    :initform 0))
)

(cl:defclass TagCommand (<TagCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TagCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TagCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name upros_message-msg:<TagCommand> is deprecated: use upros_message-msg:TagCommand instead.")))

(cl:ensure-generic-function 'intent-val :lambda-list '(m))
(cl:defmethod intent-val ((m <TagCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:intent-val is deprecated.  Use upros_message-msg:intent instead.")
  (intent m))

(cl:ensure-generic-function 'target-val :lambda-list '(m))
(cl:defmethod target-val ((m <TagCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:target-val is deprecated.  Use upros_message-msg:target instead.")
  (target m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TagCommand>) ostream)
  "Serializes a message object of type '<TagCommand>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'intent))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'intent))
  (cl:let* ((signed (cl:slot-value msg 'target)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TagCommand>) istream)
  "Deserializes a message object of type '<TagCommand>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'intent) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'intent) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TagCommand>)))
  "Returns string type for a message object of type '<TagCommand>"
  "upros_message/TagCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TagCommand)))
  "Returns string type for a message object of type 'TagCommand"
  "upros_message/TagCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TagCommand>)))
  "Returns md5sum for a message object of type '<TagCommand>"
  "f5d3d8704f9102c2cbffcd5d0f7f7574")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TagCommand)))
  "Returns md5sum for a message object of type 'TagCommand"
  "f5d3d8704f9102c2cbffcd5d0f7f7574")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TagCommand>)))
  "Returns full string definition for message of type '<TagCommand>"
  (cl:format cl:nil "string intent  ~%int32 target  ~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TagCommand)))
  "Returns full string definition for message of type 'TagCommand"
  (cl:format cl:nil "string intent  ~%int32 target  ~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TagCommand>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'intent))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TagCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'TagCommand
    (cl:cons ':intent (intent msg))
    (cl:cons ':target (target msg))
))
