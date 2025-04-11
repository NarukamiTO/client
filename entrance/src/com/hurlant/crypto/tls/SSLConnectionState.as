package com.hurlant.crypto.tls {
  import com.hurlant.crypto.hash.MAC;
  import com.hurlant.crypto.symmetric.ICipher;
  import com.hurlant.crypto.symmetric.IVMode;
  import com.hurlant.util.ArrayUtil;
  import flash.utils.ByteArray;

  public class SSLConnectionState implements IConnectionState {
    private var bulkCipher:uint;
    private var cipherType:uint;
    private var CIPHER_key:ByteArray;
    private var CIPHER_IV:ByteArray;
    private var cipher:ICipher;
    private var ivmode:IVMode;
    private var macAlgorithm:uint;
    private var MAC_write_secret:ByteArray;
    private var mac:MAC;
    private var seq_lo:uint = 0;
    private var seq_hi:uint = 0;

    public function SSLConnectionState(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:ByteArray = null, param5:ByteArray = null, param6:ByteArray = null) {
      super();
      this.bulkCipher = param1;
      this.cipherType = param2;
      this.macAlgorithm = param3;
      this.MAC_write_secret = param4;
      this.mac = MACs.getMAC(param3);
      this.CIPHER_key = param5;
      this.CIPHER_IV = param6;
      this.cipher = BulkCiphers.getCipher(param1,param5,768);
      if(this.cipher is IVMode) {
        this.ivmode = this.cipher as IVMode;
        this.ivmode.IV = param6;
      }
    }

    public function decrypt(param1:uint, param2:uint, param3:ByteArray) : ByteArray {
      var local4:ByteArray = null;
      var local5:ByteArray = null;
      var local6:uint = 0;
      var local7:ByteArray = null;
      var local8:ByteArray = null;
      if(this.cipherType == BulkCiphers.STREAM_CIPHER) {
        if(this.bulkCipher != BulkCiphers.NULL) {
          this.cipher.decrypt(param3);
        }
      } else {
        param3.position = 0;
        if(this.bulkCipher != BulkCiphers.NULL) {
          local4 = new ByteArray();
          local4.writeBytes(param3,param3.length - this.CIPHER_IV.length,this.CIPHER_IV.length);
          param3.position = 0;
          this.cipher.decrypt(param3);
          this.CIPHER_IV = local4;
          this.ivmode.IV = local4;
        }
      }
      if(this.macAlgorithm != MACs.NULL) {
        local5 = new ByteArray();
        local6 = uint(param3.length - this.mac.getHashSize());
        local5.writeUnsignedInt(this.seq_hi);
        local5.writeUnsignedInt(this.seq_lo);
        local5.writeByte(param1);
        local5.writeShort(local6);
        if(local6 != 0) {
          local5.writeBytes(param3,0,local6);
        }
        local7 = this.mac.compute(this.MAC_write_secret,local5);
        local8 = new ByteArray();
        local8.writeBytes(param3,local6,this.mac.getHashSize());
        if(!ArrayUtil.equals(local7,local8)) {
          throw new TLSError("Bad Mac Data",TLSError.bad_record_mac);
        }
        param3.length = local6;
        param3.position = 0;
      }
      ++this.seq_lo;
      if(this.seq_lo == 0) {
        ++this.seq_hi;
      }
      return param3;
    }

    public function encrypt(param1:uint, param2:ByteArray) : ByteArray {
      var local4:ByteArray = null;
      var local5:ByteArray = null;
      var local3:ByteArray = null;
      if(this.macAlgorithm != MACs.NULL) {
        local4 = new ByteArray();
        local4.writeUnsignedInt(this.seq_hi);
        local4.writeUnsignedInt(this.seq_lo);
        local4.writeByte(param1);
        local4.writeShort(param2.length);
        if(param2.length != 0) {
          local4.writeBytes(param2);
        }
        local3 = this.mac.compute(this.MAC_write_secret,local4);
        param2.position = param2.length;
        param2.writeBytes(local3);
      }
      param2.position = 0;
      if(this.cipherType == BulkCiphers.STREAM_CIPHER) {
        if(this.bulkCipher != BulkCiphers.NULL) {
          this.cipher.encrypt(param2);
        }
      } else {
        this.cipher.encrypt(param2);
        local5 = new ByteArray();
        local5.writeBytes(param2,param2.length - this.CIPHER_IV.length,this.CIPHER_IV.length);
        this.CIPHER_IV = local5;
        this.ivmode.IV = local5;
      }
      ++this.seq_lo;
      if(this.seq_lo == 0) {
        ++this.seq_hi;
      }
      return param2;
    }
  }
}
