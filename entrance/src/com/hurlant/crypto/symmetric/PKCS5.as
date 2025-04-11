package com.hurlant.crypto.symmetric {
  import flash.utils.ByteArray;

  public class PKCS5 implements IPad {
    private var blockSize:uint;

    public function PKCS5(param1:uint = 0) {
      super();
      this.blockSize = param1;
    }

    public function pad(param1:ByteArray) : void {
      var local2:uint = this.blockSize - param1.length % this.blockSize;
      var local3:uint = 0;
      while(local3 < local2) {
        param1[param1.length] = local2;
        local3++;
      }
    }

    public function unpad(param1:ByteArray) : void {
      var local4:uint = 0;
      var local2:uint = param1.length % this.blockSize;
      if(local2 != 0) {
        throw new Error("PKCS#5::unpad: ByteArray.length isn\'t a multiple of the blockSize");
      }
      local2 = uint(param1[param1.length - 1]);
      var local3:uint = local2;
      while(local3 > 0) {
        local4 = uint(param1[param1.length - 1]);
        --param1.length;
        if(local2 != local4) {
          throw new Error("PKCS#5:unpad: Invalid padding value. expected [" + local2 + "], found [" + local4 + "]");
        }
        local3--;
      }
    }

    public function setBlockSize(param1:uint) : void {
      this.blockSize = param1;
    }
  }
}
