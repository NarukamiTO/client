package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;

  public class UniversalStringType extends StringType {
    registerClassAlias("com.hurlant.util.asn1.UniversalStringType",UniversalStringType);

    public function UniversalStringType(param1:int = 2147483647, param2:int = 0) {
      super(ASN1Type.UNIVERSAL_STRING,param1,param2);
    }
  }
}
