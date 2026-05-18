;; Auto-generated. Do not edit!


(when (boundp 'upros_message::Adc)
  (if (not (find-package "UPROS_MESSAGE"))
    (make-package "UPROS_MESSAGE"))
  (shadow 'Adc (find-package "UPROS_MESSAGE")))
(unless (find-package "UPROS_MESSAGE::ADC")
  (make-package "UPROS_MESSAGE::ADC"))

(in-package "ROS")
;;//! \htmlinclude Adc.msg.html


(defclass upros_message::Adc
  :super ros::object
  :slots (_ad1 _ad2 _ad3 _ad4 _ad5 _ad6 _ad7 _ad8 _ad9 _ad10 _ad11 _ad12 ))

(defmethod upros_message::Adc
  (:init
   (&key
    ((:ad1 __ad1) 0)
    ((:ad2 __ad2) 0)
    ((:ad3 __ad3) 0)
    ((:ad4 __ad4) 0)
    ((:ad5 __ad5) 0)
    ((:ad6 __ad6) 0)
    ((:ad7 __ad7) 0)
    ((:ad8 __ad8) 0)
    ((:ad9 __ad9) 0)
    ((:ad10 __ad10) 0)
    ((:ad11 __ad11) 0)
    ((:ad12 __ad12) 0)
    )
   (send-super :init)
   (setq _ad1 (round __ad1))
   (setq _ad2 (round __ad2))
   (setq _ad3 (round __ad3))
   (setq _ad4 (round __ad4))
   (setq _ad5 (round __ad5))
   (setq _ad6 (round __ad6))
   (setq _ad7 (round __ad7))
   (setq _ad8 (round __ad8))
   (setq _ad9 (round __ad9))
   (setq _ad10 (round __ad10))
   (setq _ad11 (round __ad11))
   (setq _ad12 (round __ad12))
   self)
  (:ad1
   (&optional __ad1)
   (if __ad1 (setq _ad1 __ad1)) _ad1)
  (:ad2
   (&optional __ad2)
   (if __ad2 (setq _ad2 __ad2)) _ad2)
  (:ad3
   (&optional __ad3)
   (if __ad3 (setq _ad3 __ad3)) _ad3)
  (:ad4
   (&optional __ad4)
   (if __ad4 (setq _ad4 __ad4)) _ad4)
  (:ad5
   (&optional __ad5)
   (if __ad5 (setq _ad5 __ad5)) _ad5)
  (:ad6
   (&optional __ad6)
   (if __ad6 (setq _ad6 __ad6)) _ad6)
  (:ad7
   (&optional __ad7)
   (if __ad7 (setq _ad7 __ad7)) _ad7)
  (:ad8
   (&optional __ad8)
   (if __ad8 (setq _ad8 __ad8)) _ad8)
  (:ad9
   (&optional __ad9)
   (if __ad9 (setq _ad9 __ad9)) _ad9)
  (:ad10
   (&optional __ad10)
   (if __ad10 (setq _ad10 __ad10)) _ad10)
  (:ad11
   (&optional __ad11)
   (if __ad11 (setq _ad11 __ad11)) _ad11)
  (:ad12
   (&optional __ad12)
   (if __ad12 (setq _ad12 __ad12)) _ad12)
  (:serialization-length
   ()
   (+
    ;; int16 _ad1
    2
    ;; int16 _ad2
    2
    ;; int16 _ad3
    2
    ;; int16 _ad4
    2
    ;; int16 _ad5
    2
    ;; int16 _ad6
    2
    ;; int16 _ad7
    2
    ;; int16 _ad8
    2
    ;; int16 _ad9
    2
    ;; int16 _ad10
    2
    ;; int16 _ad11
    2
    ;; int16 _ad12
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _ad1
       (write-word _ad1 s)
     ;; int16 _ad2
       (write-word _ad2 s)
     ;; int16 _ad3
       (write-word _ad3 s)
     ;; int16 _ad4
       (write-word _ad4 s)
     ;; int16 _ad5
       (write-word _ad5 s)
     ;; int16 _ad6
       (write-word _ad6 s)
     ;; int16 _ad7
       (write-word _ad7 s)
     ;; int16 _ad8
       (write-word _ad8 s)
     ;; int16 _ad9
       (write-word _ad9 s)
     ;; int16 _ad10
       (write-word _ad10 s)
     ;; int16 _ad11
       (write-word _ad11 s)
     ;; int16 _ad12
       (write-word _ad12 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _ad1
     (setq _ad1 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad2
     (setq _ad2 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad3
     (setq _ad3 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad4
     (setq _ad4 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad5
     (setq _ad5 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad6
     (setq _ad6 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad7
     (setq _ad7 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad8
     (setq _ad8 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad9
     (setq _ad9 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad10
     (setq _ad10 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad11
     (setq _ad11 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _ad12
     (setq _ad12 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get upros_message::Adc :md5sum-) "4fa8ac5d6495ff0c6b2c630d498ca618")
(setf (get upros_message::Adc :datatype-) "upros_message/Adc")
(setf (get upros_message::Adc :definition-)
      "int16 ad1
int16 ad2
int16 ad3
int16 ad4
int16 ad5
int16 ad6
int16 ad7
int16 ad8
int16 ad9
int16 ad10
int16 ad11
int16 ad12
")



(provide :upros_message/Adc "4fa8ac5d6495ff0c6b2c630d498ca618")


