package com.hurlant.crypto.symmetric {
  import flash.utils.ByteArray;

  public class CFBMode extends IVMode implements IMode {
    public function CFBMode(param1:ISymmetricKey, param2:IPad = null) {
      super(param1,null);
    }

    public function encrypt(param1:ByteArray) : void {
      var local5:uint = 0;
      var local6:uint = 0;
      var local2:uint = param1.length;
      var local3:ByteArray = getIV4e();
      var local4:uint = 0;
      while(local4 < param1.length) {
        key.encrypt(local3);
        local5 = local4 + blockSize < local2 ? blockSize : uint(local2 - local4);
        local6 = 0;
        while(local6 < local5) {
          param1[local4 + local6] ^= local3[local6];
          local6++;
        }
        local3.position = 0;
        local3.writeBytes(param1,local4,local5);
        local4 += blockSize;
      }
    }

    public function decrypt(param1:ByteArray) : void {
      var local6:uint = 0;
      var local7:uint = 0;
      var local2:uint = param1.length;
      var local3:ByteArray = getIV4d();
      var local4:ByteArray = new ByteArray();
      var local5:uint = 0;
      while(local5 < param1.length) {
        key.encrypt(local3);
        local6 = local5 + blockSize < local2 ? blockSize : uint(local2 - local5);
        local4.position = 0;
        local4.writeBytes(param1,local5,local6);
        local7 = 0;
        while(local7 < local6) {
          param1[local5 + local7] ^= local3[local7];
          local7++;
        }
        local3.position = 0;
        local3.writeBytes(local4);
        local5 += blockSize;
      }
    }

    public function toString() : String {
      return key.toString() + "-cfb";
    }
  }
}
