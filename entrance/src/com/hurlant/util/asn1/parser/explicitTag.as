package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.ASN1Type;

  public function explicitTag(param1:int, param2:int, param3:ASN1Type) : ASN1Type {
    param3 = param3.clone();
    param3.explicitTag = param1;
    param3.explicitClass = param2;
    return param3;
  }
}
