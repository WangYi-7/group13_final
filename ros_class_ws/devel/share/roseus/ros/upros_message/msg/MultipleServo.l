;; Auto-generated. Do not edit!


(when (boundp 'upros_message::MultipleServo)
  (if (not (find-package "UPROS_MESSAGE"))
    (make-package "UPROS_MESSAGE"))
  (shadow 'MultipleServo (find-package "UPROS_MESSAGE")))
(unless (find-package "UPROS_MESSAGE::MULTIPLESERVO")
  (make-package "UPROS_MESSAGE::MULTIPLESERVO"))

(in-package "ROS")
;;//! \htmlinclude MultipleServo.msg.html


(defclass upros_message::MultipleServo
  :super ros::object
  :slots (_servo_gather ))

(defmethod upros_message::MultipleServo
  (:init
   (&key
    ((:servo_gather __servo_gather) ())
    )
   (send-super :init)
   (setq _servo_gather __servo_gather)
   self)
  (:servo_gather
   (&rest __servo_gather)
   (if (keywordp (car __servo_gather))
       (send* _servo_gather __servo_gather)
     (progn
       (if __servo_gather (setq _servo_gather (car __servo_gather)))
       _servo_gather)))
  (:serialization-length
   ()
   (+
    ;; upros_message/SingleServo[] _servo_gather
    (apply #'+ (send-all _servo_gather :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; upros_message/SingleServo[] _servo_gather
     (write-long (length _servo_gather) s)
     (dolist (elem _servo_gather)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; upros_message/SingleServo[] _servo_gather
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _servo_gather (let (r) (dotimes (i n) (push (instance upros_message::SingleServo :init) r)) r))
     (dolist (elem- _servo_gather)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get upros_message::MultipleServo :md5sum-) "b0bba86e4a57a4c36bff2c5c90926b54")
(setf (get upros_message::MultipleServo :datatype-) "upros_message/MultipleServo")
(setf (get upros_message::MultipleServo :definition-)
      "SingleServo[] servo_gather
================================================================================
MSG: upros_message/SingleServo
uint8 ID
int16 Target_position_Angle
uint16 Rotation_Speed

")



(provide :upros_message/MultipleServo "b0bba86e4a57a4c36bff2c5c90926b54")


