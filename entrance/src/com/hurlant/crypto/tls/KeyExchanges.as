package com.hurlant.crypto.tls {
  public class KeyExchanges {
    public static const NULL:uint = 0;
    public static const RSA:uint = 1;
    public static const DH_DSS:uint = 2;
    public static const DH_RSA:uint = 3;
    public static const DHE_DSS:uint = 4;
    public static const DHE_RSA:uint = 5;
    public static const DH_anon:uint = 6;

    public function KeyExchanges() {
      super();
    }

    public static function useRSA(param1:uint) : Boolean {
      return param1 == RSA;
    }
  }
}
