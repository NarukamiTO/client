package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.ASN1Type;
  import com.hurlant.util.asn1.type.SequenceType;

  public function sequence(... rest) : ASN1Type {
    var local2:Array = [];
    var local3:int = 0;
    while(local3 < rest.length) {
      local2[local3] = rest[local3];
      local3++;
    }
    return new SequenceType(local2);
  }
}
