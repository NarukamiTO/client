package com.hurlant.util.asn1.type {
  import com.hurlant.math.BigInteger;
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class IntegerType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.IntegerType",IntegerType);

    public function IntegerType() {
      super(ASN1Type.INTEGER);
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      var local3:int = int(param1.position);
      var local4:int = param2;
      var local5:ByteArray = new ByteArray();
      param1.readBytes(local5,0,param2);
      local5.position = 0;
      var local6:BigInteger = new BigInteger(local5);
      if(local6.bitLength() < 31) {
        return local6.intValue();
      }
      return local6;
    }
  }
}
