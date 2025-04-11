package com.hurlant.util.der {
  import flash.net.registerClassAlias;
  import flash.utils.ByteArray;

  public class ObjectIdentifier implements IAsn1Type {
    registerClassAlias("com.hurlant.util.der.ObjectIdentifier",ObjectIdentifier);

    private var type:uint;
    private var len:uint;
    private var oid:Array;

    public function ObjectIdentifier(param1:uint = 0, param2:uint = 0, param3:* = null) {
      super();
      this.type = param1;
      this.len = param2;
      if(param3 is ByteArray) {
        this.parse(param3 as ByteArray);
      } else {
        if(!(param3 is String)) {
          throw new Error("Invalid call to new ObjectIdentifier");
        }
        this.generate(param3 as String);
      }
    }

    private function generate(param1:String) : void {
      this.oid = param1.split(".");
    }

    private function parse(param1:ByteArray) : void {
      var local5:Boolean = false;
      var local2:uint = param1.readUnsignedByte();
      var local3:Array = [];
      local3.push(uint(local2 / 40));
      local3.push(uint(local2 % 40));
      var local4:uint = 0;
      while(param1.bytesAvailable > 0) {
        local2 = param1.readUnsignedByte();
        local5 = (local2 & 0x80) == 0;
        local2 &= 127;
        local4 = local4 * 128 + local2;
        if(local5) {
          local3.push(local4);
          local4 = 0;
        }
      }
      this.oid = local3;
    }

    public function getLength() : uint {
      return this.len;
    }

    public function getType() : uint {
      return this.type;
    }

    public function toDER() : ByteArray {
      var local4:int = 0;
      var local1:Array = [];
      local1[0] = this.oid[0] * 40 + this.oid[1];
      var local2:int = 2;
      while(local2 < this.oid.length) {
        local4 = parseInt(this.oid[local2]);
        if(local4 < 128) {
          local1.push(local4);
        } else if(local4 < 128 * 128) {
          local1.push(local4 >> 7 | 0x80);
          local1.push(local4 & 0x7F);
        } else if(local4 < 128 * 128 * 128) {
          local1.push(local4 >> 14 | 0x80);
          local1.push(local4 >> 7 & 0x7F | 0x80);
          local1.push(local4 & 0x7F);
        } else {
          if(local4 >= 128 * 128 * 128 * 128) {
            throw new Error("OID element bigger than we thought. :(");
          }
          local1.push(local4 >> 21 | 0x80);
          local1.push(local4 >> 14 & 0x7F | 0x80);
          local1.push(local4 >> 7 & 0x7F | 0x80);
          local1.push(local4 & 0x7F);
        }
        local2++;
      }
      this.len = local1.length;
      if(this.type == 0) {
        this.type = 6;
      }
      local1.unshift(this.len);
      local1.unshift(this.type);
      var local3:ByteArray = new ByteArray();
      local2 = 0;
      while(local2 < local1.length) {
        local3[local2] = local1[local2];
        local2++;
      }
      return local3;
    }

    public function toString() : String {
      return DER.indent + this.oid.join(".");
    }

    public function dump() : String {
      return "OID[" + this.type + "][" + this.len + "][" + this.toString() + "]";
    }
  }
}
