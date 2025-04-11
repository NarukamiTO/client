package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.ASN1Type;
  import com.hurlant.util.asn1.type.PrintableStringType;

  public function printableString(param1:int = 2147483647, param2:int = 0) : ASN1Type {
    return new PrintableStringType(param1,param2);
  }
}
