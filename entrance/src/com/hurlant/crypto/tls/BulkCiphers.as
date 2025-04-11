package com.hurlant.crypto.tls {
  import com.hurlant.crypto.Crypto;
  import com.hurlant.crypto.symmetric.ICipher;
  import com.hurlant.crypto.symmetric.SSLPad;
  import com.hurlant.crypto.symmetric.TLSPad;
  import flash.utils.ByteArray;

  public class BulkCiphers {
    private static var _props:Array;

    public static const STREAM_CIPHER:uint = 0;
    public static const BLOCK_CIPHER:uint = 1;
    public static const NULL:uint = 0;
    public static const RC4_40:uint = 1;
    public static const RC4_128:uint = 2;
    public static const RC2_CBC_40:uint = 3;
    public static const DES_CBC:uint = 4;
    public static const DES3_EDE_CBC:uint = 5;
    public static const DES40_CBC:uint = 6;
    public static const IDEA_CBC:uint = 7;
    public static const AES_128:uint = 8;
    public static const AES_256:uint = 9;

    private static const algos:Array = ["","rc4","rc4","","des-cbc","3des-cbc","des-cbc","","aes","aes"];

    init();

    private var type:uint;
    private var keyBytes:uint;
    private var expandedKeyBytes:uint;
    private var effectiveKeyBits:uint;
    private var IVSize:uint;
    private var blockSize:uint;

    public function BulkCiphers(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint) {
      super();
      this.type = param1;
      this.keyBytes = param2;
      this.expandedKeyBytes = param3;
      this.effectiveKeyBits = param4;
      this.IVSize = param5;
      this.blockSize = param6;
    }

    private static function init() : void {
      _props = [];
      _props[NULL] = new BulkCiphers(STREAM_CIPHER,0,0,0,0,0);
      _props[RC4_40] = new BulkCiphers(STREAM_CIPHER,5,16,40,0,0);
      _props[RC4_128] = new BulkCiphers(STREAM_CIPHER,16,16,128,0,0);
      _props[RC2_CBC_40] = new BulkCiphers(BLOCK_CIPHER,5,16,40,8,8);
      _props[DES_CBC] = new BulkCiphers(BLOCK_CIPHER,8,8,56,8,8);
      _props[DES3_EDE_CBC] = new BulkCiphers(BLOCK_CIPHER,24,24,168,8,8);
      _props[DES40_CBC] = new BulkCiphers(BLOCK_CIPHER,5,8,40,8,8);
      _props[IDEA_CBC] = new BulkCiphers(BLOCK_CIPHER,16,16,128,8,8);
      _props[AES_128] = new BulkCiphers(BLOCK_CIPHER,16,16,128,16,16);
      _props[AES_256] = new BulkCiphers(BLOCK_CIPHER,32,32,256,16,16);
    }

    private static function getProp(param1:uint) : BulkCiphers {
      var local2:BulkCiphers = _props[param1];
      if(local2 == null) {
        throw new Error("Unknown bulk cipher " + param1.toString(16));
      }
      return local2;
    }

    public static function getType(param1:uint) : uint {
      return getProp(param1).type;
    }

    public static function getKeyBytes(param1:uint) : uint {
      return getProp(param1).keyBytes;
    }

    public static function getExpandedKeyBytes(param1:uint) : uint {
      return getProp(param1).expandedKeyBytes;
    }

    public static function getEffectiveKeyBits(param1:uint) : uint {
      return getProp(param1).effectiveKeyBits;
    }

    public static function getIVSize(param1:uint) : uint {
      return getProp(param1).IVSize;
    }

    public static function getBlockSize(param1:uint) : uint {
      return getProp(param1).blockSize;
    }

    public static function getCipher(param1:uint, param2:ByteArray, param3:uint) : ICipher {
      if(param3 == TLSSecurityParameters.PROTOCOL_VERSION) {
        return Crypto.getCipher(algos[param1],param2,new TLSPad());
      }
      return Crypto.getCipher(algos[param1],param2,new SSLPad());
    }
  }
}
