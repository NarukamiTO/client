package com.hurlant.crypto.symmetric {
  import com.hurlant.crypto.prng.Random;
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;

  public class IVMode {
    protected var key:ISymmetricKey;
    protected var padding:IPad;
    protected var prng:Random;
    protected var iv:ByteArray;
    protected var lastIV:ByteArray;
    protected var blockSize:uint;

    public function IVMode(param1:ISymmetricKey, param2:IPad = null) {
      super();
      this.key = param1;
      this.blockSize = param1.getBlockSize();
      if(param2 == null) {
        param2 = new PKCS5(this.blockSize);
      } else {
        param2.setBlockSize(this.blockSize);
      }
      this.padding = param2;
      this.prng = new Random();
      this.iv = null;
      this.lastIV = new ByteArray();
    }

    public function getBlockSize() : uint {
      return this.key.getBlockSize();
    }

    public function dispose() : void {
      var local1:uint = 0;
      if(this.iv != null) {
        local1 = 0;
        while(local1 < this.iv.length) {
          this.iv[local1] = this.prng.nextByte();
          local1++;
        }
        this.iv.length = 0;
        this.iv = null;
      }
      if(this.lastIV != null) {
        local1 = 0;
        while(local1 < this.iv.length) {
          this.lastIV[local1] = this.prng.nextByte();
          local1++;
        }
        this.lastIV.length = 0;
        this.lastIV = null;
      }
      this.key.dispose();
      this.key = null;
      this.padding = null;
      this.prng.dispose();
      this.prng = null;
      Memory.gc();
    }

    public function set IV(param1:ByteArray) : void {
      this.iv = param1;
      this.lastIV.length = 0;
      this.lastIV.writeBytes(this.iv);
    }

    public function get IV() : ByteArray {
      return this.lastIV;
    }

    protected function getIV4e() : ByteArray {
      var local1:ByteArray = new ByteArray();
      if(Boolean(this.iv)) {
        local1.writeBytes(this.iv);
      } else {
        this.prng.nextBytes(local1,this.blockSize);
      }
      this.lastIV.length = 0;
      this.lastIV.writeBytes(local1);
      return local1;
    }

    protected function getIV4d() : ByteArray {
      var local1:ByteArray = new ByteArray();
      if(Boolean(this.iv)) {
        local1.writeBytes(this.iv);
        return local1;
      }
      throw new Error("an IV must be set before calling decrypt()");
    }
  }
}
