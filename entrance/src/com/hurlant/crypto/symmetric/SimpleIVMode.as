package com.hurlant.crypto.symmetric {
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;

  public class SimpleIVMode implements IMode, ICipher {
    protected var mode:IVMode;
    protected var cipher:ICipher;

    public function SimpleIVMode(param1:IVMode) {
      super();
      this.mode = param1;
      this.cipher = param1 as ICipher;
    }

    public function getBlockSize() : uint {
      return this.mode.getBlockSize();
    }

    public function dispose() : void {
      this.mode.dispose();
      this.mode = null;
      this.cipher = null;
      Memory.gc();
    }

    public function encrypt(param1:ByteArray) : void {
      this.cipher.encrypt(param1);
      var local2:ByteArray = new ByteArray();
      local2.writeBytes(this.mode.IV);
      local2.writeBytes(param1);
      param1.position = 0;
      param1.writeBytes(local2);
    }

    public function decrypt(param1:ByteArray) : void {
      var local2:ByteArray = new ByteArray();
      local2.writeBytes(param1,0,this.getBlockSize());
      this.mode.IV = local2;
      local2 = new ByteArray();
      local2.writeBytes(param1,this.getBlockSize());
      this.cipher.decrypt(local2);
      param1.length = 0;
      param1.writeBytes(local2);
    }

    public function toString() : String {
      return "simple-" + this.cipher.toString();
    }
  }
}
