package com.hurlant.crypto.prng {
  import com.hurlant.crypto.symmetric.IStreamCipher;
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;

  public class ARC4 implements IPRNG, IStreamCipher {
    private var i:int = 0;
    private var j:int = 0;
    private var S:ByteArray;

    private const psize:uint = 256;

    public function ARC4(param1:ByteArray = null) {
      super();
      this.S = new ByteArray();
      if(Boolean(param1)) {
        this.init(param1);
      }
    }

    public function getPoolSize() : uint {
      return this.psize;
    }

    public function init(param1:ByteArray) : void {
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = 0;
      local2 = 0;
      while(local2 < 256) {
        this.S[local2] = local2;
        local2++;
      }
      local3 = 0;
      local2 = 0;
      while(local2 < 256) {
        local3 = local3 + this.S[local2] + param1[local2 % param1.length] & 0xFF;
        local4 = int(this.S[local2]);
        this.S[local2] = this.S[local3];
        this.S[local3] = local4;
        local2++;
      }
      this.i = 0;
      this.j = 0;
    }

    public function next() : uint {
      var local1:int = 0;
      this.i = this.i + 1 & 0xFF;
      this.j = this.j + this.S[this.i] & 0xFF;
      local1 = int(this.S[this.i]);
      this.S[this.i] = this.S[this.j];
      this.S[this.j] = local1;
      return this.S[local1 + this.S[this.i] & 0xFF];
    }

    public function getBlockSize() : uint {
      return 1;
    }

    public function encrypt(param1:ByteArray) : void {
      var local2:uint = 0;
      while(local2 < param1.length) {
        var local3:* = local2++;
        param1[local3] ^= this.next();
      }
    }

    public function decrypt(param1:ByteArray) : void {
      this.encrypt(param1);
    }

    public function dispose() : void {
      var local1:uint = 0;
      if(this.S != null) {
        local1 = 0;
        while(local1 < this.S.length) {
          this.S[local1] = Math.random() * 256;
          local1++;
        }
        this.S.length = 0;
        this.S = null;
      }
      this.i = 0;
      this.j = 0;
      Memory.gc();
    }

    public function toString() : String {
      return "rc4";
    }
  }
}
