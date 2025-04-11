package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.UniversalStringType;

  public function universalString(param1:int = 2147483647, param2:int = 0) : UniversalStringType {
    return new UniversalStringType(param1,param2);
  }
}
