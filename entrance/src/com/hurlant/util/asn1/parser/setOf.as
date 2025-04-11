package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.ASN1Type;
  import com.hurlant.util.asn1.type.SetType;

  public function setOf(param1:ASN1Type, param2:uint = 0, param3:uint = 4294967295) : ASN1Type {
    return new SetType(param1);
  }
}
