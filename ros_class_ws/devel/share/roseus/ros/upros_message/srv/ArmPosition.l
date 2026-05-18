;; Auto-generated. Do not edit!


(when (boundp 'upros_message::ArmPosition)
  (if (not (find-package "UPROS_MESSAGE"))
    (make-package "UPROS_MESSAGE"))
  (shadow 'ArmPosition (find-package "UPROS_MESSAGE")))
(unless (find-package "UPROS_MESSAGE::ARMPOSITION")
  (make-package "UPROS_MESSAGE::ARMPOSITION"))
(unless (find-package "UPROS_MESSAGE::ARMPOSITIONREQUEST")
  (make-package "UPROS_MESSAGE::ARMPOSITIONREQUEST"))
(unless (find-package "UPROS_MESSAGE::ARMPOSITIONRESPONSE")
  (make-package "UPROS_MESSAGE::ARMPOSITIONRESPONSE"))

(in-package "ROS")





(defclass upros_message::ArmPositionRequest
  :super ros::object
  :slots (_x _y _z ))

(defmethod upros_message::ArmPositionRequest
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _z
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass upros_message::ArmPositionResponse
  :super ros::object
  :slots (_status ))

(defmethod upros_message::ArmPositionResponse
  (:init
   (&key
    ((:status __status) 0)
    )
   (send-super :init)
   (setq _status (round __status))
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; int8 _status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _status
       (write-byte _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _status 127) (setq _status (- _status 256)))
   ;;
   self)
  )

(defclass upros_message::ArmPosition
  :super ros::object
  :slots ())

(setf (get upros_message::ArmPosition :md5sum-) "0666436500748dda2dc9db59684c43ec")
(setf (get upros_message::ArmPosition :datatype-) "upros_message/ArmPosition")
(setf (get upros_message::ArmPosition :request) upros_message::ArmPositionRequest)
(setf (get upros_message::ArmPosition :response) upros_message::ArmPositionResponse)

(defmethod upros_message::ArmPositionRequest
  (:response () (instance upros_message::ArmPositionResponse :init)))

(setf (get upros_message::ArmPositionRequest :md5sum-) "0666436500748dda2dc9db59684c43ec")
(setf (get upros_message::ArmPositionRequest :datatype-) "upros_message/ArmPositionRequest")
(setf (get upros_message::ArmPositionRequest :definition-)
      "float32 x
float32 y
float32 z
---
int8 status
")

(setf (get upros_message::ArmPositionResponse :md5sum-) "0666436500748dda2dc9db59684c43ec")
(setf (get upros_message::ArmPositionResponse :datatype-) "upros_message/ArmPositionResponse")
(setf (get upros_message::ArmPositionResponse :definition-)
      "float32 x
float32 y
float32 z
---
int8 status
")



(provide :upros_message/ArmPosition "0666436500748dda2dc9db59684c43ec")


