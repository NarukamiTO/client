package com.hurlant.crypto.symmetric {
  import com.hurlant.crypto.tls.TLSError;
  import flash.utils.ByteArray;

  public class TLSPad implements IPad {
    private var blockSize:uint;

    public function TLSPad(param1:uint = 0) {
      super();
      this.blockSize = param1;
    }

    public function pad(param1:ByteArray) : void {
      var local2:uint = this.blockSize - (param1.length + 1) % this.blockSize;
      var local3:uint = 0;
      while(local3 <= local2) {
        param1[param1.length] = local2;
        local3++;
      }
    }

    public function unpad(param1:ByteArray) : void {
      var local4:uint = 0;
      var local2:uint = param1.length % this.blockSize;
      if(local2 != 0) {
        throw new TLSError("TLSPad::unpad: ByteArray.length isn\'t a multiple of the blockSize",TLSError.bad_record_mac);
      }
      local2 = uint(param1[param1.length - 1]);
      var local3:uint = local2;
      while(local3 > 0) {
        local4 = uint(param1[param1.length - 1]);
        --param1.length;
        if(local2 != local4) {
          throw new TLSError("TLSPad:unpad: Invalid padding value. expected [" + local2 + "], found [" + local4 + "]",TLSError.bad_record_mac);
        }
        local3--;
      }
      --param1.length;
    }

    public function setBlockSize(param1:uint) : void {
      this.blockSize = param1;
    }
  }
}
