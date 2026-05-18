
(cl:in-package :asdf)

(defsystem "upros_message-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ArmPosition" :depends-on ("_package_ArmPosition"))
    (:file "_package_ArmPosition" :depends-on ("_package"))
    (:file "MyServiceMsg" :depends-on ("_package_MyServiceMsg"))
    (:file "_package_MyServiceMsg" :depends-on ("_package"))
  ))