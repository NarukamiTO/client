package com.hurlant.crypto.symmetric {
  import flash.utils.ByteArray;

  public class CBCMode extends IVMode implements IMode {
    public function CBCMode(param1:ISymmetricKey, param2:IPad = null) {
      super(param1,param2);
    }

    public function encrypt(param1:ByteArray) : void {
      var local4:uint = 0;
      padding.pad(param1);
      var local2:ByteArray = getIV4e();
      var local3:uint = 0;
      while(local3 < param1.length) {
        local4 = 0;
        while(local4 < blockSize) {
          param1[local3 + local4] ^= local2[local4];
          local4++;
        }
        key.encrypt(param1,local3);
        local2.position = 0;
        local2.writeBytes(param1,local3,blockSize);
        local3 += blockSize;
      }
    }

    public function decrypt(param1:ByteArray) : void {
      var local5:uint = 0;
      var local2:ByteArray = getIV4d();
      var local3:ByteArray = new ByteArray();
      var local4:uint = 0;
      while(local4 < param1.length) {
        local3.position = 0;
        local3.writeBytes(param1,local4,blockSize);
        key.decrypt(param1,local4);
        local5 = 0;
        while(local5 < blockSize) {
          param1[local4 + local5] ^= local2[local5];
          local5++;
        }
        local2.position = 0;
        local2.writeBytes(local3,0,blockSize);
        local4 += blockSize;
      }
      padding.unpad(param1);
    }

    public function toString() : String {
      return key.toString() + "-cbc";
    }
  }
}
