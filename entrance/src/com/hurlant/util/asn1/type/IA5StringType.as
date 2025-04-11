package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;

  public class IA5StringType extends StringType {
    registerClassAlias("com.hurlant.util.asn1.IA5StringType",IA5StringType);

    public function IA5StringType(param1:int = 2147483647, param2:int = 0) {
      super(ASN1Type.IA5_STRING,param1,param2);
    }
  }
}
