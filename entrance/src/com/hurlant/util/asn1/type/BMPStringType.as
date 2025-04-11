package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;

  public class BMPStringType extends StringType {
    registerClassAlias("com.hurlant.util.asn1.BMPStringType",BMPStringType);

    public function BMPStringType(param1:int = 2147483647, param2:int = 0) {
      super(ASN1Type.BMP_STRING,param1,param2);
    }
  }
}
