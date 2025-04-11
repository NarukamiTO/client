package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class NullType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.type.NullType",NullType);

    public function NullType() {
      super(ASN1Type.NULL);
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      return "NULL";
    }
  }
}
