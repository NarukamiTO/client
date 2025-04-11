package com.hurlant.crypto.symmetric {
  import flash.utils.ByteArray;

  public class CTRMode extends IVMode implements IMode {
    public function CTRMode(param1:ISymmetricKey, param2:IPad = null) {
      super(param1,param2);
    }

    public function encrypt(param1:ByteArray) : void {
      padding.pad(param1);
      var local2:ByteArray = getIV4e();
      this.core(param1,local2);
    }

    public function decrypt(param1:ByteArray) : void {
      var local2:ByteArray = getIV4d();
      this.core(param1,local2);
      padding.unpad(param1);
    }

    private function core(param1:ByteArray, param2:ByteArray) : void {
      var local6:uint = 0;
      var local3:ByteArray = new ByteArray();
      var local4:ByteArray = new ByteArray();
      local3.writeBytes(param2);
      var local5:uint = 0;
      while(local5 < param1.length) {
        local4.position = 0;
        local4.writeBytes(local3);
        key.encrypt(local4);
        local6 = 0;
        while(local6 < blockSize) {
          param1[local5 + local6] ^= local4[local6];
          local6++;
        }
        local6 = uint(blockSize - 1);
        while(local6 >= 0) {
          ++local3[local6];
          if(local3[local6] != 0) {
            break;
          }
          local6--;
        }
        local5 += blockSize;
      }
    }

    public function toString() : String {
      return key.toString() + "-ctr";
    }
  }
}
