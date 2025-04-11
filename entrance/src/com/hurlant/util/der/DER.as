package com.hurlant.util.der {
  import flash.utils.ByteArray;

  public class DER {
    public static var indent:String = "";

    public function DER() {
      super();
    }

    public static function parse(param1:ByteArray, param2:* = null) : IAsn1Type {
      var local3:int = 0;
      var local5:int = 0;
      var local6:ByteArray = null;
      var local7:int = 0;
      var local8:int = 0;
      var local9:Sequence = null;
      var local10:Array = null;
      var local11:Set = null;
      var local12:ByteString = null;
      var local13:PrintableString = null;
      var local14:UTCTime = null;
      var local15:Object = null;
      var local16:Boolean = false;
      var local17:Boolean = false;
      var local18:String = null;
      var local19:* = undefined;
      var local20:IAsn1Type = null;
      var local21:int = 0;
      var local22:ByteArray = null;
      local3 = int(param1.readUnsignedByte());
      var local4:Boolean = (local3 & 0x20) != 0;
      local3 &= 31;
      local5 = int(param1.readUnsignedByte());
      if(local5 >= 128) {
        local7 = local5 & 0x7F;
        local5 = 0;
        while(local7 > 0) {
          local5 = local5 << 8 | param1.readUnsignedByte();
          local7--;
        }
      }
      switch(local3) {
        case 0:
        case 16:
          local8 = int(param1.position);
          local9 = new Sequence(local3,local5);
          local10 = param2 as Array;
          if(local10 != null) {
            local10 = local10.concat();
          }
          while(param1.position < local8 + local5) {
            local15 = null;
            if(local10 != null) {
              local15 = local10.shift();
            }
            if(local15 != null) {
              while(Boolean(local15) && Boolean(local15.optional)) {
                local16 = local15.value is Array;
                local17 = isConstructedType(param1);
                if(local16 == local17) {
                  break;
                }
                local9.push(local15.defaultValue);
                local9[local15.name] = local15.defaultValue;
                local15 = local10.shift();
              }
            }
            if(local15 != null) {
              local18 = local15.name;
              local19 = local15.value;
              if(Boolean(local15.extract)) {
                local21 = getLengthOfNextElement(param1);
                local22 = new ByteArray();
                local22.writeBytes(param1,param1.position,local21);
                local9[local18 + "_bin"] = local22;
              }
              local20 = DER.parse(param1,local19);
              local9.push(local20);
              local9[local18] = local20;
            } else {
              local9.push(DER.parse(param1));
            }
          }
          return local9;
        case 17:
          local8 = int(param1.position);
          local11 = new Set(local3,local5);
          while(param1.position < local8 + local5) {
            local11.push(DER.parse(param1));
          }
          return local11;
        case 2:
          local6 = new ByteArray();
          param1.readBytes(local6,0,local5);
          local6.position = 0;
          return new Integer(local3,local5,local6);
        case 6:
          local6 = new ByteArray();
          param1.readBytes(local6,0,local5);
          local6.position = 0;
          return new ObjectIdentifier(local3,local5,local6);
        case 3:
        default:
          if(param1[param1.position] == 0) {
            ++param1.position;
            local5--;
          }
          break;
        case 4:
          break;
        case 5:
          return null;
        case 19:
          local13 = new PrintableString(local3,local5);
          local13.setString(param1.readMultiByte(local5,"US-ASCII"));
          return local13;
        case 34:
        case 20:
          local13 = new PrintableString(local3,local5);
          local13.setString(param1.readMultiByte(local5,"latin1"));
          return local13;
        case 23:
          local14 = new UTCTime(local3,local5);
          local14.setUTCTime(param1.readMultiByte(local5,"US-ASCII"));
          return local14;
      }
      local12 = new ByteString(local3,local5);
      param1.readBytes(local12,0,local5);
      return local12;
    }

    private static function getLengthOfNextElement(param1:ByteArray) : int {
      var local4:int = 0;
      var local2:uint = param1.position;
      ++param1.position;
      var local3:int = int(param1.readUnsignedByte());
      if(local3 >= 128) {
        local4 = local3 & 0x7F;
        local3 = 0;
        while(local4 > 0) {
          local3 = local3 << 8 | param1.readUnsignedByte();
          local4--;
        }
      }
      local3 += param1.position - local2;
      param1.position = local2;
      return local3;
    }

    private static function isConstructedType(param1:ByteArray) : Boolean {
      var local2:int = int(param1[param1.position]);
      return (local2 & 0x20) != 0;
    }

    public static function wrapDER(param1:int, param2:ByteArray) : ByteArray {
      var local3:ByteArray = new ByteArray();
      local3.writeByte(param1);
      var local4:int = int(param2.length);
      if(local4 < 128) {
        local3.writeByte(local4);
      } else if(local4 < 256) {
        local3.writeByte(1 | 0x80);
        local3.writeByte(local4);
      } else if(local4 < 65536) {
        local3.writeByte(2 | 0x80);
        local3.writeByte(local4 >> 8);
        local3.writeByte(local4);
      } else if(local4 < 65536 * 256) {
        local3.writeByte(3 | 0x80);
        local3.writeByte(local4 >> 16);
        local3.writeByte(local4 >> 8);
        local3.writeByte(local4);
      } else {
        local3.writeByte(4 | 0x80);
        local3.writeByte(local4 >> 24);
        local3.writeByte(local4 >> 16);
        local3.writeByte(local4 >> 8);
        local3.writeByte(local4);
      }
      local3.writeBytes(param2);
      local3.position = 0;
      return local3;
    }
  }
}
