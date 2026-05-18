// Auto-generated. Do not edit!

// (in-package upros_message.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class SingleServo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ID = null;
      this.Target_position_Angle = null;
      this.Rotation_Speed = null;
    }
    else {
      if (initObj.hasOwnProperty('ID')) {
        this.ID = initObj.ID
      }
      else {
        this.ID = 0;
      }
      if (initObj.hasOwnProperty('Target_position_Angle')) {
        this.Target_position_Angle = initObj.Target_position_Angle
      }
      else {
        this.Target_position_Angle = 0;
      }
      if (initObj.hasOwnProperty('Rotation_Speed')) {
        this.Rotation_Speed = initObj.Rotation_Speed
      }
      else {
        this.Rotation_Speed = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SingleServo
    // Serialize message field [ID]
    bufferOffset = _serializer.uint8(obj.ID, buffer, bufferOffset);
    // Serialize message field [Target_position_Angle]
    bufferOffset = _serializer.int16(obj.Target_position_Angle, buffer, bufferOffset);
    // Serialize message field [Rotation_Speed]
    bufferOffset = _serializer.uint16(obj.Rotation_Speed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SingleServo
    let len;
    let data = new SingleServo(null);
    // Deserialize message field [ID]
    data.ID = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [Target_position_Angle]
    data.Target_position_Angle = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [Rotation_Speed]
    data.Rotation_Speed = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'upros_message/SingleServo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5ef01d0888da8fe2f6daabf595b55418';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 ID
    int16 Target_position_Angle
    uint16 Rotation_Speed
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SingleServo(null);
    if (msg.ID !== undefined) {
      resolved.ID = msg.ID;
    }
    else {
      resolved.ID = 0
    }

    if (msg.Target_position_Angle !== undefined) {
      resolved.Target_position_Angle = msg.Target_position_Angle;
    }
    else {
      resolved.Target_position_Angle = 0
    }

    if (msg.Rotation_Speed !== undefined) {
      resolved.Rotation_Speed = msg.Rotation_Speed;
    }
    else {
      resolved.Rotation_Speed = 0
    }

    return resolved;
    }
};

module.exports = SingleServo;
