package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class SetType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.SetType",SetType);

    public var childType:ASN1Type;

    public function SetType(param1:ASN1Type = null) {
      super(ASN1Type.SET);
      this.childType = param1;
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      var local5:Array = null;
      var local6:* = undefined;
      var local3:int = int(param1.position);
      var local4:int = param2;
      local5 = [];
      while(local4 > 0) {
        local6 = this.childType.fromDER(param1,local4);
        if(local6 == null) {
          throw new Error("couldn\'t parse DER stream.");
        }
        local5.push(local6);
        local4 = param2 - param1.position + local3;
      }
      return local5;
    }
  }
}
