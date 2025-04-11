package com.hurlant.util.asn1.parser {
  import com.hurlant.util.asn1.type.BMPStringType;

  public function bmpString(param1:int = 2147483647, param2:int = 0) : BMPStringType {
    return new BMPStringType(param1,param2);
  }
}
