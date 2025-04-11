package com.hurlant.util.der {
  import com.hurlant.crypto.rsa.RSAKey;
  import com.hurlant.util.Base64;
  import flash.utils.ByteArray;

  public class PEM {
    private static const RSA_PRIVATE_KEY_HEADER:String = "-----BEGIN RSA PRIVATE KEY-----";
    private static const RSA_PRIVATE_KEY_FOOTER:String = "-----END RSA PRIVATE KEY-----";
    private static const RSA_PUBLIC_KEY_HEADER:String = "-----BEGIN PUBLIC KEY-----";
    private static const RSA_PUBLIC_KEY_FOOTER:String = "-----END PUBLIC KEY-----";
    private static const CERTIFICATE_HEADER:String = "-----BEGIN CERTIFICATE-----";
    private static const CERTIFICATE_FOOTER:String = "-----END CERTIFICATE-----";

    public function PEM() {
      super();
    }

    public static function readRSAPrivateKey(param1:String) : RSAKey {
      var local4:Array = null;
      var local2:ByteArray = extractBinary(RSA_PRIVATE_KEY_HEADER,RSA_PRIVATE_KEY_FOOTER,param1);
      if(local2 == null) {
        return null;
      }
      var local3:* = DER.parse(local2);
      if(local3 is Array) {
        local4 = local3 as Array;
        return new RSAKey(local4[1],local4[2].valueOf(),local4[3],local4[4],local4[5],local4[6],local4[7],local4[8]);
      }
      return null;
    }

    public static function readRSAPublicKey(param1:String) : RSAKey {
      var local4:Array = null;
      var local2:ByteArray = extractBinary(RSA_PUBLIC_KEY_HEADER,RSA_PUBLIC_KEY_FOOTER,param1);
      if(local2 == null) {
        return null;
      }
      var local3:* = DER.parse(local2);
      if(local3 is Array) {
        local4 = local3 as Array;
        if(local4[0][0].toString() != OID.RSA_ENCRYPTION) {
          return null;
        }
        local4[1].position = 0;
        local3 = DER.parse(local4[1]);
        if(local3 is Array) {
          local4 = local3 as Array;
          return new RSAKey(local4[0],local4[1]);
        }
        return null;
      }
      return null;
    }

    public static function readCertIntoArray(param1:String) : ByteArray {
      return extractBinary(CERTIFICATE_HEADER,CERTIFICATE_FOOTER,param1);
    }

    private static function extractBinary(param1:String, param2:String, param3:String) : ByteArray {
      var local4:int = int(param3.indexOf(param1));
      if(local4 == -1) {
        return null;
      }
      local4 += param1.length;
      var local5:int = int(param3.indexOf(param2));
      if(local5 == -1) {
        return null;
      }
      var local6:String = param3.substring(local4,local5);
      local6 = local6.replace(/\s/mg,"");
      return Base64.decodeToByteArray(local6);
    }
  }
}
