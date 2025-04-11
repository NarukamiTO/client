package com.hurlant.math {
  use namespace bi_internal;

  internal class MontgomeryReduction implements IReduction {
    private var m:BigInteger;
    private var mp:int;
    private var mpl:int;
    private var mph:int;
    private var um:int;
    private var mt2:int;

    public function MontgomeryReduction(param1:BigInteger) {
      super();
      this.m = param1;
      this.mp = param1.bi_internal::invDigit();
      this.mpl = this.mp & 0x7FFF;
      this.mph = this.mp >> 15;
      this.um = (1 << BigInteger.DB - 15) - 1;
      this.mt2 = 2 * param1.t;
    }

    public function convert(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      param1.abs().bi_internal::dlShiftTo(this.m.t,local2);
      local2.bi_internal::divRemTo(this.m,null,local2);
      if(param1.bi_internal::s < 0 && local2.compareTo(BigInteger.ZERO) > 0) {
        this.m.bi_internal::subTo(local2,local2);
      }
      return local2;
    }

    public function revert(param1:BigInteger) : BigInteger {
      var local2:BigInteger = new BigInteger();
      param1.bi_internal::copyTo(local2);
      this.reduce(local2);
      return local2;
    }

    public function reduce(param1:BigInteger) : void {
      var local3:int = 0;
      var local4:int = 0;
      while(param1.t <= this.mt2) {
        var local5:* = param1.t++;
        param1.bi_internal::a[local5] = 0;
      }
      var local2:int = 0;
      while(local2 < this.m.t) {
        local3 = param1.bi_internal::a[local2] & 0x7FFF;
        local4 = local3 * this.mpl + ((local3 * this.mph + (param1.bi_internal::a[local2] >> 15) * this.mpl & this.um) << 15) & BigInteger.DM;
        local3 = local2 + this.m.t;
        param1.bi_internal::a[local3] += this.m.bi_internal::am(0,local4,param1,local2,0,this.m.t);
        while(param1.bi_internal::a[local3] >= BigInteger.DV) {
          param1.bi_internal::a[local3] -= BigInteger.DV;
          ++param1.bi_internal::a[++local3];
        }
        local2++;
      }
      param1.bi_internal::clamp();
      param1.bi_internal::drShiftTo(this.m.t,param1);
      if(param1.compareTo(this.m) >= 0) {
        param1.bi_internal::subTo(this.m,param1);
      }
    }

    public function sqrTo(param1:BigInteger, param2:BigInteger) : void {
      param1.bi_internal::squareTo(param2);
      this.reduce(param2);
    }

    public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void {
      param1.bi_internal::multiplyTo(param2,param3);
      this.reduce(param3);
    }
  }
}
