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

class Adc {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ad1 = null;
      this.ad2 = null;
      this.ad3 = null;
      this.ad4 = null;
      this.ad5 = null;
      this.ad6 = null;
      this.ad7 = null;
      this.ad8 = null;
      this.ad9 = null;
      this.ad10 = null;
      this.ad11 = null;
      this.ad12 = null;
    }
    else {
      if (initObj.hasOwnProperty('ad1')) {
        this.ad1 = initObj.ad1
      }
      else {
        this.ad1 = 0;
      }
      if (initObj.hasOwnProperty('ad2')) {
        this.ad2 = initObj.ad2
      }
      else {
        this.ad2 = 0;
      }
      if (initObj.hasOwnProperty('ad3')) {
        this.ad3 = initObj.ad3
      }
      else {
        this.ad3 = 0;
      }
      if (initObj.hasOwnProperty('ad4')) {
        this.ad4 = initObj.ad4
      }
      else {
        this.ad4 = 0;
      }
      if (initObj.hasOwnProperty('ad5')) {
        this.ad5 = initObj.ad5
      }
      else {
        this.ad5 = 0;
      }
      if (initObj.hasOwnProperty('ad6')) {
        this.ad6 = initObj.ad6
      }
      else {
        this.ad6 = 0;
      }
      if (initObj.hasOwnProperty('ad7')) {
        this.ad7 = initObj.ad7
      }
      else {
        this.ad7 = 0;
      }
      if (initObj.hasOwnProperty('ad8')) {
        this.ad8 = initObj.ad8
      }
      else {
        this.ad8 = 0;
      }
      if (initObj.hasOwnProperty('ad9')) {
        this.ad9 = initObj.ad9
      }
      else {
        this.ad9 = 0;
      }
      if (initObj.hasOwnProperty('ad10')) {
        this.ad10 = initObj.ad10
      }
      else {
        this.ad10 = 0;
      }
      if (initObj.hasOwnProperty('ad11')) {
        this.ad11 = initObj.ad11
      }
      else {
        this.ad11 = 0;
      }
      if (initObj.hasOwnProperty('ad12')) {
        this.ad12 = initObj.ad12
      }
      else {
        this.ad12 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Adc
    // Serialize message field [ad1]
    bufferOffset = _serializer.int16(obj.ad1, buffer, bufferOffset);
    // Serialize message field [ad2]
    bufferOffset = _serializer.int16(obj.ad2, buffer, bufferOffset);
    // Serialize message field [ad3]
    bufferOffset = _serializer.int16(obj.ad3, buffer, bufferOffset);
    // Serialize message field [ad4]
    bufferOffset = _serializer.int16(obj.ad4, buffer, bufferOffset);
    // Serialize message field [ad5]
    bufferOffset = _serializer.int16(obj.ad5, buffer, bufferOffset);
    // Serialize message field [ad6]
    bufferOffset = _serializer.int16(obj.ad6, buffer, bufferOffset);
    // Serialize message field [ad7]
    bufferOffset = _serializer.int16(obj.ad7, buffer, bufferOffset);
    // Serialize message field [ad8]
    bufferOffset = _serializer.int16(obj.ad8, buffer, bufferOffset);
    // Serialize message field [ad9]
    bufferOffset = _serializer.int16(obj.ad9, buffer, bufferOffset);
    // Serialize message field [ad10]
    bufferOffset = _serializer.int16(obj.ad10, buffer, bufferOffset);
    // Serialize message field [ad11]
    bufferOffset = _serializer.int16(obj.ad11, buffer, bufferOffset);
    // Serialize message field [ad12]
    bufferOffset = _serializer.int16(obj.ad12, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Adc
    let len;
    let data = new Adc(null);
    // Deserialize message field [ad1]
    data.ad1 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad2]
    data.ad2 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad3]
    data.ad3 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad4]
    data.ad4 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad5]
    data.ad5 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad6]
    data.ad6 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad7]
    data.ad7 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad8]
    data.ad8 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad9]
    data.ad9 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad10]
    data.ad10 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad11]
    data.ad11 = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [ad12]
    data.ad12 = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'upros_message/Adc';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4fa8ac5d6495ff0c6b2c630d498ca618';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int16 ad1
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
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Adc(null);
    if (msg.ad1 !== undefined) {
      resolved.ad1 = msg.ad1;
    }
    else {
      resolved.ad1 = 0
    }

    if (msg.ad2 !== undefined) {
      resolved.ad2 = msg.ad2;
    }
    else {
      resolved.ad2 = 0
    }

    if (msg.ad3 !== undefined) {
      resolved.ad3 = msg.ad3;
    }
    else {
      resolved.ad3 = 0
    }

    if (msg.ad4 !== undefined) {
      resolved.ad4 = msg.ad4;
    }
    else {
      resolved.ad4 = 0
    }

    if (msg.ad5 !== undefined) {
      resolved.ad5 = msg.ad5;
    }
    else {
      resolved.ad5 = 0
    }

    if (msg.ad6 !== undefined) {
      resolved.ad6 = msg.ad6;
    }
    else {
      resolved.ad6 = 0
    }

    if (msg.ad7 !== undefined) {
      resolved.ad7 = msg.ad7;
    }
    else {
      resolved.ad7 = 0
    }

    if (msg.ad8 !== undefined) {
      resolved.ad8 = msg.ad8;
    }
    else {
      resolved.ad8 = 0
    }

    if (msg.ad9 !== undefined) {
      resolved.ad9 = msg.ad9;
    }
    else {
      resolved.ad9 = 0
    }

    if (msg.ad10 !== undefined) {
      resolved.ad10 = msg.ad10;
    }
    else {
      resolved.ad10 = 0
    }

    if (msg.ad11 !== undefined) {
      resolved.ad11 = msg.ad11;
    }
    else {
      resolved.ad11 = 0
    }

    if (msg.ad12 !== undefined) {
      resolved.ad12 = msg.ad12;
    }
    else {
      resolved.ad12 = 0
    }

    return resolved;
    }
};

module.exports = Adc;
