package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.ASN1Type;

  public function optional(param1:ASN1Type) : ASN1Type {
    param1 = param1.clone();
    param1.optional = true;
    return param1;
  }
}
