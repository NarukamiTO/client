package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class StringType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.StringType",StringType);

    public var size1:int;
    public var size2:int;

    public function StringType(param1:int, param2:int = 2147483647, param3:int = 0) {
      super(param1);
      this.size1 = param2;
      this.size2 = param3;
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      return param1.readMultiByte(param2,"US-ASCII");
    }
  }
}
