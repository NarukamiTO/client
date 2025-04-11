package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;

  public class PrintableStringType extends StringType {
    registerClassAlias("com.hurlant.util.asn1.PrintableStringType",PrintableStringType);

    public function PrintableStringType(param1:int = 2147483647, param2:int = 0) {
      super(ASN1Type.PRINTABLE_STRING,param1,param2);
    }
  }
}
