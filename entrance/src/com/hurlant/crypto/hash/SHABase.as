package com.hurlant.crypto.hash {
  import flash.utils.ByteArray;
  import flash.utils.Endian;

  public class SHABase implements IHash {
    public var pad_size:int = 40;

    public function SHABase() {
      super();
    }

    public function getInputSize() : uint {
      return 64;
    }

    public function getHashSize() : uint {
      return 0;
    }

    public function getPadSize() : int {
      return this.pad_size;
    }

    public function hash(param1:ByteArray) : ByteArray {
      var local2:uint = param1.length;
      var local3:String = param1.endian;
      param1.endian = Endian.BIG_ENDIAN;
      var local4:uint = local2 * 8;
      while(param1.length % 4 != 0) {
        param1[param1.length] = 0;
      }
      param1.position = 0;
      var local5:Array = [];
      var local6:uint = 0;
      while(local6 < param1.length) {
        local5.push(param1.readUnsignedInt());
        local6 += 4;
      }
      var local7:Array = this.core(local5,local4);
      var local8:ByteArray = new ByteArray();
      var local9:uint = this.getHashSize() / 4;
      local6 = 0;
      while(local6 < local9) {
        local8.writeUnsignedInt(local7[local6]);
        local6++;
      }
      param1.length = local2;
      param1.endian = local3;
      return local8;
    }

    protected function core(param1:Array, param2:uint) : Array {
      return null;
    }

    public function toString() : String {
      return "sha";
    }
  }
}
