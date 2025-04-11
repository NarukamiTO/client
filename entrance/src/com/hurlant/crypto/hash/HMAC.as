package com.hurlant.crypto.hash {
  import flash.utils.ByteArray;

  public class HMAC implements IHMAC {
    private var hash:IHash;
    private var bits:uint;

    public function HMAC(param1:IHash, param2:uint = 0) {
      super();
      this.hash = param1;
      this.bits = param2;
    }

    public function getHashSize() : uint {
      if(this.bits != 0) {
        return this.bits / 8;
      }
      return this.hash.getHashSize();
    }

    public function compute(param1:ByteArray, param2:ByteArray) : ByteArray {
      var local3:ByteArray = null;
      if(param1.length > this.hash.getInputSize()) {
        local3 = this.hash.hash(param1);
      } else {
        local3 = new ByteArray();
        local3.writeBytes(param1);
      }
      while(local3.length < this.hash.getInputSize()) {
        local3[local3.length] = 0;
      }
      var local4:ByteArray = new ByteArray();
      var local5:ByteArray = new ByteArray();
      var local6:uint = 0;
      while(local6 < local3.length) {
        local4[local6] = local3[local6] ^ 0x36;
        local5[local6] = local3[local6] ^ 0x5C;
        local6++;
      }
      local4.position = local3.length;
      local4.writeBytes(param2);
      var local7:ByteArray = this.hash.hash(local4);
      local5.position = local3.length;
      local5.writeBytes(local7);
      var local8:ByteArray = this.hash.hash(local5);
      if(this.bits > 0 && this.bits < 8 * local8.length) {
        local8.length = this.bits / 8;
      }
      return local8;
    }

    public function dispose() : void {
      this.hash = null;
      this.bits = 0;
    }

    public function toString() : String {
      return "hmac-" + (this.bits > 0 ? this.bits + "-" : "") + this.hash.toString();
    }
  }
}
