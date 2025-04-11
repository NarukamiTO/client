package com.hurlant.util.der {
  import flash.utils.ByteArray;

  public dynamic class Sequence extends Array implements IAsn1Type {
    protected var type:uint;
    protected var len:uint;

    public function Sequence(param1:uint = 48, param2:uint = 0) {
      super();
      this.type = param1;
      this.len = param2;
    }

    public function getLength() : uint {
      return this.len;
    }

    public function getType() : uint {
      return this.type;
    }

    public function toDER() : ByteArray {
      var local3:IAsn1Type = null;
      var local1:ByteArray = new ByteArray();
      var local2:int = 0;
      while(local2 < length) {
        local3 = this[local2];
        if(local3 == null) {
          local1.writeByte(5);
          local1.writeByte(0);
        } else {
          local1.writeBytes(local3.toDER());
        }
        local2++;
      }
      return DER.wrapDER(this.type,local1);
    }

    public function toString() : String {
      var local4:Boolean = false;
      var local5:String = null;
      var local1:String = DER.indent;
      DER.indent += "    ";
      var local2:String = "";
      var local3:int = 0;
      while(local3 < length) {
        if(this[local3] != null) {
          local4 = false;
          for(local5 in this) {
            if(local3.toString() != local5 && this[local3] == this[local5]) {
              local2 += local5 + ": " + this[local3] + "\n";
              local4 = true;
              break;
            }
          }
          if(!local4) {
            local2 += this[local3] + "\n";
          }
        }
        local3++;
      }
      DER.indent = local1;
      return DER.indent + "Sequence[" + this.type + "][" + this.len + "][\n" + local2 + "\n" + local1 + "]";
    }

    public function findAttributeValue(param1:String) : IAsn1Type {
      var local2:* = undefined;
      var local3:* = undefined;
      var local4:* = undefined;
      var local5:ObjectIdentifier = null;
      for each(local2 in this) {
        if(local2 is Set) {
          local3 = local2[0];
          if(local3 is Sequence) {
            local4 = local3[0];
            if(local4 is ObjectIdentifier) {
              local5 = local4 as ObjectIdentifier;
              if(local5.toString() == param1) {
                return local3[1] as IAsn1Type;
              }
            }
          }
        }
      }
      return null;
    }
  }
}
