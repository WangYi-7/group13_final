;; Auto-generated. Do not edit!


(when (boundp 'upros_message::MyServiceMsg)
  (if (not (find-package "UPROS_MESSAGE"))
    (make-package "UPROS_MESSAGE"))
  (shadow 'MyServiceMsg (find-package "UPROS_MESSAGE")))
(unless (find-package "UPROS_MESSAGE::MYSERVICEMSG")
  (make-package "UPROS_MESSAGE::MYSERVICEMSG"))
(unless (find-package "UPROS_MESSAGE::MYSERVICEMSGREQUEST")
  (make-package "UPROS_MESSAGE::MYSERVICEMSGREQUEST"))
(unless (find-package "UPROS_MESSAGE::MYSERVICEMSGRESPONSE")
  (make-package "UPROS_MESSAGE::MYSERVICEMSGRESPONSE"))

(in-package "ROS")





(defclass upros_message::MyServiceMsgRequest
  :super ros::object
  :slots (_input ))

(defmethod upros_message::MyServiceMsgRequest
  (:init
   (&key
    ((:input __input) 0)
    )
   (send-super :init)
   (setq _input (round __input))
   self)
  (:input
   (&optional __input)
   (if __input (setq _input __input)) _input)
  (:serialization-length
   ()
   (+
    ;; int32 _input
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _input
       (write-long _input s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _input
     (setq _input (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass upros_message::MyServiceMsgResponse
  :super ros::object
  :slots (_output ))

(defmethod upros_message::MyServiceMsgResponse
  (:init
   (&key
    ((:output __output) 0)
    )
   (send-super :init)
   (setq _output (round __output))
   self)
  (:output
   (&optional __output)
   (if __output (setq _output __output)) _output)
  (:serialization-length
   ()
   (+
    ;; int32 _output
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _output
       (write-long _output s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _output
     (setq _output (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass upros_message::MyServiceMsg
  :super ros::object
  :slots ())

(setf (get upros_message::MyServiceMsg :md5sum-) "21d8f69e8f1621953b39ae17e934f4f0")
(setf (get upros_message::MyServiceMsg :datatype-) "upros_message/MyServiceMsg")
(setf (get upros_message::MyServiceMsg :request) upros_message::MyServiceMsgRequest)
(setf (get upros_message::MyServiceMsg :response) upros_message::MyServiceMsgResponse)

(defmethod upros_message::MyServiceMsgRequest
  (:response () (instance upros_message::MyServiceMsgResponse :init)))

(setf (get upros_message::MyServiceMsgRequest :md5sum-) "21d8f69e8f1621953b39ae17e934f4f0")
(setf (get upros_message::MyServiceMsgRequest :datatype-) "upros_message/MyServiceMsgRequest")
(setf (get upros_message::MyServiceMsgRequest :definition-)
      "int32 input
---
int32 output

")

(setf (get upros_message::MyServiceMsgResponse :md5sum-) "21d8f69e8f1621953b39ae17e934f4f0")
(setf (get upros_message::MyServiceMsgResponse :datatype-) "upros_message/MyServiceMsgResponse")
(setf (get upros_message::MyServiceMsgResponse :definition-)
      "int32 input
---
int32 output

")



(provide :upros_message/MyServiceMsg "21d8f69e8f1621953b39ae17e934f4f0")


