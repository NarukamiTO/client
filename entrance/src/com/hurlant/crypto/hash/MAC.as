package com.hurlant.crypto.hash {
  import flash.utils.ByteArray;

  public class MAC implements IHMAC {
    private var hash:IHash;
    private var bits:uint;
    private var pad_1:ByteArray;
    private var pad_2:ByteArray;
    private var innerHash:ByteArray;
    private var outerHash:ByteArray;
    private var outerKey:ByteArray;
    private var innerKey:ByteArray;

    public function MAC(param1:IHash, param2:uint = 0) {
      var local3:int = 0;
      var local4:int = 0;
      super();
      this.hash = param1;
      this.bits = param2;
      this.innerHash = new ByteArray();
      this.outerHash = new ByteArray();
      this.innerKey = new ByteArray();
      this.outerKey = new ByteArray();
      if(param1 != null) {
        local3 = param1.getPadSize();
        this.pad_1 = new ByteArray();
        this.pad_2 = new ByteArray();
        local4 = 0;
        while(local4 < local3) {
          this.pad_1.writeByte(54);
          this.pad_2.writeByte(92);
          local4++;
        }
      }
    }

    public function setPadSize(param1:int) : void {
    }

    public function getHashSize() : uint {
      if(this.bits != 0) {
        return this.bits / 8;
      }
      return this.hash.getHashSize();
    }

    public function compute(param1:ByteArray, param2:ByteArray) : ByteArray {
      var local3:int = 0;
      var local4:int = 0;
      if(this.pad_1 == null) {
        local3 = this.hash.getPadSize();
        this.pad_1 = new ByteArray();
        this.pad_2 = new ByteArray();
        local4 = 0;
        while(local4 < local3) {
          this.pad_1.writeByte(54);
          this.pad_2.writeByte(92);
          local4++;
        }
      }
      this.innerKey.length = 0;
      this.outerKey.length = 0;
      this.innerKey.writeBytes(param1);
      this.innerKey.writeBytes(this.pad_1);
      this.innerKey.writeBytes(param2);
      this.innerHash = this.hash.hash(this.innerKey);
      this.outerKey.writeBytes(param1);
      this.outerKey.writeBytes(this.pad_2);
      this.outerKey.writeBytes(this.innerHash);
      this.outerHash = this.hash.hash(this.outerKey);
      if(this.bits > 0 && this.bits < 8 * this.outerHash.length) {
        this.outerHash.length = this.bits / 8;
      }
      return this.outerHash;
    }

    public function dispose() : void {
      this.hash = null;
      this.bits = 0;
    }

    public function toString() : String {
      return "mac-" + (this.bits > 0 ? this.bits + "-" : "") + this.hash.toString();
    }
  }
}
