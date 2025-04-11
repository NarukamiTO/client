package com.hurlant.util.der {
  import flash.utils.ByteArray;

  public class UTCTime implements IAsn1Type {
    protected var type:uint;
    protected var len:uint;

    public var date:Date;

    public function UTCTime(param1:uint, param2:uint) {
      super();
      this.type = param1;
      this.len = param2;
    }

    public function getLength() : uint {
      return this.len;
    }

    public function getType() : uint {
      return this.type;
    }

    public function setUTCTime(param1:String) : void {
      var local2:uint = parseInt(param1.substr(0,2));
      if(local2 < 50) {
        local2 += 2000;
      } else {
        local2 += 1900;
      }
      var local3:uint = parseInt(param1.substr(2,2));
      var local4:uint = parseInt(param1.substr(4,2));
      var local5:uint = parseInt(param1.substr(6,2));
      var local6:uint = parseInt(param1.substr(8,2));
      this.date = new Date(local2,local3 - 1,local4,local5,local6);
    }

    public function toString() : String {
      return DER.indent + "UTCTime[" + this.type + "][" + this.len + "][" + this.date + "]";
    }

    public function toDER() : ByteArray {
      return null;
    }
  }
}
