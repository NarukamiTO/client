package com.hurlant.crypto.symmetric {
  import com.hurlant.crypto.prng.Random;
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;

  public class XTeaKey implements ISymmetricKey {
    public const NUM_ROUNDS:uint = 64;

    private var k:Array;

    public function XTeaKey(param1:ByteArray) {
      super();
      param1.position = 0;
      this.k = [param1.readUnsignedInt(),param1.readUnsignedInt(),param1.readUnsignedInt(),param1.readUnsignedInt()];
    }

    public static function parseKey(param1:String) : XTeaKey {
      var local2:ByteArray = new ByteArray();
      local2.writeUnsignedInt(parseInt(param1.substr(0,8),16));
      local2.writeUnsignedInt(parseInt(param1.substr(8,8),16));
      local2.writeUnsignedInt(parseInt(param1.substr(16,8),16));
      local2.writeUnsignedInt(parseInt(param1.substr(24,8),16));
      local2.position = 0;
      return new XTeaKey(local2);
    }

    public function getBlockSize() : uint {
      return 8;
    }

    public function encrypt(param1:ByteArray, param2:uint = 0) : void {
      var local5:uint = 0;
      param1.position = param2;
      var local3:uint = param1.readUnsignedInt();
      var local4:uint = param1.readUnsignedInt();
      var local6:uint = 0;
      var local7:uint = 2654435769;
      local5 = 0;
      while(local5 < this.NUM_ROUNDS) {
        local3 += (local4 << 4 ^ local4 >> 5) + local4 ^ local6 + this.k[local6 & 3];
        local6 += local7;
        local4 += (local3 << 4 ^ local3 >> 5) + local3 ^ local6 + this.k[local6 >> 11 & 3];
        local5++;
      }
      param1.position -= 8;
      param1.writeUnsignedInt(local3);
      param1.writeUnsignedInt(local4);
    }

    public function decrypt(param1:ByteArray, param2:uint = 0) : void {
      var local5:uint = 0;
      param1.position = param2;
      var local3:uint = param1.readUnsignedInt();
      var local4:uint = param1.readUnsignedInt();
      var local6:uint = 2654435769;
      var local7:uint = local6 * this.NUM_ROUNDS;
      local5 = 0;
      while(local5 < this.NUM_ROUNDS) {
        local4 -= (local3 << 4 ^ local3 >> 5) + local3 ^ local7 + this.k[local7 >> 11 & 3];
        local7 -= local6;
        local3 -= (local4 << 4 ^ local4 >> 5) + local4 ^ local7 + this.k[local7 & 3];
        local5++;
      }
      param1.position -= 8;
      param1.writeUnsignedInt(local3);
      param1.writeUnsignedInt(local4);
    }

    public function dispose() : void {
      var local1:Random = new Random();
      var local2:uint = 0;
      while(local2 < this.k.length) {
        this.k[local2] = local1.nextByte();
        delete this.k[local2];
        local2++;
      }
      this.k = null;
      Memory.gc();
    }

    public function toString() : String {
      return "xtea";
    }
  }
}
