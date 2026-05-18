;; Auto-generated. Do not edit!


(when (boundp 'upros_message::TagCommand)
  (if (not (find-package "UPROS_MESSAGE"))
    (make-package "UPROS_MESSAGE"))
  (shadow 'TagCommand (find-package "UPROS_MESSAGE")))
(unless (find-package "UPROS_MESSAGE::TAGCOMMAND")
  (make-package "UPROS_MESSAGE::TAGCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude TagCommand.msg.html


(defclass upros_message::TagCommand
  :super ros::object
  :slots (_intent _target ))

(defmethod upros_message::TagCommand
  (:init
   (&key
    ((:intent __intent) "")
    ((:target __target) 0)
    )
   (send-super :init)
   (setq _intent (string __intent))
   (setq _target (round __target))
   self)
  (:intent
   (&optional __intent)
   (if __intent (setq _intent __intent)) _intent)
  (:target
   (&optional __target)
   (if __target (setq _target __target)) _target)
  (:serialization-length
   ()
   (+
    ;; string _intent
    4 (length _intent)
    ;; int32 _target
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _intent
       (write-long (length _intent) s) (princ _intent s)
     ;; int32 _target
       (write-long _target s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _intent
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _intent (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _target
     (setq _target (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get upros_message::TagCommand :md5sum-) "f5d3d8704f9102c2cbffcd5d0f7f7574")
(setf (get upros_message::TagCommand :datatype-) "upros_message/TagCommand")
(setf (get upros_message::TagCommand :definition-)
      "string intent  
int32 target  
")



(provide :upros_message/TagCommand "f5d3d8704f9102c2cbffcd5d0f7f7574")


