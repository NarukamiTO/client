package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class ChoiceType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.ChoiceType",ChoiceType);

    public var choices:Array;

    public function ChoiceType(param1:Array = null) {
      super(ASN1Type.CHOICE);
      this.choices = param1;
    }

    override public function fromDER(param1:ByteArray, param2:int) : * {
      var local4:* = undefined;
      var local5:String = null;
      var local6:ASN1Type = null;
      var local7:* = undefined;
      var local8:* = undefined;
      var local3:int = 0;
      while(local3 < this.choices.length) {
        local4 = this.choices[local3];
        for(local5 in local4) {
          local6 = local4[local5];
          local7 = local6.fromDER(param1,param2);
          if(local7 != null) {
            local8 = {};
            local8[local5] = local7;
            return local8;
          }
        }
        local3++;
      }
      return null;
    }
  }
}
