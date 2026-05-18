;; Auto-generated. Do not edit!


(when (boundp 'upros_message::SingleServo)
  (if (not (find-package "UPROS_MESSAGE"))
    (make-package "UPROS_MESSAGE"))
  (shadow 'SingleServo (find-package "UPROS_MESSAGE")))
(unless (find-package "UPROS_MESSAGE::SINGLESERVO")
  (make-package "UPROS_MESSAGE::SINGLESERVO"))

(in-package "ROS")
;;//! \htmlinclude SingleServo.msg.html


(defclass upros_message::SingleServo
  :super ros::object
  :slots (_ID _Target_position_Angle _Rotation_Speed ))

(defmethod upros_message::SingleServo
  (:init
   (&key
    ((:ID __ID) 0)
    ((:Target_position_Angle __Target_position_Angle) 0)
    ((:Rotation_Speed __Rotation_Speed) 0)
    )
   (send-super :init)
   (setq _ID (round __ID))
   (setq _Target_position_Angle (round __Target_position_Angle))
   (setq _Rotation_Speed (round __Rotation_Speed))
   self)
  (:ID
   (&optional __ID)
   (if __ID (setq _ID __ID)) _ID)
  (:Target_position_Angle
   (&optional __Target_position_Angle)
   (if __Target_position_Angle (setq _Target_position_Angle __Target_position_Angle)) _Target_position_Angle)
  (:Rotation_Speed
   (&optional __Rotation_Speed)
   (if __Rotation_Speed (setq _Rotation_Speed __Rotation_Speed)) _Rotation_Speed)
  (:serialization-length
   ()
   (+
    ;; uint8 _ID
    1
    ;; int16 _Target_position_Angle
    2
    ;; uint16 _Rotation_Speed
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _ID
       (write-byte _ID s)
     ;; int16 _Target_position_Angle
       (write-word _Target_position_Angle s)
     ;; uint16 _Rotation_Speed
       (write-word _Rotation_Speed s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _ID
     (setq _ID (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int16 _Target_position_Angle
     (setq _Target_position_Angle (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _Rotation_Speed
     (setq _Rotation_Speed (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get upros_message::SingleServo :md5sum-) "5ef01d0888da8fe2f6daabf595b55418")
(setf (get upros_message::SingleServo :datatype-) "upros_message/SingleServo")
(setf (get upros_message::SingleServo :definition-)
      "uint8 ID
int16 Target_position_Angle
uint16 Rotation_Speed

")



(provide :upros_message/SingleServo "5ef01d0888da8fe2f6daabf595b55418")


