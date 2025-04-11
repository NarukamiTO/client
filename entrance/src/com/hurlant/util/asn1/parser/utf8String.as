package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.UTF8StringType;

  public function utf8String(param1:int = 2147483647, param2:int = 0) : UTF8StringType {
    return new UTF8StringType(param1,param2);
  }
}
