package com.hurlant.crypto.symmetric {
  import flash.utils.ByteArray;

  public class CFB8Mode extends IVMode implements IMode {
    public function CFB8Mode(param1:ISymmetricKey, param2:IPad = null) {
      super(param1,null);
    }

    public function encrypt(param1:ByteArray) : void {
      var local5:uint = 0;
      var local2:ByteArray = getIV4e();
      var local3:ByteArray = new ByteArray();
      var local4:uint = 0;
      while(local4 < param1.length) {
        local3.position = 0;
        local3.writeBytes(local2);
        key.encrypt(local2);
        param1[local4] ^= local2[0];
        local5 = 0;
        while(local5 < blockSize - 1) {
          local2[local5] = local3[local5 + 1];
          local5++;
        }
        local2[blockSize - 1] = param1[local4];
        local4++;
      }
    }

    public function decrypt(param1:ByteArray) : void {
      var local5:uint = 0;
      var local6:uint = 0;
      var local2:ByteArray = getIV4d();
      var local3:ByteArray = new ByteArray();
      var local4:uint = 0;
      while(local4 < param1.length) {
        local5 = uint(param1[local4]);
        local3.position = 0;
        local3.writeBytes(local2);
        key.encrypt(local2);
        param1[local4] ^= local2[0];
        local6 = 0;
        while(local6 < blockSize - 1) {
          local2[local6] = local3[local6 + 1];
          local6++;
        }
        local2[blockSize - 1] = local5;
        local4++;
      }
    }

    public function toString() : String {
      return key.toString() + "-cfb8";
    }
  }
}
