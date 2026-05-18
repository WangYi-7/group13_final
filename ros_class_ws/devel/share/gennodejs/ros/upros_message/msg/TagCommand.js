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

class TagCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.intent = null;
      this.target = null;
    }
    else {
      if (initObj.hasOwnProperty('intent')) {
        this.intent = initObj.intent
      }
      else {
        this.intent = '';
      }
      if (initObj.hasOwnProperty('target')) {
        this.target = initObj.target
      }
      else {
        this.target = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TagCommand
    // Serialize message field [intent]
    bufferOffset = _serializer.string(obj.intent, buffer, bufferOffset);
    // Serialize message field [target]
    bufferOffset = _serializer.int32(obj.target, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TagCommand
    let len;
    let data = new TagCommand(null);
    // Deserialize message field [intent]
    data.intent = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [target]
    data.target = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.intent);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'upros_message/TagCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f5d3d8704f9102c2cbffcd5d0f7f7574';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string intent  
    int32 target  
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TagCommand(null);
    if (msg.intent !== undefined) {
      resolved.intent = msg.intent;
    }
    else {
      resolved.intent = ''
    }

    if (msg.target !== undefined) {
      resolved.target = msg.target;
    }
    else {
      resolved.target = 0
    }

    return resolved;
    }
};

module.exports = TagCommand;
