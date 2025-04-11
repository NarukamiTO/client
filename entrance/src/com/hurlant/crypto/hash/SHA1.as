package com.hurlant.crypto.hash {
  public class SHA1 extends SHABase implements IHash {
    public static const HASH_SIZE:int = 20;

    public function SHA1() {
      super();
    }

    override public function getHashSize() : uint {
      return HASH_SIZE;
    }

    override protected function core(param1:Array, param2:uint) : Array {
      var local10:uint = 0;
      var local11:uint = 0;
      var local12:uint = 0;
      var local13:uint = 0;
      var local14:uint = 0;
      var local15:uint = 0;
      var local16:uint = 0;
      param1[param2 >> 5] |= 128 << 24 - param2 % 32;
      param1[(param2 + 64 >> 9 << 4) + 15] = param2;
      var local3:Array = [];
      var local4:uint = 1732584193;
      var local5:uint = 4023233417;
      var local6:uint = 2562383102;
      var local7:uint = 271733878;
      var local8:uint = 3285377520;
      var local9:uint = 0;
      while(local9 < param1.length) {
        local10 = local4;
        local11 = local5;
        local12 = local6;
        local13 = local7;
        local14 = local8;
        local15 = 0;
        while(local15 < 80) {
          if(local15 < 16) {
            local3[local15] = param1[local9 + local15] || 0;
          } else {
            local3[local15] = this.rol(local3[local15 - 3] ^ local3[local15 - 8] ^ local3[local15 - 14] ^ local3[local15 - 16],1);
          }
          local16 = this.rol(local4,5) + this.ft(local15,local5,local6,local7) + local8 + local3[local15] + this.kt(local15);
          local8 = local7;
          local7 = local6;
          local6 = this.rol(local5,30);
          local5 = local4;
          local4 = local16;
          local15++;
        }
        local4 += local10;
        local5 += local11;
        local6 += local12;
        local7 += local13;
        local8 += local14;
        local9 += 16;
      }
      return [local4,local5,local6,local7,local8];
    }

    private function rol(param1:uint, param2:uint) : uint {
      return param1 << param2 | param1 >>> 32 - param2;
    }

    private function ft(param1:uint, param2:uint, param3:uint, param4:uint) : uint {
      if(param1 < 20) {
        return param2 & param3 | ~param2 & param4;
      }
      if(param1 < 40) {
        return param2 ^ param3 ^ param4;
      }
      if(param1 < 60) {
        return param2 & param3 | param2 & param4 | param3 & param4;
      }
      return param2 ^ param3 ^ param4;
    }

    private function kt(param1:uint) : uint {
      return param1 < 20 ? 1518500249 : (param1 < 40 ? 1859775393 : (param1 < 60 ? uint(2400959708) : uint(3395469782)));
    }

    override public function toString() : String {
      return "sha1";
    }
  }
}
