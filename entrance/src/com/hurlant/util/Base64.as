package com.hurlant.util {
  import flash.utils.ByteArray;

  public class Base64 {
    private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    public static const version:String = "1.0.0";

    public function Base64() {
      super();
      throw new Error("Base64 class is static container only");
    }

    public static function encode(param1:String) : String {
      var local2:ByteArray = new ByteArray();
      local2.writeUTFBytes(param1);
      return encodeByteArray(local2);
    }

    public static function encodeByteArray(param1:ByteArray) : String {
      var local3:Array = null;
      var local5:uint = 0;
      var local6:uint = 0;
      var local7:uint = 0;
      var local2:String = "";
      var local4:Array = new Array(4);
      param1.position = 0;
      while(param1.bytesAvailable > 0) {
        local3 = new Array();
        local5 = 0;
        while(local5 < 3 && param1.bytesAvailable > 0) {
          local3[local5] = param1.readUnsignedByte();
          local5++;
        }
        local4[0] = (local3[0] & 0xFC) >> 2;
        local4[1] = (local3[0] & 3) << 4 | local3[1] >> 4;
        local4[2] = (local3[1] & 0x0F) << 2 | local3[2] >> 6;
        local4[3] = local3[2] & 0x3F;
        local6 = local3.length;
        while(local6 < 3) {
          local4[local6 + 1] = 64;
          local6++;
        }
        local7 = 0;
        while(local7 < local4.length) {
          local2 += BASE64_CHARS.charAt(local4[local7]);
          local7++;
        }
      }
      return local2;
    }

    public static function decode(param1:String) : String {
      var local2:ByteArray = decodeToByteArrayB(param1);
      return local2.readUTFBytes(local2.length);
    }

    public static function decodeToByteArray(param1:String) : ByteArray {
      var local6:uint = 0;
      var local7:uint = 0;
      var local2:ByteArray = new ByteArray();
      var local3:Array = new Array(4);
      var local4:Array = new Array(3);
      var local5:uint = 0;
      while(local5 < param1.length) {
        local6 = 0;
        while(local6 < 4 && local5 + local6 < param1.length) {
          local3[local6] = BASE64_CHARS.indexOf(param1.charAt(local5 + local6));
          local6++;
        }
        local4[0] = (local3[0] << 2) + ((local3[1] & 0x30) >> 4);
        local4[1] = ((local3[1] & 0x0F) << 4) + ((local3[2] & 0x3C) >> 2);
        local4[2] = ((local3[2] & 3) << 6) + local3[3];
        local7 = 0;
        while(local7 < local4.length) {
          if(local3[local7 + 1] == 64) {
            break;
          }
          local2.writeByte(local4[local7]);
          local7++;
        }
        local5 += 4;
      }
      local2.position = 0;
      return local2;
    }

    public static function decodeToByteArrayB(param1:String) : ByteArray {
      var local6:uint = 0;
      var local7:uint = 0;
      var local2:ByteArray = new ByteArray();
      var local3:Array = new Array(4);
      var local4:Array = new Array(3);
      var local5:uint = 0;
      while(local5 < param1.length) {
        local6 = 0;
        while(local6 < 4 && local5 + local6 < param1.length) {
          local3[local6] = BASE64_CHARS.indexOf(param1.charAt(local5 + local6));
          while(local3[local6] < 0 && local5 < param1.length) {
            local5++;
            local3[local6] = BASE64_CHARS.indexOf(param1.charAt(local5 + local6));
          }
          local6++;
        }
        local4[0] = (local3[0] << 2) + ((local3[1] & 0x30) >> 4);
        local4[1] = ((local3[1] & 0x0F) << 4) + ((local3[2] & 0x3C) >> 2);
        local4[2] = ((local3[2] & 3) << 6) + local3[3];
        local7 = 0;
        while(local7 < local4.length) {
          if(local3[local7 + 1] == 64) {
            break;
          }
          local2.writeByte(local4[local7]);
          local7++;
        }
        local5 += 4;
      }
      local2.position = 0;
      return local2;
    }
  }
}
