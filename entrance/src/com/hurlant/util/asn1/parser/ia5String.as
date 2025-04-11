package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.IA5StringType;

  public function ia5String(param1:int = 2147483647, param2:int = 0) : IA5StringType {
    return new IA5StringType(param1,param2);
  }
}
