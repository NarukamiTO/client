package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class AnyType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.AnyType",AnyType);

    public function AnyType() {
      super(ASN1Type.ANY);
      throw new Error("the ASN-1 ANY type is NOT IMPLEMENTED");
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      switch(parsedTag) {
        case NULL:
          return "NULL";
        default:
          return null;
      }
    }
  }
}
