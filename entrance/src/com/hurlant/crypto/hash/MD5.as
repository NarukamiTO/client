package com.hurlant.crypto.hash {
  import flash.utils.ByteArray;
  import flash.utils.Endian;

  public class MD5 implements IHash {
    public static const HASH_SIZE:int = 16;

    public var pad_size:int = 48;

    public function MD5() {
      super();
    }

    public function getInputSize() : uint {
      return 64;
    }

    public function getHashSize() : uint {
      return HASH_SIZE;
    }

    public function getPadSize() : int {
      return this.pad_size;
    }

    public function hash(param1:ByteArray) : ByteArray {
      var local2:uint = param1.length * 8;
      var local3:String = param1.endian;
      while(param1.length % 4 != 0) {
        param1[param1.length] = 0;
      }
      param1.position = 0;
      var local4:Array = [];
      param1.endian = Endian.LITTLE_ENDIAN;
      var local5:uint = 0;
      while(local5 < param1.length) {
        local4.push(param1.readUnsignedInt());
        local5 += 4;
      }
      var local6:Array = this.core_md5(local4,local2);
      var local7:ByteArray = new ByteArray();
      local7.endian = Endian.LITTLE_ENDIAN;
      local5 = 0;
      while(local5 < 4) {
        local7.writeUnsignedInt(local6[local5]);
        local5++;
      }
      param1.length = local2 / 8;
      param1.endian = local3;
      return local7;
    }

    private function core_md5(param1:Array, param2:uint) : Array {
      var local8:uint = 0;
      var local9:uint = 0;
      var local10:uint = 0;
      var local11:uint = 0;
      param1[param2 >> 5] |= 128 << param2 % 32;
      param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
      var local3:uint = 1732584193;
      var local4:uint = 4023233417;
      var local5:uint = 2562383102;
      var local6:uint = 271733878;
      var local7:uint = 0;
      while(local7 < param1.length) {
        param1[local7] = param1[local7] || 0;
        param1[local7 + 1] = param1[local7 + 1] || 0;
        param1[local7 + 2] = param1[local7 + 2] || 0;
        param1[local7 + 3] = param1[local7 + 3] || 0;
        param1[local7 + 4] = param1[local7 + 4] || 0;
        param1[local7 + 5] = param1[local7 + 5] || 0;
        param1[local7 + 6] = param1[local7 + 6] || 0;
        param1[local7 + 7] = param1[local7 + 7] || 0;
        param1[local7 + 8] = param1[local7 + 8] || 0;
        param1[local7 + 9] = param1[local7 + 9] || 0;
        param1[local7 + 10] = param1[local7 + 10] || 0;
        param1[local7 + 11] = param1[local7 + 11] || 0;
        param1[local7 + 12] = param1[local7 + 12] || 0;
        param1[local7 + 13] = param1[local7 + 13] || 0;
        param1[local7 + 14] = param1[local7 + 14] || 0;
        param1[local7 + 15] = param1[local7 + 15] || 0;
        local8 = local3;
        local9 = local4;
        local10 = local5;
        local11 = local6;
        local3 = this.ff(local3,local4,local5,local6,param1[local7 + 0],7,3614090360);
        local6 = this.ff(local6,local3,local4,local5,param1[local7 + 1],12,3905402710);
        local5 = this.ff(local5,local6,local3,local4,param1[local7 + 2],17,606105819);
        local4 = this.ff(local4,local5,local6,local3,param1[local7 + 3],22,3250441966);
        local3 = this.ff(local3,local4,local5,local6,param1[local7 + 4],7,4118548399);
        local6 = this.ff(local6,local3,local4,local5,param1[local7 + 5],12,1200080426);
        local5 = this.ff(local5,local6,local3,local4,param1[local7 + 6],17,2821735955);
        local4 = this.ff(local4,local5,local6,local3,param1[local7 + 7],22,4249261313);
        local3 = this.ff(local3,local4,local5,local6,param1[local7 + 8],7,1770035416);
        local6 = this.ff(local6,local3,local4,local5,param1[local7 + 9],12,2336552879);
        local5 = this.ff(local5,local6,local3,local4,param1[local7 + 10],17,4294925233);
        local4 = this.ff(local4,local5,local6,local3,param1[local7 + 11],22,2304563134);
        local3 = this.ff(local3,local4,local5,local6,param1[local7 + 12],7,1804603682);
        local6 = this.ff(local6,local3,local4,local5,param1[local7 + 13],12,4254626195);
        local5 = this.ff(local5,local6,local3,local4,param1[local7 + 14],17,2792965006);
        local4 = this.ff(local4,local5,local6,local3,param1[local7 + 15],22,1236535329);
        local3 = this.gg(local3,local4,local5,local6,param1[local7 + 1],5,4129170786);
        local6 = this.gg(local6,local3,local4,local5,param1[local7 + 6],9,3225465664);
        local5 = this.gg(local5,local6,local3,local4,param1[local7 + 11],14,643717713);
        local4 = this.gg(local4,local5,local6,local3,param1[local7 + 0],20,3921069994);
        local3 = this.gg(local3,local4,local5,local6,param1[local7 + 5],5,3593408605);
        local6 = this.gg(local6,local3,local4,local5,param1[local7 + 10],9,38016083);
        local5 = this.gg(local5,local6,local3,local4,param1[local7 + 15],14,3634488961);
        local4 = this.gg(local4,local5,local6,local3,param1[local7 + 4],20,3889429448);
        local3 = this.gg(local3,local4,local5,local6,param1[local7 + 9],5,568446438);
        local6 = this.gg(local6,local3,local4,local5,param1[local7 + 14],9,3275163606);
        local5 = this.gg(local5,local6,local3,local4,param1[local7 + 3],14,4107603335);
        local4 = this.gg(local4,local5,local6,local3,param1[local7 + 8],20,1163531501);
        local3 = this.gg(local3,local4,local5,local6,param1[local7 + 13],5,2850285829);
        local6 = this.gg(local6,local3,local4,local5,param1[local7 + 2],9,4243563512);
        local5 = this.gg(local5,local6,local3,local4,param1[local7 + 7],14,1735328473);
        local4 = this.gg(local4,local5,local6,local3,param1[local7 + 12],20,2368359562);
        local3 = this.hh(local3,local4,local5,local6,param1[local7 + 5],4,4294588738);
        local6 = this.hh(local6,local3,local4,local5,param1[local7 + 8],11,2272392833);
        local5 = this.hh(local5,local6,local3,local4,param1[local7 + 11],16,1839030562);
        local4 = this.hh(local4,local5,local6,local3,param1[local7 + 14],23,4259657740);
        local3 = this.hh(local3,local4,local5,local6,param1[local7 + 1],4,2763975236);
        local6 = this.hh(local6,local3,local4,local5,param1[local7 + 4],11,1272893353);
        local5 = this.hh(local5,local6,local3,local4,param1[local7 + 7],16,4139469664);
        local4 = this.hh(local4,local5,local6,local3,param1[local7 + 10],23,3200236656);
        local3 = this.hh(local3,local4,local5,local6,param1[local7 + 13],4,681279174);
        local6 = this.hh(local6,local3,local4,local5,param1[local7 + 0],11,3936430074);
        local5 = this.hh(local5,local6,local3,local4,param1[local7 + 3],16,3572445317);
        local4 = this.hh(local4,local5,local6,local3,param1[local7 + 6],23,76029189);
        local3 = this.hh(local3,local4,local5,local6,param1[local7 + 9],4,3654602809);
        local6 = this.hh(local6,local3,local4,local5,param1[local7 + 12],11,3873151461);
        local5 = this.hh(local5,local6,local3,local4,param1[local7 + 15],16,530742520);
        local4 = this.hh(local4,local5,local6,local3,param1[local7 + 2],23,3299628645);
        local3 = this.ii(local3,local4,local5,local6,param1[local7 + 0],6,4096336452);
        local6 = this.ii(local6,local3,local4,local5,param1[local7 + 7],10,1126891415);
        local5 = this.ii(local5,local6,local3,local4,param1[local7 + 14],15,2878612391);
        local4 = this.ii(local4,local5,local6,local3,param1[local7 + 5],21,4237533241);
        local3 = this.ii(local3,local4,local5,local6,param1[local7 + 12],6,1700485571);
        local6 = this.ii(local6,local3,local4,local5,param1[local7 + 3],10,2399980690);
        local5 = this.ii(local5,local6,local3,local4,param1[local7 + 10],15,4293915773);
        local4 = this.ii(local4,local5,local6,local3,param1[local7 + 1],21,2240044497);
        local3 = this.ii(local3,local4,local5,local6,param1[local7 + 8],6,1873313359);
        local6 = this.ii(local6,local3,local4,local5,param1[local7 + 15],10,4264355552);
        local5 = this.ii(local5,local6,local3,local4,param1[local7 + 6],15,2734768916);
        local4 = this.ii(local4,local5,local6,local3,param1[local7 + 13],21,1309151649);
        local3 = this.ii(local3,local4,local5,local6,param1[local7 + 4],6,4149444226);
        local6 = this.ii(local6,local3,local4,local5,param1[local7 + 11],10,3174756917);
        local5 = this.ii(local5,local6,local3,local4,param1[local7 + 2],15,718787259);
        local4 = this.ii(local4,local5,local6,local3,param1[local7 + 9],21,3951481745);
        local3 += local8;
        local4 += local9;
        local5 += local10;
        local6 += local11;
        local7 += 16;
      }
      return [local3,local4,local5,local6];
    }

    private function rol(param1:uint, param2:uint) : uint {
      return param1 << param2 | param1 >>> 32 - param2;
    }

    private function cmn(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint) : uint {
      return this.rol(param2 + param1 + param4 + param6,param5) + param3;
    }

    private function ff(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint {
      return this.cmn(param2 & param3 | ~param2 & param4,param1,param2,param5,param6,param7);
    }

    private function gg(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint {
      return this.cmn(param2 & param4 | param3 & ~param4,param1,param2,param5,param6,param7);
    }

    private function hh(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint {
      return this.cmn(param2 ^ param3 ^ param4,param1,param2,param5,param6,param7);
    }

    private function ii(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint {
      return this.cmn(param3 ^ (param2 | ~param4),param1,param2,param5,param6,param7);
    }

    public function toString() : String {
      return "md5";
    }
  }
}
