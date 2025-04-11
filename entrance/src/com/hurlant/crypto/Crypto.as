package com.hurlant.crypto {
  import com.hurlant.crypto.hash.HMAC;
  import com.hurlant.crypto.hash.IHash;
  import com.hurlant.crypto.hash.MAC;
  import com.hurlant.crypto.hash.MD2;
  import com.hurlant.crypto.hash.MD5;
  import com.hurlant.crypto.hash.SHA1;
  import com.hurlant.crypto.hash.SHA224;
  import com.hurlant.crypto.hash.SHA256;
  import com.hurlant.crypto.prng.ARC4;
  import com.hurlant.crypto.rsa.RSAKey;
  import com.hurlant.crypto.symmetric.AESKey;
  import com.hurlant.crypto.symmetric.BlowFishKey;
  import com.hurlant.crypto.symmetric.CBCMode;
  import com.hurlant.crypto.symmetric.CFB8Mode;
  import com.hurlant.crypto.symmetric.CFBMode;
  import com.hurlant.crypto.symmetric.CTRMode;
  import com.hurlant.crypto.symmetric.DESKey;
  import com.hurlant.crypto.symmetric.ECBMode;
  import com.hurlant.crypto.symmetric.ICipher;
  import com.hurlant.crypto.symmetric.IMode;
  import com.hurlant.crypto.symmetric.IPad;
  import com.hurlant.crypto.symmetric.ISymmetricKey;
  import com.hurlant.crypto.symmetric.IVMode;
  import com.hurlant.crypto.symmetric.NullPad;
  import com.hurlant.crypto.symmetric.OFBMode;
  import com.hurlant.crypto.symmetric.PKCS5;
  import com.hurlant.crypto.symmetric.SimpleIVMode;
  import com.hurlant.crypto.symmetric.TripleDESKey;
  import com.hurlant.crypto.symmetric.XTeaKey;
  import com.hurlant.util.Base64;
  import flash.utils.ByteArray;

  public class Crypto {
    private var b64:Base64;

    public function Crypto() {
      super();
    }

    public static function getCipher(param1:String, param2:ByteArray, param3:IPad = null) : ICipher {
      var local5:ICipher = null;
      var local4:Array = param1.split("-");
      switch(local4[0]) {
        case "simple":
          local4.shift();
          param1 = local4.join("-");
          local5 = getCipher(param1,param2,param3);
          if(local5 is IVMode) {
            return new SimpleIVMode(local5 as IVMode);
          }
          return local5;
          break;
        case "aes":
        case "aes128":
        case "aes192":
        case "aes256":
          local4.shift();
          if(param2.length * 8 == local4[0]) {
            local4.shift();
          }
          return getMode(local4[0],new AESKey(param2),param3);
        case "bf":
        case "blowfish":
          local4.shift();
          return getMode(local4[0],new BlowFishKey(param2),param3);
        case "des":
          local4.shift();
          if(local4[0] != "ede" && local4[0] != "ede3") {
            return getMode(local4[0],new DESKey(param2),param3);
          }
          if(local4.length == 1) {
            local4.push("ecb");
          }
          break;
        case "3des":
        case "des3":
          break;
        case "xtea":
          local4.shift();
          return getMode(local4[0],new XTeaKey(param2),param3);
        case "rc4":
          local4.shift();
          return new ARC4(param2);
        default:
          return null;
      }
      local4.shift();
      return getMode(local4[0],new TripleDESKey(param2),param3);
    }

    public static function getKeySize(param1:String) : uint {
      var local2:Array = param1.split("-");
      switch(local2[0]) {
        case "simple":
          local2.shift();
          return getKeySize(local2.join("-"));
        case "aes128":
          return 16;
        case "aes192":
          return 24;
        case "aes256":
          return 32;
        case "aes":
          local2.shift();
          return parseInt(local2[0]) / 8;
        case "bf":
        case "blowfish":
          return 16;
        case "des":
          local2.shift();
          switch(local2[0]) {
            case "ede":
              return 16;
            case "ede3":
              return 24;
            default:
              return 8;
          }
          break;
        case "3des":
        case "des3":
          return 24;
        case "xtea":
          return 8;
        case "rc4":
          if(parseInt(local2[1]) > 0) {
            return parseInt(local2[1]) / 8;
          }
          return 16;
          break;
        default:
          return 0;
      }
    }

    private static function getMode(param1:String, param2:ISymmetricKey, param3:IPad = null) : IMode {
      switch(param1) {
        case "ecb":
          return new ECBMode(param2,param3);
        case "cfb":
          return new CFBMode(param2,param3);
        case "cfb8":
          return new CFB8Mode(param2,param3);
        case "ofb":
          return new OFBMode(param2,param3);
        case "ctr":
          return new CTRMode(param2,param3);
        case "cbc":
      }
      return new CBCMode(param2,param3);
    }

    public static function getHash(param1:String) : IHash {
      switch(param1) {
        case "md2":
          return new MD2();
        case "md5":
          return new MD5();
        case "sha":
        case "sha1":
          return new SHA1();
        case "sha224":
          return new SHA224();
        case "sha256":
          return new SHA256();
        default:
          return null;
      }
    }

    public static function getHMAC(param1:String) : HMAC {
      var local2:Array = param1.split("-");
      if(local2[0] == "hmac") {
        local2.shift();
      }
      var local3:uint = 0;
      if(local2.length > 1) {
        local3 = parseInt(local2[1]);
      }
      return new HMAC(getHash(local2[0]),local3);
    }

    public static function getMAC(param1:String) : MAC {
      var local2:Array = param1.split("-");
      if(local2[0] == "mac") {
        local2.shift();
      }
      var local3:uint = 0;
      if(local2.length > 1) {
        local3 = parseInt(local2[1]);
      }
      return new MAC(getHash(local2[0]),local3);
    }

    public static function getPad(param1:String) : IPad {
      switch(param1) {
        case "null":
          return new NullPad();
        case "pkcs5":
      }
      return new PKCS5();
    }

    public static function getRSA(param1:String, param2:String) : RSAKey {
      return RSAKey.parsePublicKey(param2,param1);
    }
  }
}
