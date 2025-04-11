package alternativa.protocol.impl {
  import alternativa.protocol.OptionalMap;
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;

  public class OptionalMapCodecHelper {
    private static const INPLACE_MASK_FLAG:int = 128;
    private static const MASK_LENGTH_2_BYTES_FLAG:int = 64;
    private static const INPLACE_MASK_1_BYTES:int = 32;
    private static const INPLACE_MASK_3_BYTES:int = 96;
    private static const INPLACE_MASK_2_BYTES:int = 64;
    private static const MASK_LENGTH_1_BYTE:int = 128;
    private static const MASK_LEGTH_3_BYTE:int = 12582912;

    public function OptionalMapCodecHelper() {
      super();
    }

    public static function encodeNullMap(param1:OptionalMap, param2:ByteArray) : void {
      var local5:int = 0;
      var local6:int = 0;
      var local7:int = 0;
      var local8:int = 0;
      var local9:int = 0;
      var local3:int = param1.getSize();
      var local4:ByteArray = param1.getMap();
      if(local3 <= 5) {
        param2.writeByte(int((local4[0] & 0xFF) >>> 3));
      } else if(local3 <= 13) {
        param2.writeByte(int(((local4[0] & 0xFF) >>> 3) + INPLACE_MASK_1_BYTES));
        param2.writeByte(((local4[1] & 0xFF) >>> 3) + (local4[0] << 5));
      } else if(local3 <= 21) {
        param2.writeByte(int(((local4[0] & 0xFF) >>> 3) + INPLACE_MASK_2_BYTES));
        param2.writeByte(int(((local4[1] & 0xFF) >>> 3) + (local4[0] << 5)));
        param2.writeByte(int(((local4[2] & 0xFF) >>> 3) + (local4[1] << 5)));
      } else if(local3 <= 29) {
        param2.writeByte(int(((local4[0] & 0xFF) >>> 3) + INPLACE_MASK_3_BYTES));
        param2.writeByte(int(((local4[1] & 0xFF) >>> 3) + (local4[0] << 5)));
        param2.writeByte(int(((local4[2] & 0xFF) >>> 3) + (local4[1] << 5)));
        param2.writeByte(int(((local4[3] & 0xFF) >>> 3) + (local4[2] << 5)));
      } else if(local3 <= 504) {
        local5 = (local3 >>> 3) + ((local3 & 7) == 0 ? 0 : 1);
        local6 = int((local5 & 0xFF) + MASK_LENGTH_1_BYTE);
        param2.writeByte(local6);
        param2.writeBytes(local4,0,local5);
      } else {
        if(local3 > 33554432) {
          throw new Error("NullMap overflow");
        }
        local5 = (local3 >>> 3) + ((local3 & 7) == 0 ? 0 : 1);
        local7 = local5 + MASK_LEGTH_3_BYTE;
        local6 = int((local7 & 0xFF0000) >>> 16);
        local8 = int((local7 & 0xFF00) >>> 8);
        local9 = int(local7 & 0xFF);
        param2.writeByte(local6);
        param2.writeByte(local8);
        param2.writeByte(local9);
        param2.writeBytes(local4,0,local5);
      }
    }

    public static function decodeNullMap(param1:IDataInput, param2:OptionalMap) : void {
      var local4:int = 0;
      var local7:int = 0;
      var local8:Boolean = false;
      var local9:int = 0;
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local3:ByteArray = new ByteArray();
      var local5:int = int(param1.readByte());
      var local6:Boolean = (local5 & INPLACE_MASK_FLAG) != 0;
      if(local6) {
        local7 = local5 & 0x3F;
        local8 = (local5 & MASK_LENGTH_2_BYTES_FLAG) != 0;
        if(local8) {
          local10 = int(param1.readByte());
          local11 = int(param1.readByte());
          local4 = (local7 << 16) + ((local10 & 0xFF) << 8) + (local11 & 0xFF);
        } else {
          local4 = local7;
        }
        param1.readBytes(local3,0,local4);
        local9 = local4 << 3;
        param2.init(local9,local3);
        return;
      }
      local7 = int(local5 << 3);
      local4 = int((local5 & 0x60) >> 5);
      switch(local4) {
        case 0:
          local3.writeByte(local7);
          param2.init(5,local3);
          return;
        case 1:
          local10 = int(param1.readByte());
          local3.writeByte(int(local7 + ((local10 & 0xFF) >>> 5)));
          local3.writeByte(int(local10 << 3));
          param2.init(13,local3);
          return;
        case 2:
          local10 = int(param1.readByte());
          local11 = int(param1.readByte());
          local3.writeByte(int(local7 + ((local10 & 0xFF) >>> 5)));
          local3.writeByte(int((local10 << 3) + ((local11 & 0xFF) >>> 5)));
          local3.writeByte(int(local11 << 3));
          param2.init(21,local3);
          return;
        case 3:
          local10 = int(param1.readByte());
          local11 = int(param1.readByte());
          local12 = int(param1.readByte());
          local3.writeByte(int(local7 + ((local10 & 0xFF) >>> 5)));
          local3.writeByte(int((local10 << 3) + ((local11 & 0xFF) >>> 5)));
          local3.writeByte(int((local11 << 3) + ((local12 & 0xFF) >>> 5)));
          local3.writeByte(int(local12 << 3));
          param2.init(29,local3);
          return;
        default:
          throw new Error("Invalid OptionalMap");
      }
    }
  }
}
