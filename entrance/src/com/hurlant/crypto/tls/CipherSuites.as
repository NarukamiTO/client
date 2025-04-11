package com.hurlant.crypto.tls {
  public class CipherSuites {
    private static var _props:Array;

    public static const TLS_NULL_WITH_NULL_NULL:uint = 0;
    public static const TLS_RSA_WITH_NULL_MD5:uint = 1;
    public static const TLS_RSA_WITH_NULL_SHA:uint = 2;
    public static const TLS_RSA_WITH_RC4_128_MD5:uint = 4;
    public static const TLS_RSA_WITH_RC4_128_SHA:uint = 5;
    public static const TLS_RSA_WITH_IDEA_CBC_SHA:uint = 7;
    public static const TLS_RSA_WITH_DES_CBC_SHA:uint = 9;
    public static const TLS_RSA_WITH_3DES_EDE_CBC_SHA:uint = 10;
    public static const TLS_DH_DSS_WITH_DES_CBC_SHA:uint = 12;
    public static const TLS_DH_DSS_WITH_3DES_EDE_CBC_SHA:uint = 13;
    public static const TLS_DH_RSA_WITH_DES_CBC_SHA:uint = 15;
    public static const TLS_DH_RSA_WITH_3DES_EDE_CBC_SHA:uint = 16;
    public static const TLS_DHE_DSS_WITH_DES_CBC_SHA:uint = 18;
    public static const TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA:uint = 19;
    public static const TLS_DHE_RSA_WITH_DES_CBC_SHA:uint = 21;
    public static const TLS_DHE_RSA_WITH_3DES_EDE_CBC_SHA:uint = 22;
    public static const TLS_DH_anon_WITH_RC4_128_MD5:uint = 24;
    public static const TLS_DH_anon_WITH_DES_CBC_SHA:uint = 26;
    public static const TLS_DH_anon_WITH_3DES_EDE_CBC_SHA:uint = 27;
    public static const TLS_RSA_WITH_AES_128_CBC_SHA:uint = 47;
    public static const TLS_DH_DSS_WITH_AES_128_CBC_SHA:uint = 48;
    public static const TLS_DH_RSA_WITH_AES_128_CBC_SHA:uint = 49;
    public static const TLS_DHE_DSS_WITH_AES_128_CBC_SHA:uint = 50;
    public static const TLS_DHE_RSA_WITH_AES_128_CBC_SHA:uint = 51;
    public static const TLS_DH_anon_WITH_AES_128_CBC_SHA:uint = 52;
    public static const TLS_RSA_WITH_AES_256_CBC_SHA:uint = 53;
    public static const TLS_DH_DSS_WITH_AES_256_CBC_SHA:uint = 54;
    public static const TLS_DH_RSA_WITH_AES_256_CBC_SHA:uint = 55;
    public static const TLS_DHE_DSS_WITH_AES_256_CBC_SHA:uint = 56;
    public static const TLS_DHE_RSA_WITH_AES_256_CBC_SHA:uint = 57;
    public static const TLS_DH_anon_WITH_AES_256_CBC_SHA:uint = 58;

    init();

    public var cipher:uint;
    public var hash:uint;
    public var key:uint;

    public function CipherSuites(param1:uint, param2:uint, param3:uint) {
      super();
      this.cipher = param1;
      this.hash = param2;
      this.key = param3;
    }

    private static function init() : void {
      _props = [];
      _props[TLS_NULL_WITH_NULL_NULL] = new CipherSuites(BulkCiphers.NULL,MACs.NULL,KeyExchanges.NULL);
      _props[TLS_RSA_WITH_NULL_MD5] = new CipherSuites(BulkCiphers.NULL,MACs.MD5,KeyExchanges.RSA);
      _props[TLS_RSA_WITH_NULL_SHA] = new CipherSuites(BulkCiphers.NULL,MACs.SHA1,KeyExchanges.RSA);
      _props[TLS_RSA_WITH_RC4_128_MD5] = new CipherSuites(BulkCiphers.RC4_128,MACs.MD5,KeyExchanges.RSA);
      _props[TLS_RSA_WITH_RC4_128_SHA] = new CipherSuites(BulkCiphers.RC4_128,MACs.SHA1,KeyExchanges.RSA);
      _props[TLS_RSA_WITH_DES_CBC_SHA] = new CipherSuites(BulkCiphers.DES_CBC,MACs.SHA1,KeyExchanges.RSA);
      _props[TLS_RSA_WITH_3DES_EDE_CBC_SHA] = new CipherSuites(BulkCiphers.DES3_EDE_CBC,MACs.SHA1,KeyExchanges.RSA);
      _props[TLS_RSA_WITH_AES_128_CBC_SHA] = new CipherSuites(BulkCiphers.AES_128,MACs.SHA1,KeyExchanges.RSA);
      _props[TLS_RSA_WITH_AES_256_CBC_SHA] = new CipherSuites(BulkCiphers.AES_256,MACs.SHA1,KeyExchanges.RSA);
    }

    private static function getProp(param1:uint) : CipherSuites {
      var local2:CipherSuites = _props[param1];
      if(local2 == null) {
        throw new Error("Unknown cipher " + param1.toString(16));
      }
      return local2;
    }

    public static function getBulkCipher(param1:uint) : uint {
      return getProp(param1).cipher;
    }

    public static function getMac(param1:uint) : uint {
      return getProp(param1).hash;
    }

    public static function getKeyExchange(param1:uint) : uint {
      return getProp(param1).key;
    }

    public static function getDefaultSuites() : Array {
      return [TLS_RSA_WITH_AES_128_CBC_SHA];
    }
  }
}
