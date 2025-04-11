package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class UTCTimeType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.UTCTime",UTCTimeType);

    public function UTCTimeType() {
      super(ASN1Type.UTC_TIME);
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      var local3:String = param1.readMultiByte(param2,"US-ASCII");
      var local4:uint = parseInt(local3.substr(0,2));
      if(local4 < 50) {
        local4 += 2000;
      } else {
        local4 += 1900;
      }
      var local5:uint = parseInt(local3.substr(2,2));
      var local6:uint = parseInt(local3.substr(4,2));
      var local7:uint = parseInt(local3.substr(6,2));
      var local8:uint = parseInt(local3.substr(8,2));
      return new Date(local4,local5 - 1,local6,local7,local8);
    }
  }
}
