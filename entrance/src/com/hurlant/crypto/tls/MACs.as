package com.hurlant.crypto.tls {
  import com.hurlant.crypto.Crypto;
  import com.hurlant.crypto.hash.HMAC;
  import com.hurlant.crypto.hash.MAC;

  public class MACs {
    public static const NULL:uint = 0;
    public static const MD5:uint = 1;
    public static const SHA1:uint = 2;

    public function MACs() {
      super();
    }

    public static function getHashSize(param1:uint) : uint {
      return [0,16,20][param1];
    }

    public static function getPadSize(param1:uint) : int {
      return [0,48,40][param1];
    }

    public static function getHMAC(param1:uint) : HMAC {
      if(param1 == NULL) {
        return null;
      }
      return Crypto.getHMAC(["","md5","sha1"][param1]);
    }

    public static function getMAC(param1:uint) : MAC {
      return Crypto.getMAC(["","md5","sha1"][param1]);
    }
  }
}
