# Install script for directory: /home/bcsh/ros_class_ws/src/upros_message

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/bcsh/ros_class_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/msg" TYPE FILE FILES
    "/home/bcsh/ros_class_ws/src/upros_message/msg/SingleServo.msg"
    "/home/bcsh/ros_class_ws/src/upros_message/msg/MultipleServo.msg"
    "/home/bcsh/ros_class_ws/src/upros_message/msg/MyMessage.msg"
    "/home/bcsh/ros_class_ws/src/upros_message/msg/TagCommand.msg"
    "/home/bcsh/ros_class_ws/src/upros_message/msg/YoloDetection.msg"
    "/home/bcsh/ros_class_ws/src/upros_message/msg/Adc.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/srv" TYPE FILE FILES
    "/home/bcsh/ros_class_ws/src/upros_message/srv/ArmPosition.srv"
    "/home/bcsh/ros_class_ws/src/upros_message/srv/MyServiceMsg.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/action" TYPE FILE FILES
    "/home/bcsh/ros_class_ws/src/upros_message/action/CoreMove.action"
    "/home/bcsh/ros_class_ws/src/upros_message/action/MyAction.action"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/msg" TYPE FILE FILES
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/CoreMoveAction.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/CoreMoveActionGoal.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/CoreMoveActionResult.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/CoreMoveActionFeedback.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/CoreMoveGoal.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/CoreMoveResult.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/CoreMoveFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/msg" TYPE FILE FILES
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/MyActionAction.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/MyActionActionGoal.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/MyActionActionResult.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/MyActionActionFeedback.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/MyActionGoal.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/MyActionResult.msg"
    "/home/bcsh/ros_class_ws/devel/share/upros_message/msg/MyActionFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/cmake" TYPE FILE FILES "/home/bcsh/ros_class_ws/build/upros_message/catkin_generated/installspace/upros_message-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/bcsh/ros_class_ws/devel/include/upros_message")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/bcsh/ros_class_ws/devel/share/roseus/ros/upros_message")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/bcsh/ros_class_ws/devel/share/common-lisp/ros/upros_message")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/bcsh/ros_class_ws/devel/share/gennodejs/ros/upros_message")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/bcsh/ros_class_ws/devel/lib/python3/dist-packages/upros_message")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/bcsh/ros_class_ws/devel/lib/python3/dist-packages/upros_message")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/upros_message" TYPE FILE FILES "/home/bcsh/ros_class_ws/devel/include/upros_message/TutorialsConfig.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/upros_message" TYPE FILE FILES "/home/bcsh/ros_class_ws/devel/lib/python3/dist-packages/upros_message/__init__.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/bcsh/ros_class_ws/devel/lib/python3/dist-packages/upros_message/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/upros_message" TYPE DIRECTORY FILES "/home/bcsh/ros_class_ws/devel/lib/python3/dist-packages/upros_message/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/bcsh/ros_class_ws/build/upros_message/catkin_generated/installspace/upros_message.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/cmake" TYPE FILE FILES "/home/bcsh/ros_class_ws/build/upros_message/catkin_generated/installspace/upros_message-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message/cmake" TYPE FILE FILES
    "/home/bcsh/ros_class_ws/build/upros_message/catkin_generated/installspace/upros_messageConfig.cmake"
    "/home/bcsh/ros_class_ws/build/upros_message/catkin_generated/installspace/upros_messageConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/upros_message" TYPE FILE FILES "/home/bcsh/ros_class_ws/src/upros_message/package.xml")
endif()

