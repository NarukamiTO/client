package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class OctetStringType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.parser.OctetStringType",OctetStringType);

    public function OctetStringType() {
      super(ASN1Type.OCTET_STRING);
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      var local3:ByteArray = new ByteArray();
      param1.readBytes(local3,0,param2);
      return local3;
    }
  }
}
