package com.hurlant.crypto.rsa {
  import com.hurlant.crypto.prng.Random;
  import com.hurlant.crypto.tls.TLSError;
  import com.hurlant.math.BigInteger;
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;

  public class RSAKey {
    public var e:int;
    public var n:BigInteger;
    public var d:BigInteger;
    public var p:BigInteger;
    public var q:BigInteger;
    public var dmp1:BigInteger;
    public var dmq1:BigInteger;
    public var coeff:BigInteger;

    protected var canDecrypt:Boolean;
    protected var canEncrypt:Boolean;

    public function RSAKey(param1:BigInteger, param2:int, param3:BigInteger = null, param4:BigInteger = null, param5:BigInteger = null, param6:BigInteger = null, param7:BigInteger = null, param8:BigInteger = null) {
      super();
      this.n = param1;
      this.e = param2;
      this.d = param3;
      this.p = param4;
      this.q = param5;
      this.dmp1 = param6;
      this.dmq1 = param7;
      this.coeff = param8;
      this.canEncrypt = this.n != null && this.e != 0;
      this.canDecrypt = this.canEncrypt && this.d != null;
    }

    public static function parsePublicKey(param1:String, param2:String) : RSAKey {
      return new RSAKey(new BigInteger(param1,16,true),parseInt(param2,16));
    }

    public static function parsePrivateKey(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null) : RSAKey {
      if(param4 == null) {
        return new RSAKey(new BigInteger(param1,16,true),parseInt(param2,16),new BigInteger(param3,16,true));
      }
      return new RSAKey(new BigInteger(param1,16,true),parseInt(param2,16),new BigInteger(param3,16,true),new BigInteger(param4,16,true),new BigInteger(param5,16,true),new BigInteger(param6,16,true),new BigInteger(param7,16,true),new BigInteger(param8,16,true));
    }

    public static function generate(param1:uint, param2:String) : RSAKey {
      var local7:BigInteger = null;
      var local8:BigInteger = null;
      var local9:BigInteger = null;
      var local10:BigInteger = null;
      var local3:Random = new Random();
      var local4:uint = uint(param1 >> 1);
      var local5:RSAKey = new RSAKey(null,0,null);
      local5.e = parseInt(param2,16);
      var local6:BigInteger = new BigInteger(param2,16,true);
      while(true) {
        while(true) {
          local5.p = bigRandom(param1 - local4,local3);
          if(local5.p.subtract(BigInteger.ONE).gcd(local6).compareTo(BigInteger.ONE) == 0 && local5.p.isProbablePrime(10)) {
            break;
          }
        }
        while(true) {
          local5.q = bigRandom(local4,local3);
          if(local5.q.subtract(BigInteger.ONE).gcd(local6).compareTo(BigInteger.ONE) == 0 && local5.q.isProbablePrime(10)) {
            break;
          }
        }
        if(local5.p.compareTo(local5.q) <= 0) {
          local10 = local5.p;
          local5.p = local5.q;
          local5.q = local10;
        }
        local7 = local5.p.subtract(BigInteger.ONE);
        local8 = local5.q.subtract(BigInteger.ONE);
        local9 = local7.multiply(local8);
        if(local9.gcd(local6).compareTo(BigInteger.ONE) == 0) {
          local5.n = local5.p.multiply(local5.q);
          local5.d = local6.modInverse(local9);
          local5.dmp1 = local5.d.mod(local7);
          local5.dmq1 = local5.d.mod(local8);
          local5.coeff = local5.q.modInverse(local5.p);
          break;
        }
      }
      return local5;
    }

    protected static function bigRandom(param1:int, param2:Random) : BigInteger {
      if(param1 < 2) {
        return BigInteger.nbv(1);
      }
      var local3:ByteArray = new ByteArray();
      param2.nextBytes(local3,param1 >> 3);
      local3.position = 0;
      var local4:BigInteger = new BigInteger(local3,0,true);
      local4.primify(param1,1);
      return local4;
    }

    public function getBlockSize() : uint {
      return (this.n.bitLength() + 7) / 8;
    }

    public function dispose() : void {
      this.e = 0;
      this.n.dispose();
      this.n = null;
      Memory.gc();
    }

    public function encrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void {
      this._encrypt(this.doPublic,param1,param2,param3,param4,2);
    }

    public function decrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void {
      this._decrypt(this.doPrivate2,param1,param2,param3,param4,2);
    }

    public function sign(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void {
      this._encrypt(this.doPrivate2,param1,param2,param3,param4,1);
    }

    public function verify(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void {
      this._decrypt(this.doPublic,param1,param2,param3,param4,1);
    }

    private function _encrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void {
      var local9:BigInteger = null;
      var local10:BigInteger = null;
      if(param5 == null) {
        param5 = this.pkcs1pad;
      }
      if(param2.position >= param2.length) {
        param2.position = 0;
      }
      var local7:uint = this.getBlockSize();
      var local8:int = int(param2.position + param4);
      while(param2.position < local8) {
        local9 = new BigInteger(param5(param2,local8,local7,param6),local7,true);
        local10 = param1(local9);
        local10.toArray(param3);
      }
    }

    private function _decrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void {
      var local9:BigInteger = null;
      var local10:BigInteger = null;
      var local11:ByteArray = null;
      if(param5 == null) {
        param5 = this.pkcs1unpad;
      }
      if(param2.position >= param2.length) {
        param2.position = 0;
      }
      var local7:uint = this.getBlockSize();
      var local8:int = int(param2.position + param4);
      while(param2.position < local8) {
        local9 = new BigInteger(param2,local7,true);
        local10 = param1(local9);
        local11 = param5(local10,local7,param6);
        if(local11 == null) {
          throw new TLSError("Decrypt error - padding function returned null!",TLSError.decode_error);
        }
        param3.writeBytes(local11);
      }
    }

    private function pkcs1pad(param1:ByteArray, param2:int, param3:uint, param4:uint = 2) : ByteArray {
      var local8:Random = null;
      var local9:int = 0;
      var local5:ByteArray = new ByteArray();
      var local6:uint = param1.position;
      param2 = Math.min(param2,param1.length,local6 + param3 - 11);
      param1.position = param2;
      var local7:int = param2 - 1;
      while(local7 >= local6 && param3 > 11) {
        var local10:* = --param3;
        local5[local10] = param1[local7--];
      }
      local10 = --param3;
      local5[local10] = 0;
      if(param4 == 2) {
        local8 = new Random();
        local9 = 0;
        while(param3 > 2) {
          do {
            local9 = local8.nextByte();
          }
          while(local9 == 0);
          var local11:* = --param3;
          local5[local11] = local9;
        }
      } else {
        while(param3 > 2) {
          local11 = --param3;
          local5[local11] = 255;
        }
      }
      local11 = --param3;
      local5[local11] = param4;
      var local12:* = --param3;
      local5[local12] = 0;
      return local5;
    }

    private function pkcs1unpad(param1:BigInteger, param2:uint, param3:uint = 2) : ByteArray {
      var local4:ByteArray = param1.toByteArray();
      var local5:ByteArray = new ByteArray();
      local4.position = 0;
      var local6:int = 0;
      while(local6 < local4.length && local4[local6] == 0) {
        local6++;
      }
      if(local4.length - local6 != param2 - 1 || local4[local6] != param3) {
        return null;
      }
      local6++;
      while(local4[local6] != 0) {
        if(++local6 >= local4.length) {
          return null;
        }
      }
      while(++local6 < local4.length) {
        local5.writeByte(local4[local6]);
      }
      local5.position = 0;
      return local5;
    }

    public function rawpad(param1:ByteArray, param2:int, param3:uint, param4:uint = 0) : ByteArray {
      return param1;
    }

    public function rawunpad(param1:BigInteger, param2:uint, param3:uint = 0) : ByteArray {
      return param1.toByteArray();
    }

    public function toString() : String {
      return "rsa";
    }

    public function dump() : String {
      var local1:String = "N=" + this.n.toString(16) + "\n" + "E=" + this.e.toString(16) + "\n";
      if(this.canDecrypt) {
        local1 += "D=" + this.d.toString(16) + "\n";
        if(this.p != null && this.q != null) {
          local1 += "P=" + this.p.toString(16) + "\n";
          local1 += "Q=" + this.q.toString(16) + "\n";
          local1 += "DMP1=" + this.dmp1.toString(16) + "\n";
          local1 += "DMQ1=" + this.dmq1.toString(16) + "\n";
          local1 += "IQMP=" + this.coeff.toString(16) + "\n";
        }
      }
      return local1;
    }

    protected function doPublic(param1:BigInteger) : BigInteger {
      return param1.modPowInt(this.e,this.n);
    }

    protected function doPrivate2(param1:BigInteger) : BigInteger {
      if(this.p == null && this.q == null) {
        return param1.modPow(this.d,this.n);
      }
      var local2:BigInteger = param1.mod(this.p).modPow(this.dmp1,this.p);
      var local3:BigInteger = param1.mod(this.q).modPow(this.dmq1,this.q);
      while(local2.compareTo(local3) < 0) {
        local2 = local2.add(this.p);
      }
      return local2.subtract(local3).multiply(this.coeff).mod(this.p).multiply(this.q).add(local3);
    }

    protected function doPrivate(param1:BigInteger) : BigInteger {
      if(this.p == null || this.q == null) {
        return param1.modPow(this.d,this.n);
      }
      var local2:BigInteger = param1.mod(this.p).modPow(this.dmp1,this.p);
      var local3:BigInteger = param1.mod(this.q).modPow(this.dmq1,this.q);
      while(local2.compareTo(local3) < 0) {
        local2 = local2.add(this.p);
      }
      return local2.subtract(local3).multiply(this.coeff).mod(this.p).multiply(this.q).add(local3);
    }
  }
}
