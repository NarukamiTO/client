package com.hurlant.util.asn1.type {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class OIDType extends ASN1Type {
    registerClassAlias("com.hurlant.util.asn1.OIDType",OIDType);

    public var oid:String = null;

    public function OIDType(param1:String = null) {
      super(ASN1Type.OID);
      this.oid = param1;
    }

    public function toString() : String {
      return this.oid;
    }

    override protected function fromDERContent(param1:ByteArray, param2:int) : * {
      var local9:Boolean = false;
      var local3:int = int(param1.position);
      var local4:uint = param1.readUnsignedByte();
      var local5:int = param2 - 1;
      var local6:Array = [];
      local6.push(uint(local4 / 40));
      local6.push(uint(local4 % 40));
      var local7:uint = 0;
      while(local5-- > 0) {
        local4 = param1.readUnsignedByte();
        local9 = (local4 & 0x80) == 0;
        local4 &= 127;
        local7 = local7 * 128 + local4;
        if(local9) {
          local6.push(local7);
          local7 = 0;
        }
      }
      var local8:String = local6.join(".");
      if(this.oid != null) {
        if(this.oid == local8) {
          return this.clone();
        }
        param1.position = local3;
        return null;
      }
      return new OIDType(local8);
    }
  }
}
