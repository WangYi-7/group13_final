// Auto-generated. Do not edit!

// (in-package upros_message.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SingleServo = require('./SingleServo.js');

//-----------------------------------------------------------

class MultipleServo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.servo_gather = null;
    }
    else {
      if (initObj.hasOwnProperty('servo_gather')) {
        this.servo_gather = initObj.servo_gather
      }
      else {
        this.servo_gather = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MultipleServo
    // Serialize message field [servo_gather]
    // Serialize the length for message field [servo_gather]
    bufferOffset = _serializer.uint32(obj.servo_gather.length, buffer, bufferOffset);
    obj.servo_gather.forEach((val) => {
      bufferOffset = SingleServo.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MultipleServo
    let len;
    let data = new MultipleServo(null);
    // Deserialize message field [servo_gather]
    // Deserialize array length for message field [servo_gather]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.servo_gather = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.servo_gather[i] = SingleServo.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 5 * object.servo_gather.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'upros_message/MultipleServo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b0bba86e4a57a4c36bff2c5c90926b54';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    SingleServo[] servo_gather
    ================================================================================
    MSG: upros_message/SingleServo
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
    const resolved = new MultipleServo(null);
    if (msg.servo_gather !== undefined) {
      resolved.servo_gather = new Array(msg.servo_gather.length);
      for (let i = 0; i < resolved.servo_gather.length; ++i) {
        resolved.servo_gather[i] = SingleServo.Resolve(msg.servo_gather[i]);
      }
    }
    else {
      resolved.servo_gather = []
    }

    return resolved;
    }
};

module.exports = MultipleServo;
