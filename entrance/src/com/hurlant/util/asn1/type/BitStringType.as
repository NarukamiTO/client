package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class BitStringType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.BitStringType",BitStringType);

    public function BitStringType() {
      super(ASN1Type.BIT_STRING);
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      param1.readUnsignedByte();
      var local3:ByteArray = new ByteArray();
      param1.readBytes(local3,0,param2 - 1);
      return local3;
    }
  }
}
