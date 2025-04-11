package com.hurlant.crypto.hash {
  public class SHA256 extends SHABase implements IHash {
    protected static const k:Array = [1116352408,1899447441,3049323471,3921009573,961987163,1508970993,2453635748,2870763221,3624381080,310598401,607225278,1426881987,1925078388,2162078206,2614888103,3248222580,3835390401,4022224774,264347078,604807628,770255983,1249150122,1555081692,1996064986,2554220882,2821834349,2952996808,3210313671,3336571891,3584528711,113926993,338241895,666307205,773529912,1294757372,1396182291,1695183700,1986661051,2177026350,2456956037,2730485921,2820302411,3259730800,3345764771,3516065817,3600352804,4094571909,275423344,430227734,506948616,659060556,883997877,958139571,1322822218,1537002063,1747873779,1955562222,2024104815,2227730452,2361852424,2428436474,2756734187,3204031479,3329325298];

    protected var h:Array = [1779033703,3144134277,1013904242,2773480762,1359893119,2600822924,528734635,1541459225];

    public function SHA256() {
      super();
    }

    override public function getHashSize() : uint {
      return 32;
    }

    override protected function core(param1:Array, param2:uint) : Array {
      var local13:uint = 0;
      var local14:uint = 0;
      var local15:uint = 0;
      var local16:uint = 0;
      var local17:uint = 0;
      var local18:uint = 0;
      var local19:uint = 0;
      var local20:uint = 0;
      var local21:uint = 0;
      var local22:uint = 0;
      var local23:uint = 0;
      var local24:uint = 0;
      var local25:uint = 0;
      param1[param2 >> 5] |= 128 << 24 - param2 % 32;
      param1[(param2 + 64 >> 9 << 4) + 15] = param2;
      var local3:Array = [];
      var local4:uint = uint(this.h[0]);
      var local5:uint = uint(this.h[1]);
      var local6:uint = uint(this.h[2]);
      var local7:uint = uint(this.h[3]);
      var local8:uint = uint(this.h[4]);
      var local9:uint = uint(this.h[5]);
      var local10:uint = uint(this.h[6]);
      var local11:uint = uint(this.h[7]);
      var local12:uint = 0;
      while(local12 < param1.length) {
        local13 = local4;
        local14 = local5;
        local15 = local6;
        local16 = local7;
        local17 = local8;
        local18 = local9;
        local19 = local10;
        local20 = local11;
        local21 = 0;
        while(local21 < 64) {
          if(local21 < 16) {
            local3[local21] = param1[local12 + local21] || 0;
          } else {
            local24 = uint(this.rrol(local3[local21 - 15],7) ^ this.rrol(local3[local21 - 15],18) ^ local3[local21 - 15] >>> 3);
            local25 = uint(this.rrol(local3[local21 - 2],17) ^ this.rrol(local3[local21 - 2],19) ^ local3[local21 - 2] >>> 10);
            local3[local21] = local3[local21 - 16] + local24 + local3[local21 - 7] + local25;
          }
          local22 = uint((this.rrol(local4,2) ^ this.rrol(local4,13) ^ this.rrol(local4,22)) + (local4 & local5 ^ local4 & local6 ^ local5 & local6));
          local23 = local11 + (this.rrol(local8,6) ^ this.rrol(local8,11) ^ this.rrol(local8,25)) + (local8 & local9 ^ local10 & ~local8) + k[local21] + local3[local21];
          local11 = local10;
          local10 = local9;
          local9 = local8;
          local8 = local7 + local23;
          local7 = local6;
          local6 = local5;
          local5 = local4;
          local4 = local23 + local22;
          local21++;
        }
        local4 += local13;
        local5 += local14;
        local6 += local15;
        local7 += local16;
        local8 += local17;
        local9 += local18;
        local10 += local19;
        local11 += local20;
        local12 += 16;
      }
      return [local4,local5,local6,local7,local8,local9,local10,local11];
    }

    protected function rrol(param1:uint, param2:uint) : uint {
      return param1 << 32 - param2 | param1 >>> param2;
    }

    override public function toString() : String {
      return "sha256";
    }
  }
}
