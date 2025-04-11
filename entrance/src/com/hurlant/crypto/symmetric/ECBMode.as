package com.hurlant.crypto.symmetric {
  import com.hurlant.util.Memory;
  import flash.utils.ByteArray;

  public class ECBMode implements IMode, ICipher {
    private var key:ISymmetricKey;
    private var padding:IPad;

    public function ECBMode(param1:ISymmetricKey, param2:IPad = null) {
      super();
      this.key = param1;
      if(param2 == null) {
        param2 = new PKCS5(param1.getBlockSize());
      } else {
        param2.setBlockSize(param1.getBlockSize());
      }
      this.padding = param2;
    }

    public function getBlockSize() : uint {
      return this.key.getBlockSize();
    }

    public function encrypt(param1:ByteArray) : void {
      this.padding.pad(param1);
      param1.position = 0;
      var local2:uint = this.key.getBlockSize();
      var local3:ByteArray = new ByteArray();
      var local4:ByteArray = new ByteArray();
      var local5:uint = 0;
      while(local5 < param1.length) {
        local3.length = 0;
        param1.readBytes(local3,0,local2);
        this.key.encrypt(local3);
        local4.writeBytes(local3);
        local5 += local2;
      }
      param1.length = 0;
      param1.writeBytes(local4);
    }

    public function decrypt(param1:ByteArray) : void {
      param1.position = 0;
      var local2:uint = this.key.getBlockSize();
      if(param1.length % local2 != 0) {
        throw new Error("ECB mode cipher length must be a multiple of blocksize " + local2);
      }
      var local3:ByteArray = new ByteArray();
      var local4:ByteArray = new ByteArray();
      var local5:uint = 0;
      while(local5 < param1.length) {
        local3.length = 0;
        param1.readBytes(local3,0,local2);
        this.key.decrypt(local3);
        local4.writeBytes(local3);
        local5 += local2;
      }
      this.padding.unpad(local4);
      param1.length = 0;
      param1.writeBytes(local4);
    }

    public function dispose() : void {
      this.key.dispose();
      this.key = null;
      this.padding = null;
      Memory.gc();
    }

    public function toString() : String {
      return this.key.toString() + "-ecb";
    }
  }
}
