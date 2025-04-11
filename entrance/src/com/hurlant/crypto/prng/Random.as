package com.hurlant.crypto.prng {
  import com.hurlant.util.Memory;
  import flash.system.Capabilities;
  import flash.system.System;
  import flash.text.Font;
  import flash.utils.ByteArray;
  import flash.utils.getTimer;

  public class Random {
    private var state:IPRNG;
    private var ready:Boolean = false;
    private var pool:ByteArray;
    private var psize:int;
    private var pptr:int;
    private var seeded:Boolean = false;

    public function Random(param1:Class = null) {
      var local2:uint = 0;
      super();
      if(param1 == null) {
        param1 = ARC4;
      }
      this.state = new param1() as IPRNG;
      this.psize = this.state.getPoolSize();
      this.pool = new ByteArray();
      this.pptr = 0;
      while(this.pptr < this.psize) {
        local2 = 65536 * Math.random();
        var local3:* = this.pptr++;
        this.pool[local3] = local2 >>> 8;
        var local4:* = this.pptr++;
        this.pool[local4] = local2 & 0xFF;
      }
      this.pptr = 0;
      this.seed();
    }

    public function seed(param1:int = 0) : void {
      if(param1 == 0) {
        param1 = new Date().getTime();
      }
      var local2:* = this.pptr++;
      this.pool[local2] ^= param1 & 0xFF;
      var local3:* = this.pptr++;
      this.pool[local3] ^= param1 >> 8 & 0xFF;
      var local4:* = this.pptr++;
      this.pool[local4] ^= param1 >> 16 & 0xFF;
      var local5:* = this.pptr++;
      this.pool[local5] ^= param1 >> 24 & 0xFF;
      this.pptr %= this.psize;
      this.seeded = true;
    }

    public function autoSeed() : void {
      var local3:Font = null;
      var local1:ByteArray = new ByteArray();
      local1.writeUnsignedInt(System.totalMemory);
      local1.writeUTF(Capabilities.serverString);
      local1.writeUnsignedInt(getTimer());
      local1.writeUnsignedInt(new Date().getTime());
      var local2:Array = Font.enumerateFonts(true);
      for each(local3 in local2) {
        local1.writeUTF(local3.fontName);
        local1.writeUTF(local3.fontStyle);
        local1.writeUTF(local3.fontType);
      }
      local1.position = 0;
      while(local1.bytesAvailable >= 4) {
        this.seed(local1.readUnsignedInt());
      }
    }

    public function nextBytes(param1:ByteArray, param2:int) : void {
      while(Boolean(param2--)) {
        param1.writeByte(this.nextByte());
      }
    }

    public function nextByte() : int {
      if(!this.ready) {
        if(!this.seeded) {
          this.autoSeed();
        }
        this.state.init(this.pool);
        this.pool.length = 0;
        this.pptr = 0;
        this.ready = true;
      }
      return this.state.next();
    }

    public function dispose() : void {
      var local1:uint = 0;
      while(local1 < this.pool.length) {
        this.pool[local1] = Math.random() * 256;
        local1++;
      }
      this.pool.length = 0;
      this.pool = null;
      this.state.dispose();
      this.state = null;
      this.psize = 0;
      this.pptr = 0;
      Memory.gc();
    }

    public function toString() : String {
      return "random-" + this.state.toString();
    }
  }
}
