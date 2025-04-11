package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.ASN1Type;

  public function implicitTag(param1:int, param2:int, param3:ASN1Type) : ASN1Type {
    param3 = param3.clone();
    param3.implicitTag = param1;
    param3.implicitClass = param2;
    return param3;
  }
}
