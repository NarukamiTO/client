package com.hurlant.math {
  import com.hurlant.crypto.prng.Random;
  import com.hurlant.util.Hex;
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;

  use namespace bi_internal;

  public class BigInteger {
    public static const DB:int = 30;
    public static const DV:int = 1 << DB;
    public static const DM:int = DV - 1;
    public static const BI_FP:int = 52;
    public static const FV:Number = Math.pow(2,BI_FP);
    public static const F1:int = BI_FP - DB;
    public static const F2:int = 2 * DB - BI_FP;
    public static const ZERO:BigInteger = nbv(0);
    public static const ONE:BigInteger = nbv(1);
    public static const lowprimes:Array = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509];
    public static const lplim:int = (1 << 26) / lowprimes[lowprimes.length - 1];

    public var t:int;

    bi_internal var s:int;
    bi_internal var a:Array;

    public function BigInteger(param1:* = null, param2:int = 0, param3:Boolean = false) {
      var local4:ByteArray = null;
      var local5:int = 0;
      super();
      this.bi_internal::a = new Array();
      if(param1 is String) {
        if(Boolean(param2) && param2 != 16) {
          throw new Error("BigInteger construction with radix!=16 is not supported.");
        }
        param1 = Hex.toArray(param1);
        param2 = 0;
      }
      if(param1 is ByteArray) {
        local4 = param1 as ByteArray;
        local5 = int(param2 || local4.length - local4.position);
        this.bi_internal::fromArray(local4,local5,param3);
      }
    }

    public static function nbv(param1:int) : BigInteger {
      var local2:BigInteger = new BigInteger();
      local2.bi_internal::fromInt(param1);
      return local2;
    }

    public function dispose() : void {
      var local1:Random = new Random();
      var local2:uint = 0;
      while(local2 < this.bi_internal::a.length) {
        this.bi_internal::a[local2] = local1.nextByte();
        delete this.bi_internal::a[local2];
        local2++;
      }
      this.bi_internal::a = null;
      this.t = 0;
      this.bi_internal::s = 0;
      Memory.gc();
    }

    public function toString(param1:Number = 16) : String {
      var local2:int = 0;
      if(this.bi_internal::s < 0) {
        return "-" + this.negate().toString(param1);
      }
      switch(param1) {
        case 2:
          local2 = 1;
          break;
        case 4:
          local2 = 2;
          break;
        case 8:
          local2 = 3;
          break;
        case 16:
          local2 = 4;
          break;
        case 32:
          local2 = 5;
      }
      var local3:int = (1 << local2) - 1;
      var local4:int = 0;
      var local5:Boolean = false;
      var local6:String = "";
      var local7:int = this.t;
      var local8:int = DB - local7 * DB % local2;
      if(local7-- > 0) {
        if(local8 < DB && (local4 = this.bi_internal::a[local7] >> local8) > 0) {
          local5 = true;
          local6 = local4.toString(36);
        }
        while(local7 >= 0) {
          if(local8 < local2) {
            local4 = (this.bi_internal::a[local7] & (1 << local8) - 1) << local2 - local8;
            local4 |= this.bi_internal::a[--local7] >> (local8 = local8 + (DB - local2));
          } else {
            local4 = this.bi_internal::a[local7] >> (local8 = local8 - local2) & local3;
            if(local8 <= 0) {
              local8 += DB;
              local7--;
            }
          }
          if(local4 > 0) {
            local5 = true;
          }
          if(local5) {
            local6 += local4.toString(36);
          }
        }
      }
      return local5 ? local6 : "0";
    }

    public function toArray(param1:ByteArray) : uint {
      var local2:int = 8;
      var local3:int = (1 << 8) - 1;
      var local4:int = 0;
      var local5:int = this.t;
      var local6:int = DB - local5 * DB % local2;
      var local7:Boolean = false;
      var local8:int = 0;
      if(local5-- > 0) {
        if(local6 < DB && (local4 = this.bi_internal::a[local5] >> local6) > 0) {
          local7 = true;
          param1.writeByte(local4);
          local8++;
        }
        while(local5 >= 0) {
          if(local6 < local2) {
            local4 = (this.bi_internal::a[local5] & (1 << local6) - 1) << local2 - local6;
            local4 |= this.bi_internal::a[--local5] >> (local6 = local6 + (DB - local2));
          } else {
            local4 = this.bi_internal::a[local5] >> (local6 = local6 - local2) & local3;
            if(local6 <= 0) {
              local6 += DB;
              local5--;
            }
          }
          if(local4 > 0) {
            local7 = true;
          }
          if(local7) {
            param1.writeByte(local4);
            local8++;
          }
        }
      }
      return local8;
    }

    public function valueOf() : Number {
      if(this.bi_internal::s == -1) {
        return -this.negate().valueOf();
      }
      var local1:Number = 1;
      var local2:Number = 0;
      var local3:uint = 0;
      while(local3 < this.t) {
        local2 += this.bi_internal::a[local3] * local1;
        local1 *= DV;
        local3++;
      }
      return local2;
    }

    public function negate() : BigInteger {
      var local1:BigInteger = this.nbi();
      ZERO.bi_internal::subTo(this,local1);
      return local1;
    }

    public function abs() : BigInteger {
      return this.bi_internal::s < 0 ? this.negate() : this;
    }

    public function compareTo(param1:BigInteger) : int {
      var local2:int = this.bi_internal::s - param1.bi_internal::s;
      if(local2 != 0) {
        return local2;
      }
      var local3:int = this.t;
      local2 = local3 - param1.t;
      if(local2 != 0) {
        return local2;
      }
      while(--local3 >= 0) {
        local2 = this.bi_internal::a[local3] - param1.bi_internal::a[local3];
        if(local2 != 0) {
          return local2;
        }
      }
      return 0;
    }

    bi_internal function nbits(param1:int) : int {
      var local3:int = 0;
      var local2:int = 1;
      local3 = param1 >>> 16;
      if(local3 != 0) {
        param1 = local3;
        local2 += 16;
      }
      local3 = param1 >> 8;
      if(local3 != 0) {
        param1 = local3;
        local2 += 8;
      }
      local3 = param1 >> 4;
      if(local3 != 0) {
        param1 = local3;
        local2 += 4;
      }
      local3 = param1 >> 2;
      if(local3 != 0) {
        param1 = local3;
        local2 += 2;
      }
      local3 = param1 >> 1;
      if(local3 != 0) {
        param1 = local3;
        local2 += 1;
      }
      return local2;
    }

    public function bitLength() : int {
      if(this.t <= 0) {
        return 0;
      }
      return DB * (this.t - 1) + this.bi_internal::nbits(this.bi_internal::a[this.t - 1] ^ this.bi_internal::s & DM);
    }

    public function mod(param1:BigInteger) : BigInteger {
      var local2:BigInteger = this.nbi();
      this.abs().bi_internal::divRemTo(param1,null,local2);
      if(this.bi_internal::s < 0 && local2.compareTo(ZERO) > 0) {
        param1.bi_internal::subTo(local2,local2);
      }
      return local2;
    }

    public function modPowInt(param1:int, param2:BigInteger) : BigInteger {
      var local3:IReduction = null;
      if(param1 < 256 || param2.bi_internal::isEven()) {
        local3 = new ClassicReduction(param2);
      } else {
        local3 = new MontgomeryReduction(param2);
      }
      return this.bi_internal::exp(param1,local3);
    }

    bi_internal function copyTo(param1:BigInteger) : void {
      var local2:int = this.t - 1;
      while(local2 >= 0) {
        param1.bi_internal::a[local2] = this.bi_internal::a[local2];
        local2--;
      }
      param1.t = this.t;
      param1.bi_internal::s = this.bi_internal::s;
    }

    bi_internal function fromInt(param1:int) : void {
      this.t = 1;
      this.bi_internal::s = param1 < 0 ? -1 : 0;
      if(param1 > 0) {
        this.bi_internal::a[0] = param1;
      } else if(param1 < -1) {
        this.bi_internal::a[0] = param1 + DV;
      } else {
        this.t = 0;
      }
    }

    bi_internal function fromArray(param1:ByteArray, param2:int, param3:Boolean = false) : void {
      var local8:int = 0;
      var local4:int = int(param1.position);
      var local5:int = local4 + param2;
      var local6:int = 0;
      var local7:int = 8;
      this.t = 0;
      this.bi_internal::s = 0;
      while(--local5 >= local4) {
        local8 = local5 < param1.length ? int(param1[local5]) : 0;
        if(local6 == 0) {
          var local9:* = this.t++;
          this.bi_internal::a[local9] = local8;
        } else if(local6 + local7 > DB) {
          this.bi_internal::a[this.t - 1] |= (local8 & (1 << DB - local6) - 1) << local6;
          local9 = this.t++;
          this.bi_internal::a[local9] = local8 >> DB - local6;
        } else {
          this.bi_internal::a[this.t - 1] |= local8 << local6;
        }
        local6 += local7;
        if(local6 >= DB) {
          local6 -= DB;
        }
      }
      if(!param3 && (param1[0] & 0x80) == 128) {
        this.bi_internal::s = -1;
        if(local6 > 0) {
          this.bi_internal::a[this.t - 1] |= (1 << DB - local6) - 1 << local6;
        }
      }
      this.bi_internal::clamp();
      param1.position = Math.min(local4 + param2,param1.length);
    }

    bi_internal function clamp() : void {
      var local1:int = this.bi_internal::s & DM;
      while(this.t > 0 && this.bi_internal::a[this.t - 1] == local1) {
        --this.t;
      }
    }

    bi_internal function dlShiftTo(param1:int, param2:BigInteger) : void {
      var local3:int = 0;
      local3 = this.t - 1;
      while(local3 >= 0) {
        param2.bi_internal::a[local3 + param1] = this.bi_internal::a[local3];
        local3--;
      }
      local3 = param1 - 1;
      while(local3 >= 0) {
        param2.bi_internal::a[local3] = 0;
        local3--;
      }
      param2.t = this.t + param1;
      param2.bi_internal::s = this.bi_internal::s;
    }

    bi_internal function drShiftTo(param1:int, param2:BigInteger) : void {
      var local3:int = 0;
      local3 = param1;
      while(local3 < this.t) {
        param2.bi_internal::a[local3 - param1] = this.bi_internal::a[local3];
        local3++;
      }
      param2.t = Math.max(this.t - param1,0);
      param2.bi_internal::s = this.bi_internal::s;
    }

    bi_internal function lShiftTo(param1:int, param2:BigInteger) : void {
      var local8:int = 0;
      var local3:int = param1 % DB;
      var local4:int = DB - local3;
      var local5:int = (1 << local4) - 1;
      var local6:int = param1 / DB;
      var local7:int = this.bi_internal::s << local3 & DM;
      local8 = this.t - 1;
      while(local8 >= 0) {
        param2.bi_internal::a[local8 + local6 + 1] = this.bi_internal::a[local8] >> local4 | local7;
        local7 = (this.bi_internal::a[local8] & local5) << local3;
        local8--;
      }
      local8 = local6 - 1;
      while(local8 >= 0) {
        param2.bi_internal::a[local8] = 0;
        local8--;
      }
      param2.bi_internal::a[local6] = local7;
      param2.t = this.t + local6 + 1;
      param2.bi_internal::s = this.bi_internal::s;
      param2.bi_internal::clamp();
    }

    bi_internal function rShiftTo(param1:int, param2:BigInteger) : void {
      var local7:int = 0;
      param2.bi_internal::s = this.bi_internal::s;
      var local3:int = param1 / DB;
      if(local3 >= this.t) {
        param2.t = 0;
        return;
      }
      var local4:int = param1 % DB;
      var local5:int = DB - local4;
      var local6:int = (1 << local4) - 1;
      param2.bi_internal::a[0] = this.bi_internal::a[local3] >> local4;
      local7 = local3 + 1;
      while(local7 < this.t) {
        param2.bi_internal::a[local7 - local3 - 1] |= (this.bi_internal::a[local7] & local6) << local5;
        param2.bi_internal::a[local7 - local3] = this.bi_internal::a[local7] >> local4;
        local7++;
      }
      if(local4 > 0) {
        param2.bi_internal::a[this.t - local3 - 1] |= (this.bi_internal::s & local6) << local5;
      }
      param2.t = this.t - local3;
      param2.bi_internal::clamp();
    }

    bi_internal function subTo(param1:BigInteger, param2:BigInteger) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = Math.min(param1.t,this.t);
      while(local3 < local5) {
        local4 += this.bi_internal::a[local3] - param1.bi_internal::a[local3];
        var local6:* = local3++;
        param2.bi_internal::a[local6] = local4 & DM;
        local4 >>= DB;
      }
      if(param1.t < this.t) {
        local4 -= param1.bi_internal::s;
        while(local3 < this.t) {
          local4 += this.bi_internal::a[local3];
          local6 = local3++;
          param2.bi_internal::a[local6] = local4 & DM;
          local4 >>= DB;
        }
        local4 += this.bi_internal::s;
      } else {
        local4 += this.bi_internal::s;
        while(local3 < param1.t) {
          local4 -= param1.bi_internal::a[local3];
          local6 = local3++;
          param2.bi_internal::a[local6] = local4 & DM;
          local4 >>= DB;
        }
        local4 -= param1.bi_internal::s;
      }
      param2.bi_internal::s = local4 < 0 ? -1 : 0;
      if(local4 < -1) {
        local6 = local3++;
        param2.bi_internal::a[local6] = DV + local4;
      } else if(local4 > 0) {
        local6 = local3++;
        param2.bi_internal::a[local6] = local4;
      }
      param2.t = local3;
      param2.bi_internal::clamp();
    }

    bi_internal function am(param1:int, param2:int, param3:BigInteger, param4:int, param5:int, param6:int) : int {
      var local9:int = 0;
      var local10:int = 0;
      var local11:int = 0;
      var local7:int = param2 & 0x7FFF;
      var local8:int = param2 >> 15;
      while(--param6 >= 0) {
        local9 = this.bi_internal::a[param1] & 0x7FFF;
        local10 = this.bi_internal::a[param1++] >> 15;
        local11 = local8 * local9 + local10 * local7;
        local9 = local7 * local9 + ((local11 & 0x7FFF) << 15) + param3.bi_internal::a[param4] + (param5 & 0x3FFFFFFF);
        param5 = (local9 >>> 30) + (local11 >>> 15) + local8 * local10 + (param5 >>> 30);
        var local12:* = param4++;
        param3.bi_internal::a[local12] = local9 & 0x3FFFFFFF;
      }
      return param5;
    }

    bi_internal function multiplyTo(param1:BigInteger, param2:BigInteger) : void {
      var local3:BigInteger = this.abs();
      var local4:BigInteger = param1.abs();
      var local5:int = local3.t;
      param2.t = local5 + local4.t;
      while(--local5 >= 0) {
        param2.bi_internal::a[local5] = 0;
      }
      local5 = 0;
      while(local5 < local4.t) {
        param2.bi_internal::a[local5 + local3.t] = local3.bi_internal::am(0,local4.bi_internal::a[local5],param2,local5,0,local3.t);
        local5++;
      }
      param2.bi_internal::s = 0;
      param2.bi_internal::clamp();
      if(this.bi_internal::s != param1.bi_internal::s) {
        ZERO.bi_internal::subTo(param2,param2);
      }
    }

    bi_internal function squareTo(param1:BigInteger) : void {
      var local4:int = 0;
      var local2:BigInteger = this.abs();
      var local3:int = param1.t = 2 * local2.t;
      while(--local3 >= 0) {
        param1.bi_internal::a[local3] = 0;
      }
      local3 = 0;
      while(local3 < local2.t - 1) {
        local4 = local2.bi_internal::am(local3,local2.bi_internal::a[local3],param1,2 * local3,0,1);
        if((param1.bi_internal::a[local3 + local2.t] = param1.bi_internal::a[local3 + local2.t] + local2.bi_internal::am(local3 + 1,2 * local2.bi_internal::a[local3],param1,2 * local3 + 1,local4,local2.t - local3 - 1)) >= DV) {
          param1.bi_internal::a[local3 + local2.t] -= DV;
          param1.bi_internal::a[local3 + local2.t + 1] = 1;
        }
        local3++;
      }
      if(param1.t > 0) {
        param1.bi_internal::a[param1.t - 1] += local2.bi_internal::am(local3,local2.bi_internal::a[local3],param1,2 * local3,0,1);
      }
      param1.bi_internal::s = 0;
      param1.bi_internal::clamp();
    }

    bi_internal function divRemTo(param1:BigInteger, param2:BigInteger = null, param3:BigInteger = null) : void {
      var pt:BigInteger;
      var y:BigInteger;
      var ts:int;
      var ms:int;
      var nsh:int;
      var ys:int;
      var y0:int;
      var yt:Number;
      var d1:Number;
      var d2:Number;
      var e:Number;
      var i:int;
      var j:int;
      var t:BigInteger;
      var qd:int = 0;
      var m:BigInteger = param1;
      var q:BigInteger = param2;
      var r:BigInteger = param3;
      var pm:BigInteger = m.abs();
      if(pm.t <= 0) {
        return;
      }
      pt = this.abs();
      if(pt.t < pm.t) {
        if(q != null) {
          q.bi_internal::fromInt(0);
        }
        if(r != null) {
          this.bi_internal::copyTo(r);
        }
        return;
      }
      if(r == null) {
        r = this.nbi();
      }
      y = this.nbi();
      ts = this.bi_internal::s;
      ms = m.bi_internal::s;
      nsh = DB - this.bi_internal::nbits(pm.bi_internal::a[pm.t - 1]);
      if(nsh > 0) {
        pm.bi_internal::lShiftTo(nsh,y);
        pt.bi_internal::lShiftTo(nsh,r);
      } else {
        pm.bi_internal::copyTo(y);
        pt.bi_internal::copyTo(r);
      }
      ys = y.t;
      y0 = int(y.bi_internal::a[ys - 1]);
      if(y0 == 0) {
        return;
      }
      yt = y0 * (1 << F1) + (ys > 1 ? y.bi_internal::a[ys - 2] >> F2 : 0);
      d1 = FV / yt;
      d2 = (1 << F1) / yt;
      e = 1 << F2;
      i = r.t;
      j = i - ys;
      t = q == null ? this.nbi() : q;
      y.bi_internal::dlShiftTo(j,t);
      if(r.compareTo(t) >= 0) {
        var local5:* = r.t++;
        r.bi_internal::a[local5] = 1;
        r.bi_internal::subTo(t,r);
      }
      ONE.bi_internal::dlShiftTo(ys,t);
      t.bi_internal::subTo(y,y);
      while(y.t < ys) {
        y.(++y.t, 0);
      }
      while(--j >= 0) {
        qd = r.bi_internal::a[--i] == y0 ? DM : int(Number(r.bi_internal::a[i]) * d1 + (Number(r.bi_internal::a[i - 1]) + e) * d2);
        if((r.bi_internal::a[i] = r.bi_internal::a[i] + y.bi_internal::am(0,qd,r,j,0,ys)) < qd) {
          y.bi_internal::dlShiftTo(j,t);
          r.bi_internal::subTo(t,r);
          while(r.bi_internal::a[i] < --qd) {
            r.bi_internal::subTo(t,r);
          }
        }
      }
      if(q != null) {
        r.bi_internal::drShiftTo(ys,q);
        if(ts != ms) {
          ZERO.bi_internal::subTo(q,q);
        }
      }
      r.t = ys;
      r.bi_internal::clamp();
      if(nsh > 0) {
        r.bi_internal::rShiftTo(nsh,r);
      }
      if(ts < 0) {
        ZERO.bi_internal::subTo(r,r);
      }
    }

    bi_internal function invDigit() : int {
      if(this.t < 1) {
        return 0;
      }
      var local1:int = int(this.bi_internal::a[0]);
      if((local1 & 1) == 0) {
        return 0;
      }
      var local2:int = local1 & 3;
      local2 = local2 * (2 - (local1 & 0x0F) * local2) & 0x0F;
      local2 = local2 * (2 - (local1 & 0xFF) * local2) & 0xFF;
      local2 = local2 * (2 - ((local1 & 0xFFFF) * local2 & 0xFFFF)) & 0xFFFF;
      local2 = local2 * (2 - local1 * local2 % DV) % DV;
      return local2 > 0 ? DV - local2 : int(-local2);
    }

    bi_internal function isEven() : Boolean {
      return (this.t > 0 ? this.bi_internal::a[0] & 1 : this.bi_internal::s) == 0;
    }

    bi_internal function exp(param1:int, param2:IReduction) : BigInteger {
      var local7:BigInteger = null;
      if(param1 > 4294967295 || param1 < 1) {
        return ONE;
      }
      var local3:BigInteger = this.nbi();
      var local4:BigInteger = this.nbi();
      var local5:BigInteger = param2.convert(this);
      var local6:int = this.bi_internal::nbits(param1) - 1;
      local5.bi_internal::copyTo(local3);
      while(--local6 >= 0) {
        param2.sqrTo(local3,local4);
        if((param1 & 1 << local6) > 0) {
          param2.mulTo(local4,local5,local3);
        } else {
          local7 = local3;
          local3 = local4;
          local4 = local7;
        }
      }
      return param2.revert(local3);
    }

    bi_internal function intAt(param1:String, param2:int) : int {
      return parseInt(param1.charAt(param2),36);
    }

    protected function nbi() : * {
      return new BigInteger();
    }

    public function clone() : BigInteger {
      var local1:BigInteger = new BigInteger();
      this.bi_internal::copyTo(local1);
      return local1;
    }

    public function intValue() : int {
      if(this.bi_internal::s < 0) {
        if(this.t == 1) {
          return this.bi_internal::a[0] - DV;
        }
        if(this.t == 0) {
          return -1;
        }
      } else {
        if(this.t == 1) {
          return this.bi_internal::a[0];
        }
        if(this.t == 0) {
          return 0;
        }
      }
      return (this.bi_internal::a[1] & (1 << 32 - DB) - 1) << DB | this.bi_internal::a[0];
    }

    public function byteValue() : int {
      return this.t == 0 ? this.bi_internal::s : this.bi_internal::a[0] << 24 >> 24;
    }

    public function shortValue() : int {
      return this.t == 0 ? this.bi_internal::s : this.bi_internal::a[0] << 16 >> 16;
    }

    protected function chunkSize(param1:Number) : int {
      return Math.floor(Math.LN2 * DB / Math.log(param1));
    }

    public function sigNum() : int {
      if(this.bi_internal::s < 0) {
        return -1;
      }
      if(this.t <= 0 || this.t == 1 && this.bi_internal::a[0] <= 0) {
        return 0;
      }
      return 1;
    }

    protected function toRadix(param1:uint = 10) : String {
      if(this.sigNum() == 0 || param1 < 2 || param1 > 32) {
        return "0";
      }
      var local2:int = this.chunkSize(param1);
      var local3:Number = Math.pow(param1,local2);
      var local4:BigInteger = nbv(local3);
      var local5:BigInteger = this.nbi();
      var local6:BigInteger = this.nbi();
      var local7:String = "";
      this.bi_internal::divRemTo(local4,local5,local6);
      while(local5.sigNum() > 0) {
        local7 = (local3 + local6.intValue()).toString(param1).substr(1) + local7;
        local5.bi_internal::divRemTo(local4,local5,local6);
      }
      return local6.intValue().toString(param1) + local7;
    }

    protected function fromRadix(param1:String, param2:int = 10) : void {
      var local9:int = 0;
      this.bi_internal::fromInt(0);
      var local3:int = this.chunkSize(param2);
      var local4:Number = Math.pow(param2,local3);
      var local5:Boolean = false;
      var local6:int = 0;
      var local7:int = 0;
      var local8:int = 0;
      while(local8 < param1.length) {
        local9 = this.bi_internal::intAt(param1,local8);
        if(local9 < 0) {
          if(param1.charAt(local8) == "-" && this.sigNum() == 0) {
            local5 = true;
          }
        } else {
          local7 = param2 * local7 + local9;
          if(++local6 >= local3) {
            this.bi_internal::dMultiply(local4);
            this.bi_internal::dAddOffset(local7,0);
            local6 = 0;
            local7 = 0;
          }
        }
        local8++;
      }
      if(local6 > 0) {
        this.bi_internal::dMultiply(Math.pow(param2,local6));
        this.bi_internal::dAddOffset(local7,0);
      }
      if(local5) {
        BigInteger.ZERO.bi_internal::subTo(this,this);
      }
    }

    public function toByteArray() : ByteArray {
      var local4:int = 0;
      var local1:int = this.t;
      var local2:ByteArray = new ByteArray();
      local2[0] = this.bi_internal::s;
      var local3:int = DB - local1 * DB % 8;
      var local5:int = 0;
      if(local1-- > 0) {
        if(local3 < DB && (local4 = this.bi_internal::a[local1] >> local3) != (this.bi_internal::s & DM) >> local3) {
          var local6:* = local5++;
          local2[local6] = local4 | this.bi_internal::s << DB - local3;
        }
        while(local1 >= 0) {
          if(local3 < 8) {
            local4 = (this.bi_internal::a[local1] & (1 << local3) - 1) << 8 - local3;
            local4 |= this.bi_internal::a[--local1] >> (local3 = local3 + (DB - 8));
          } else {
            local4 = this.bi_internal::a[local1] >> (local3 = local3 - 8) & 0xFF;
            if(local3 <= 0) {
              local3 += DB;
              local1--;
            }
          }
          if((local4 & 0x80) != 0) {
            local4 |= -256;
          }
          if(local5 == 0 && (this.bi_internal::s & 0x80) != (local4 & 0x80)) {
            local5++;
          }
          if(local5 > 0 || local4 != this.bi_internal::s) {
            local6 = local5++;
            local2[local6] = local4;
          }
        }
      }
      return local2;
    }

    public function equals(param1:BigInteger) : Boolean {
      return this.compareTo(param1) == 0;
    }

    public function min(param1:BigInteger) : BigInteger {
      return this.compareTo(param1) < 0 ? this : param1;
    }

    public function max(param1:BigInteger) : BigInteger {
      return this.compareTo(param1) > 0 ? this : param1;
    }

    protected function bitwiseTo(param1:BigInteger, param2:Function, param3:BigInteger) : void {
      var local4:int = 0;
      var local5:int = 0;
      var local6:int = Math.min(param1.t,this.t);
      local4 = 0;
      while(local4 < local6) {
        param3.bi_internal::a[local4] = param2(this.bi_internal::a[local4],param1.bi_internal::a[local4]);
        local4++;
      }
      if(param1.t < this.t) {
        local5 = param1.bi_internal::s & DM;
        local4 = local6;
        while(local4 < this.t) {
          param3.bi_internal::a[local4] = param2(this.bi_internal::a[local4],local5);
          local4++;
        }
        param3.t = this.t;
      } else {
        local5 = this.bi_internal::s & DM;
        local4 = local6;
        while(local4 < param1.t) {
          param3.bi_internal::a[local4] = param2(local5,param1.bi_internal::a[local4]);
          local4++;
        }
        param3.t = param1.t;
      }
      param3.bi_internal::s = param2(this.bi_internal::s,param1.bi_internal::s);
      param3.bi_internal::clamp();
    }

    private function op_and(param1:int, param2:int) : int {
      return param1 & param2;
    }

    public function and(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bitwiseTo(param1,this.op_and,local2);
      return local2;
    }

    private function op_or(param1:int, param2:int) : int {
      return param1 | param2;
    }

    public function or(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bitwiseTo(param1,this.op_or,local2);
      return local2;
    }

    private function op_xor(param1:int, param2:int) : int {
      return param1 ^ param2;
    }

    public function xor(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bitwiseTo(param1,this.op_xor,local2);
      return local2;
    }

    private function op_andnot(param1:int, param2:int) : int {
      return param1 & ~param2;
    }

    public function andNot(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bitwiseTo(param1,this.op_andnot,local2);
      return local2;
    }

    public function not() : BigInteger {
      var local1:BigInteger = new BigInteger();
      var local2:int = 0;
      while(local2 < this.t) {
        local1[local2] = DM & ~this.bi_internal::a[local2];
        local2++;
      }
      local1.t = this.t;
      local1.bi_internal::s = ~this.bi_internal::s;
      return local1;
    }

    public function shiftLeft(param1:int) : BigInteger {
      var local2:BigInteger = new BigInteger();
      if(param1 < 0) {
        this.bi_internal::rShiftTo(-param1,local2);
      } else {
        this.bi_internal::lShiftTo(param1,local2);
      }
      return local2;
    }

    public function shiftRight(param1:int) : BigInteger {
      var local2:BigInteger = new BigInteger();
      if(param1 < 0) {
        this.bi_internal::lShiftTo(-param1,local2);
      } else {
        this.bi_internal::rShiftTo(param1,local2);
      }
      return local2;
    }

    private function lbit(param1:int) : int {
      if(param1 == 0) {
        return -1;
      }
      var local2:int = 0;
      if((param1 & 0xFFFF) == 0) {
        param1 >>= 16;
        local2 += 16;
      }
      if((param1 & 0xFF) == 0) {
        param1 >>= 8;
        local2 += 8;
      }
      if((param1 & 0x0F) == 0) {
        param1 >>= 4;
        local2 += 4;
      }
      if((param1 & 3) == 0) {
        param1 >>= 2;
        local2 += 2;
      }
      if((param1 & 1) == 0) {
        local2++;
      }
      return local2;
    }

    public function getLowestSetBit() : int {
      var local1:int = 0;
      while(local1 < this.t) {
        if(this.bi_internal::a[local1] != 0) {
          return local1 * DB + this.lbit(this.bi_internal::a[local1]);
        }
        local1++;
      }
      if(this.bi_internal::s < 0) {
        return this.t * DB;
      }
      return -1;
    }

    private function cbit(param1:int) : int {
      var local2:uint = 0;
      while(param1 != 0) {
        param1 &= param1 - 1;
        local2++;
      }
      return local2;
    }

    public function bitCount() : int {
      var local1:int = 0;
      var local2:int = this.bi_internal::s & DM;
      var local3:int = 0;
      while(local3 < this.t) {
        local1 += this.cbit(this.bi_internal::a[local3] ^ local2);
        local3++;
      }
      return local1;
    }

    public function testBit(param1:int) : Boolean {
      var local2:int = Math.floor(param1 / DB);
      if(local2 >= this.t) {
        return this.bi_internal::s != 0;
      }
      return (this.bi_internal::a[local2] & 1 << param1 % DB) != 0;
    }

    protected function changeBit(param1:int, param2:Function) : BigInteger {
      var local3:BigInteger = BigInteger.ONE.shiftLeft(param1);
      this.bitwiseTo(local3,param2,local3);
      return local3;
    }

    public function setBit(param1:int) : BigInteger {
      return this.changeBit(param1,this.op_or);
    }

    public function clearBit(param1:int) : BigInteger {
      return this.changeBit(param1,this.op_andnot);
    }

    public function flipBit(param1:int) : BigInteger {
      return this.changeBit(param1,this.op_xor);
    }

    protected function addTo(param1:BigInteger, param2:BigInteger) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = Math.min(param1.t,this.t);
      while(local3 < local5) {
        local4 += this.bi_internal::a[local3] + param1.bi_internal::a[local3];
        var local6:* = local3++;
        param2.bi_internal::a[local6] = local4 & DM;
        local4 >>= DB;
      }
      if(param1.t < this.t) {
        local4 += param1.bi_internal::s;
        while(local3 < this.t) {
          local4 += this.bi_internal::a[local3];
          local6 = local3++;
          param2.bi_internal::a[local6] = local4 & DM;
          local4 >>= DB;
        }
        local4 += this.bi_internal::s;
      } else {
        local4 += this.bi_internal::s;
        while(local3 < param1.t) {
          local4 += param1.bi_internal::a[local3];
          local6 = local3++;
          param2.bi_internal::a[local6] = local4 & DM;
          local4 >>= DB;
        }
        local4 += param1.bi_internal::s;
      }
      param2.bi_internal::s = local4 < 0 ? -1 : 0;
      if(local4 > 0) {
        local6 = local3++;
        param2.bi_internal::a[local6] = local4;
      } else if(local4 < -1) {
        local6 = local3++;
        param2.bi_internal::a[local6] = DV + local4;
      }
      param2.t = local3;
      param2.bi_internal::clamp();
    }

    public function add(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.addTo(param1,local2);
      return local2;
    }

    public function subtract(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bi_internal::subTo(param1,local2);
      return local2;
    }

    public function multiply(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bi_internal::multiplyTo(param1,local2);
      return local2;
    }

    public function divide(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bi_internal::divRemTo(param1,local2,null);
      return local2;
    }

    public function remainder(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      this.bi_internal::divRemTo(param1,null,local2);
      return local2;
    }

    public function divideAndRemainder(param1:BigInteger) : Array {
      var local2:BigInteger = new BigInteger();
      var local3:BigInteger = new BigInteger();
      this.bi_internal::divRemTo(param1,local2,local3);
      return [local2,local3];
    }

    bi_internal function dMultiply(param1:int) : void {
      this.bi_internal::a[this.t] = this.bi_internal::am(0,param1 - 1,this,0,0,this.t);
      ++this.t;
      this.bi_internal::clamp();
    }

    bi_internal function dAddOffset(param1:int, param2:int) : void {
      while(this.t <= param2) {
        var local3:* = this.t++;
        this.bi_internal::a[local3] = 0;
      }
      this.bi_internal::a[param2] += param1;
      while(this.bi_internal::a[param2] >= DV) {
        this.bi_internal::a[param2] -= DV;
        if(++param2 >= this.t) {
          local3 = this.t++;
          this.bi_internal::a[local3] = 0;
        }
        ++this.bi_internal::a[param2];
      }
    }

    public function pow(param1:int) : BigInteger {
      return this.bi_internal::exp(param1,new NullReduction());
    }

    bi_internal function multiplyLowerTo(param1:BigInteger, param2:int, param3:BigInteger) : void {
      var local5:int = 0;
      var local4:int = Math.min(this.t + param1.t,param2);
      param3.bi_internal::s = 0;
      param3.t = local4;
      while(local4 > 0) {
        var local6:* = --local4;
        param3.bi_internal::a[local6] = 0;
      }
      local5 = param3.t - this.t;
      while(local4 < local5) {
        param3.bi_internal::a[local4 + this.t] = this.bi_internal::am(0,param1.bi_internal::a[local4],param3,local4,0,this.t);
        local4++;
      }
      local5 = Math.min(param1.t,param2);
      while(local4 < local5) {
        this.bi_internal::am(0,param1.bi_internal::a[local4],param3,local4,0,param2 - local4);
        local4++;
      }
      param3.bi_internal::clamp();
    }

    bi_internal function multiplyUpperTo(param1:BigInteger, param2:int, param3:BigInteger) : void {
      param2--;
      var local4:int = param3.t = this.t + param1.t - param2;
      param3.bi_internal::s = 0;
      while(--local4 >= 0) {
        param3.bi_internal::a[local4] = 0;
      }
      local4 = Math.max(param2 - this.t,0);
      while(local4 < param1.t) {
        param3.bi_internal::a[this.t + local4 - param2] = this.bi_internal::am(param2 - local4,param1.bi_internal::a[local4],param3,0,0,this.t + local4 - param2);
        local4++;
      }
      param3.bi_internal::clamp();
      param3.bi_internal::drShiftTo(1,param3);
    }

    public function modPow(param1:BigInteger, param2:BigInteger) : BigInteger {
      var local4:int = 0;
      var local6:IReduction = null;
      var local12:int = 0;
      var local15:BigInteger = null;
      var local16:BigInteger = null;
      var local3:int = param1.bitLength();
      var local5:BigInteger = nbv(1);
      if(local3 <= 0) {
        return local5;
      }
      if(local3 < 18) {
        local4 = 1;
      } else if(local3 < 48) {
        local4 = 3;
      } else if(local3 < 144) {
        local4 = 4;
      } else if(local3 < 768) {
        local4 = 5;
      } else {
        local4 = 6;
      }
      if(local3 < 8) {
        local6 = new ClassicReduction(param2);
      } else if(param2.bi_internal::isEven()) {
        local6 = new BarrettReduction(param2);
      } else {
        local6 = new MontgomeryReduction(param2);
      }
      var local7:Array = [];
      var local8:int = 3;
      var local9:int = local4 - 1;
      var local10:int = (1 << local4) - 1;
      local7[1] = local6.convert(this);
      if(local4 > 1) {
        local16 = new BigInteger();
        local6.sqrTo(local7[1],local16);
        while(local8 <= local10) {
          local7[local8] = new BigInteger();
          local6.mulTo(local16,local7[local8 - 2],local7[local8]);
          local8 += 2;
        }
      }
      var local11:int = param1.t - 1;
      var local13:Boolean = true;
      var local14:BigInteger = new BigInteger();
      local3 = this.bi_internal::nbits(param1.bi_internal::a[local11]) - 1;
      while(local11 >= 0) {
        if(local3 >= local9) {
          local12 = param1.bi_internal::a[local11] >> local3 - local9 & local10;
        } else {
          local12 = (param1.bi_internal::a[local11] & (1 << local3 + 1) - 1) << local9 - local3;
          if(local11 > 0) {
            local12 |= param1.bi_internal::a[local11 - 1] >> DB + local3 - local9;
          }
        }
        local8 = local4;
        while((local12 & 1) == 0) {
          local12 >>= 1;
          local8--;
        }
        local3 = local3 - local8;
        if(local3 < 0) {
          local3 += DB;
          local11--;
        }
        if(local13) {
          local7[local12].copyTo(local5);
          local13 = false;
        } else {
          while(local8 > 1) {
            local6.sqrTo(local5,local14);
            local6.sqrTo(local14,local5);
            local8 -= 2;
          }
          if(local8 > 0) {
            local6.sqrTo(local5,local14);
          } else {
            local15 = local5;
            local5 = local14;
            local14 = local15;
          }
          local6.mulTo(local14,local7[local12],local5);
        }
        while(local11 >= 0 && (param1.bi_internal::a[local11] & 1 << local3) == 0) {
          local6.sqrTo(local5,local14);
          local15 = local5;
          local5 = local14;
          local14 = local15;
          if(--local3 < 0) {
            local3 = DB - 1;
            local11--;
          }
        }
      }
      return local6.revert(local5);
    }

    public function gcd(param1:BigInteger) : BigInteger {
      var local6:BigInteger = null;
      var local2:BigInteger = this.bi_internal::s < 0 ? this.negate() : this.clone();
      var local3:BigInteger = param1.bi_internal::s < 0 ? param1.negate() : param1.clone();
      if(local2.compareTo(local3) < 0) {
        local6 = local2;
        local2 = local3;
        local3 = local6;
      }
      var local4:int = local2.getLowestSetBit();
      var local5:int = local3.getLowestSetBit();
      if(local5 < 0) {
        return local2;
      }
      if(local4 < local5) {
        local5 = local4;
      }
      if(local5 > 0) {
        local2.bi_internal::rShiftTo(local5,local2);
        local3.bi_internal::rShiftTo(local5,local3);
      }
      while(local2.sigNum() > 0) {
        local4 = local2.getLowestSetBit();
        if(local4 > 0) {
          local2.bi_internal::rShiftTo(local4,local2);
        }
        local4 = local3.getLowestSetBit();
        if(local4 > 0) {
          local3.bi_internal::rShiftTo(local4,local3);
        }
        if(local2.compareTo(local3) >= 0) {
          local2.bi_internal::subTo(local3,local2);
          local2.bi_internal::rShiftTo(1,local2);
        } else {
          local3.bi_internal::subTo(local2,local3);
          local3.bi_internal::rShiftTo(1,local3);
        }
      }
      if(local5 > 0) {
        local3.bi_internal::lShiftTo(local5,local3);
      }
      return local3;
    }

    protected function modInt(param1:int) : int {
      var local4:int = 0;
      if(param1 <= 0) {
        return 0;
      }
      var local2:int = DV % param1;
      var local3:int = this.bi_internal::s < 0 ? param1 - 1 : 0;
      if(this.t > 0) {
        if(local2 == 0) {
          local3 = this.bi_internal::a[0] % param1;
        } else {
          local4 = this.t - 1;
          while(local4 >= 0) {
            local3 = (local2 * local3 + this.bi_internal::a[local4]) % param1;
            local4--;
          }
        }
      }
      return local3;
    }

    public function modInverse(param1:BigInteger) : BigInteger {
      var local2:Boolean = param1.bi_internal::isEven();
      if(this.bi_internal::isEven() && local2 || param1.sigNum() == 0) {
        return BigInteger.ZERO;
      }
      var local3:BigInteger = param1.clone();
      var local4:BigInteger = this.clone();
      var local5:BigInteger = nbv(1);
      var local6:BigInteger = nbv(0);
      var local7:BigInteger = nbv(0);
      var local8:BigInteger = nbv(1);
      while(local3.sigNum() != 0) {
        while(local3.bi_internal::isEven()) {
          local3.bi_internal::rShiftTo(1,local3);
          if(local2) {
            if(!local5.bi_internal::isEven() || !local6.bi_internal::isEven()) {
              local5.addTo(this,local5);
              local6.bi_internal::subTo(param1,local6);
            }
            local5.bi_internal::rShiftTo(1,local5);
          } else if(!local6.bi_internal::isEven()) {
            local6.bi_internal::subTo(param1,local6);
          }
          local6.bi_internal::rShiftTo(1,local6);
        }
        while(local4.bi_internal::isEven()) {
          local4.bi_internal::rShiftTo(1,local4);
          if(local2) {
            if(!local7.bi_internal::isEven() || !local8.bi_internal::isEven()) {
              local7.addTo(this,local7);
              local8.bi_internal::subTo(param1,local8);
            }
            local7.bi_internal::rShiftTo(1,local7);
          } else if(!local8.bi_internal::isEven()) {
            local8.bi_internal::subTo(param1,local8);
          }
          local8.bi_internal::rShiftTo(1,local8);
        }
        if(local3.compareTo(local4) >= 0) {
          local3.bi_internal::subTo(local4,local3);
          if(local2) {
            local5.bi_internal::subTo(local7,local5);
          }
          local6.bi_internal::subTo(local8,local6);
        } else {
          local4.bi_internal::subTo(local3,local4);
          if(local2) {
            local7.bi_internal::subTo(local5,local7);
          }
          local8.bi_internal::subTo(local6,local8);
        }
      }
      if(local4.compareTo(BigInteger.ONE) != 0) {
        return BigInteger.ZERO;
      }
      if(local8.compareTo(param1) >= 0) {
        return local8.subtract(param1);
      }
      if(local8.sigNum() < 0) {
        local8.addTo(param1,local8);
        if(local8.sigNum() < 0) {
          return local8.add(param1);
        }
        return local8;
      }
      return local8;
    }

    public function isProbablePrime(param1:int) : Boolean {
      var local2:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      var local3:BigInteger = this.abs();
      if(local3.t == 1 && local3.bi_internal::a[0] <= lowprimes[lowprimes.length - 1]) {
        local2 = 0;
        while(local2 < lowprimes.length) {
          if(local3[0] == lowprimes[local2]) {
            return true;
          }
          local2++;
        }
        return false;
      }
      if(local3.bi_internal::isEven()) {
        return false;
      }
      local2 = 1;
      while(local2 < lowprimes.length) {
        local4 = int(lowprimes[local2]);
        local5 = local2 + 1;
        while(local5 < lowprimes.length && local4 < lplim) {
          local4 *= lowprimes[local5++];
        }
        local4 = local3.modInt(local4);
        while(local2 < local5) {
          if(local4 % lowprimes[local2++] == 0) {
            return false;
          }
        }
      }
      return local3.millerRabin(param1);
    }

    protected function millerRabin(param1:int) : Boolean {
      var local7:BigInteger = null;
      var local8:int = 0;
      var local2:BigInteger = this.subtract(BigInteger.ONE);
      var local3:int = local2.getLowestSetBit();
      if(local3 <= 0) {
        return false;
      }
      var local4:BigInteger = local2.shiftRight(local3);
      param1 = param1 + 1 >> 1;
      if(param1 > lowprimes.length) {
        param1 = int(lowprimes.length);
      }
      var local5:BigInteger = new BigInteger();
      var local6:int = 0;
      while(local6 < param1) {
        local5.bi_internal::fromInt(lowprimes[local6]);
        local7 = local5.modPow(local4,this);
        if(local7.compareTo(BigInteger.ONE) != 0 && local7.compareTo(local2) != 0) {
          local8 = 1;
          while(local8++ < local3 && local7.compareTo(local2) != 0) {
            local7 = local7.modPowInt(2,this);
            if(local7.compareTo(BigInteger.ONE) == 0) {
              return false;
            }
          }
          if(local7.compareTo(local2) != 0) {
            return false;
          }
        }
        local6++;
      }
      return true;
    }

    public function primify(param1:int, param2:int) : void {
      if(!this.testBit(param1 - 1)) {
        this.bitwiseTo(BigInteger.ONE.shiftLeft(param1 - 1),this.op_or,this);
      }
      if(this.bi_internal::isEven()) {
        this.bi_internal::dAddOffset(1,0);
      }
      while(!this.isProbablePrime(param2)) {
        this.bi_internal::dAddOffset(2,0);
        while(this.bitLength() > param1) {
          this.bi_internal::subTo(BigInteger.ONE.shiftLeft(param1 - 1),this);
        }
      }
    }
  }
}
