;; Auto-generated. Do not edit!


(when (boundp 'upros_message::MyMessage)
  (if (not (find-package "UPROS_MESSAGE"))
    (make-package "UPROS_MESSAGE"))
  (shadow 'MyMessage (find-package "UPROS_MESSAGE")))
(unless (find-package "UPROS_MESSAGE::MYMESSAGE")
  (make-package "UPROS_MESSAGE::MYMESSAGE"))

(in-package "ROS")
;;//! \htmlinclude MyMessage.msg.html


(defclass upros_message::MyMessage
  :super ros::object
  :slots (_key _value ))

(defmethod upros_message::MyMessage
  (:init
   (&key
    ((:key __key) 0)
    ((:value __value) "")
    )
   (send-super :init)
   (setq _key (round __key))
   (setq _value (string __value))
   self)
  (:key
   (&optional __key)
   (if __key (setq _key __key)) _key)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; int32 _key
    4
    ;; string _value
    4 (length _value)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _key
       (write-long _key s)
     ;; string _value
       (write-long (length _value) s) (princ _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _key
     (setq _key (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _value
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _value (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get upros_message::MyMessage :md5sum-) "fafd3516ef178111e41c3e68d4160070")
(setf (get upros_message::MyMessage :datatype-) "upros_message/MyMessage")
(setf (get upros_message::MyMessage :definition-)
      "int32 key    # an integer field
string value   # a string field

")



(provide :upros_message/MyMessage "fafd3516ef178111e41c3e68d4160070")


