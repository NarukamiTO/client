package com.hurlant.crypto.symmetric {
  import flash.utils.ByteArray;

  public class OFBMode extends IVMode implements IMode {
    public function OFBMode(param1:ISymmetricKey, param2:IPad = null) {
      super(param1,null);
    }

    public function encrypt(param1:ByteArray) : void {
      var local2:ByteArray = getIV4e();
      this.core(param1,local2);
    }

    public function decrypt(param1:ByteArray) : void {
      var local2:ByteArray = getIV4d();
      this.core(param1,local2);
    }

    private function core(param1:ByteArray, param2:ByteArray) : void {
      var local6:uint = 0;
      var local7:uint = 0;
      var local3:uint = param1.length;
      var local4:ByteArray = new ByteArray();
      var local5:uint = 0;
      while(local5 < param1.length) {
        key.encrypt(param2);
        local4.position = 0;
        local4.writeBytes(param2);
        local6 = local5 + blockSize < local3 ? blockSize : uint(local3 - local5);
        local7 = 0;
        while(local7 < local6) {
          param1[local5 + local7] ^= param2[local7];
          local7++;
        }
        param2.position = 0;
        param2.writeBytes(local4);
        local5 += blockSize;
      }
    }

    public function toString() : String {
      return key.toString() + "-ofb";
    }
  }
}
