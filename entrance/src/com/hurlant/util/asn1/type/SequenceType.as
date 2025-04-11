package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class SequenceType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.SequenceType",SequenceType);

    public var children:Array;
    public var childType:ASN1Type;

    public function SequenceType(param1:* = null) {
      super(ASN1Type.SEQUENCE);
      if(param1 is Array) {
        this.children = param1 as Array;
      } else {
        this.childType = param1 as ASN1Type;
      }
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      var local5:* = undefined;
      var local6:* = undefined;
      var local7:int = 0;
      var local8:String = null;
      var local9:int = 0;
      var local10:ASN1Type = null;
      var local11:ByteArray = null;
      var local3:int = int(param1.position);
      var local4:int = param2;
      if(this.children != null) {
        local5 = {};
        local7 = 0;
        while(local7 < this.children.length) {
          for(local8 in this.children[local7]) {
            local9 = int(param1.position);
            local4 = param2 - local9 + local3;
            local10 = this.children[local7][local8];
            local6 = local10.fromDER(param1,local4);
            if(local6 == null) {
              if(!local10.optional) {
                param1.position = local3;
                return null;
              }
            } else {
              local5[local8] = local6;
              if(local10.extract) {
                local11 = new ByteArray();
                local11.writeBytes(param1,local9,param1.position - local9);
                local5[local8 + "_bin"] = local11;
              }
            }
          }
          local7++;
        }
        return local5;
      }
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
