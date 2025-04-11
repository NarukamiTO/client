package com.hurlant.util {
  import flash.utils.ByteArray;

  public class Hex {
    public function Hex() {
      super();
    }

    public static function toArray(param1:String) : ByteArray {
      param1 = param1.replace(/\s|:/gm,"");
      var local2:ByteArray = new ByteArray();
      if(Boolean(param1.length & 1 == 1)) {
        param1 = "0" + param1;
      }
      var local3:uint = 0;
      while(local3 < param1.length) {
        local2[local3 / 2] = parseInt(param1.substr(local3,2),16);
        local3 += 2;
      }
      return local2;
    }

    public static function fromArray(param1:ByteArray, param2:Boolean = false) : String {
      var local3:String = "";
      var local4:uint = 0;
      while(local4 < param1.length) {
        local3 += ("0" + param1[local4].toString(16)).substr(-2,2);
        if(param2) {
          if(local4 < param1.length - 1) {
            local3 += ":";
          }
        }
        local4++;
      }
      return local3;
    }

    public static function toString(param1:String) : String {
      var local2:ByteArray = toArray(param1);
      return local2.readUTFBytes(local2.length);
    }

    public static function fromString(param1:String, param2:Boolean = false) : String {
      var local3:ByteArray = new ByteArray();
      local3.writeUTFBytes(param1);
      return fromArray(local3,param2);
    }
  }
}
