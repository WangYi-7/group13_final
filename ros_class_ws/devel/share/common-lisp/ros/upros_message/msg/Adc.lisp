; Auto-generated. Do not edit!


(cl:in-package upros_message-msg)


;//! \htmlinclude Adc.msg.html

(cl:defclass <Adc> (roslisp-msg-protocol:ros-message)
  ((ad1
    :reader ad1
    :initarg :ad1
    :type cl:fixnum
    :initform 0)
   (ad2
    :reader ad2
    :initarg :ad2
    :type cl:fixnum
    :initform 0)
   (ad3
    :reader ad3
    :initarg :ad3
    :type cl:fixnum
    :initform 0)
   (ad4
    :reader ad4
    :initarg :ad4
    :type cl:fixnum
    :initform 0)
   (ad5
    :reader ad5
    :initarg :ad5
    :type cl:fixnum
    :initform 0)
   (ad6
    :reader ad6
    :initarg :ad6
    :type cl:fixnum
    :initform 0)
   (ad7
    :reader ad7
    :initarg :ad7
    :type cl:fixnum
    :initform 0)
   (ad8
    :reader ad8
    :initarg :ad8
    :type cl:fixnum
    :initform 0)
   (ad9
    :reader ad9
    :initarg :ad9
    :type cl:fixnum
    :initform 0)
   (ad10
    :reader ad10
    :initarg :ad10
    :type cl:fixnum
    :initform 0)
   (ad11
    :reader ad11
    :initarg :ad11
    :type cl:fixnum
    :initform 0)
   (ad12
    :reader ad12
    :initarg :ad12
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Adc (<Adc>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Adc>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Adc)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name upros_message-msg:<Adc> is deprecated: use upros_message-msg:Adc instead.")))

(cl:ensure-generic-function 'ad1-val :lambda-list '(m))
(cl:defmethod ad1-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad1-val is deprecated.  Use upros_message-msg:ad1 instead.")
  (ad1 m))

(cl:ensure-generic-function 'ad2-val :lambda-list '(m))
(cl:defmethod ad2-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad2-val is deprecated.  Use upros_message-msg:ad2 instead.")
  (ad2 m))

(cl:ensure-generic-function 'ad3-val :lambda-list '(m))
(cl:defmethod ad3-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad3-val is deprecated.  Use upros_message-msg:ad3 instead.")
  (ad3 m))

(cl:ensure-generic-function 'ad4-val :lambda-list '(m))
(cl:defmethod ad4-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad4-val is deprecated.  Use upros_message-msg:ad4 instead.")
  (ad4 m))

(cl:ensure-generic-function 'ad5-val :lambda-list '(m))
(cl:defmethod ad5-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad5-val is deprecated.  Use upros_message-msg:ad5 instead.")
  (ad5 m))

(cl:ensure-generic-function 'ad6-val :lambda-list '(m))
(cl:defmethod ad6-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad6-val is deprecated.  Use upros_message-msg:ad6 instead.")
  (ad6 m))

(cl:ensure-generic-function 'ad7-val :lambda-list '(m))
(cl:defmethod ad7-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad7-val is deprecated.  Use upros_message-msg:ad7 instead.")
  (ad7 m))

(cl:ensure-generic-function 'ad8-val :lambda-list '(m))
(cl:defmethod ad8-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad8-val is deprecated.  Use upros_message-msg:ad8 instead.")
  (ad8 m))

(cl:ensure-generic-function 'ad9-val :lambda-list '(m))
(cl:defmethod ad9-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad9-val is deprecated.  Use upros_message-msg:ad9 instead.")
  (ad9 m))

(cl:ensure-generic-function 'ad10-val :lambda-list '(m))
(cl:defmethod ad10-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad10-val is deprecated.  Use upros_message-msg:ad10 instead.")
  (ad10 m))

(cl:ensure-generic-function 'ad11-val :lambda-list '(m))
(cl:defmethod ad11-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad11-val is deprecated.  Use upros_message-msg:ad11 instead.")
  (ad11 m))

(cl:ensure-generic-function 'ad12-val :lambda-list '(m))
(cl:defmethod ad12-val ((m <Adc>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader upros_message-msg:ad12-val is deprecated.  Use upros_message-msg:ad12 instead.")
  (ad12 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Adc>) ostream)
  "Serializes a message object of type '<Adc>"
  (cl:let* ((signed (cl:slot-value msg 'ad1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad3)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad4)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad5)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad6)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad7)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad8)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad9)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad10)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad11)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ad12)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Adc>) istream)
  "Deserializes a message object of type '<Adc>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad1) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad2) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad3) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad4) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad5) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad6) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad7) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad8) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad9) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad10) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad11) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ad12) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Adc>)))
  "Returns string type for a message object of type '<Adc>"
  "upros_message/Adc")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Adc)))
  "Returns string type for a message object of type 'Adc"
  "upros_message/Adc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Adc>)))
  "Returns md5sum for a message object of type '<Adc>"
  "4fa8ac5d6495ff0c6b2c630d498ca618")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Adc)))
  "Returns md5sum for a message object of type 'Adc"
  "4fa8ac5d6495ff0c6b2c630d498ca618")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Adc>)))
  "Returns full string definition for message of type '<Adc>"
  (cl:format cl:nil "int16 ad1~%int16 ad2~%int16 ad3~%int16 ad4~%int16 ad5~%int16 ad6~%int16 ad7~%int16 ad8~%int16 ad9~%int16 ad10~%int16 ad11~%int16 ad12~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Adc)))
  "Returns full string definition for message of type 'Adc"
  (cl:format cl:nil "int16 ad1~%int16 ad2~%int16 ad3~%int16 ad4~%int16 ad5~%int16 ad6~%int16 ad7~%int16 ad8~%int16 ad9~%int16 ad10~%int16 ad11~%int16 ad12~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Adc>))
  (cl:+ 0
     2
     2
     2
     2
     2
     2
     2
     2
     2
     2
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Adc>))
  "Converts a ROS message object to a list"
  (cl:list 'Adc
    (cl:cons ':ad1 (ad1 msg))
    (cl:cons ':ad2 (ad2 msg))
    (cl:cons ':ad3 (ad3 msg))
    (cl:cons ':ad4 (ad4 msg))
    (cl:cons ':ad5 (ad5 msg))
    (cl:cons ':ad6 (ad6 msg))
    (cl:cons ':ad7 (ad7 msg))
    (cl:cons ':ad8 (ad8 msg))
    (cl:cons ':ad9 (ad9 msg))
    (cl:cons ':ad10 (ad10 msg))
    (cl:cons ':ad11 (ad11 msg))
    (cl:cons ':ad12 (ad12 msg))
))
