package alternativa.protocol.impl {
  import alternativa.protocol.CompressionType;
  import alternativa.protocol.ProtocolBuffer;
  import flash.utils.ByteArray;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;

  public class PacketHelper {
    private static const ZIP_PACKET_SIZE_DELIMITER:int = 2000;
    private static const LONG_SIZE_DELIMITER:int = 16384;
    private static const ZIPPED_FLAG:int = 64;
    private static const BIG_LENGTH_FLAG:int = 128;
    private static const HELPER:ByteArray = new ByteArray();

    public function PacketHelper() {
      super();
    }

    public static function unwrapPacket(param1:IDataInput, param2:ProtocolBuffer, param3:CompressionType) : Boolean {
      var local4:Boolean = false;
      var local5:int = 0;
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local13:int = 0;
      if(param1.bytesAvailable < 2) {
        return false;
      }
      var local6:int = param1.readByte();
      var local7:Boolean = (local6 & BIG_LENGTH_FLAG) != 0;
      if(local7) {
        if(param1.bytesAvailable < 3) {
          return false;
        }
        local4 = param3 != CompressionType.NONE;
        local10 = (local6 ^ BIG_LENGTH_FLAG) << 24;
        local11 = (param1.readByte() & 0xFF) << 16;
        local12 = (param1.readByte() & 0xFF) << 8;
        local13 = param1.readByte() & 0xFF;
        local5 = local10 + local11 + local12 + local13;
      } else {
        local4 = (local6 & ZIPPED_FLAG) != 0;
        local10 = (local6 & 0x3F) << 8;
        local12 = param1.readByte() & 0xFF;
        local5 = local10 + local12;
      }
      if(param1.bytesAvailable < local5) {
        return false;
      }
      var local8:ByteArray = new ByteArray();
      if(local5 != 0) {
        param1.readBytes(local8,0,local5);
      }
      if(local4) {
        local8.uncompress();
      }
      local8.position = 0;
      var local9:ByteArray = ByteArray(param2.reader);
      OptionalMapCodecHelper.decodeNullMap(local8,param2.optionalMap);
      local9.writeBytes(local8,local8.position,local8.length - local8.position);
      local9.position = 0;
      return true;
    }

    public static function wrapPacket(param1:IDataOutput, param2:ProtocolBuffer, param3:CompressionType) : void {
      var local7:int = 0;
      var local8:int = 0;
      var local9:int = 0;
      var local4:Boolean = false;
      switch(param3) {
        case CompressionType.NONE:
          break;
        case CompressionType.DEFLATE:
          local4 = true;
          break;
        case CompressionType.DEFLATE_AUTO:
          local4 = determineZipped(param2.reader);
      }
      HELPER.position = 0;
      HELPER.length = 0;
      OptionalMapCodecHelper.encodeNullMap(param2.optionalMap,HELPER);
      param2.reader.readBytes(HELPER,HELPER.position,param2.reader.bytesAvailable);
      HELPER.position = 0;
      var local5:Boolean = isLongSize(HELPER);
      if(local4) {
        HELPER.compress();
      }
      var local6:int = int(HELPER.length);
      if(local5) {
        local7 = local6 + (BIG_LENGTH_FLAG << 24);
        param1.writeInt(local7);
      } else {
        local8 = int(((local6 & 0xFF00) >> 8) + (local4 ? ZIPPED_FLAG : 0));
        local9 = int(local6 & 0xFF);
        param1.writeByte(local8);
        param1.writeByte(local9);
      }
      param1.writeBytes(HELPER,0,local6);
    }

    private static function isLongSize(param1:IDataInput) : Boolean {
      return param1.bytesAvailable >= LONG_SIZE_DELIMITER || param1.bytesAvailable == -1;
    }

    private static function determineZipped(param1:IDataInput) : Boolean {
      return param1.bytesAvailable == -1 || param1.bytesAvailable > ZIP_PACKET_SIZE_DELIMITER;
    }

    private static function bytesToString(param1:ByteArray, param2:int, param3:int, param4:int) : String {
      var local7:int = 0;
      var local8:int = 0;
      var local9:int = 0;
      var local10:String = null;
      var local5:String = "";
      var local6:int = int(param1.position);
      param1.position = param2;
      while(param1.bytesAvailable > 0 && local9 < param3) {
        local9++;
        local10 = param1.readUnsignedByte().toString(16);
        if(local10.length == 1) {
          local10 = "0" + local10;
        }
        local5 += local10;
        local8++;
        if(local8 == 4) {
          local8 = 0;
          local7++;
          if(local7 == param4) {
            local7 = 0;
            local5 += "\n";
          } else {
            local5 += "  ";
          }
        } else {
          local5 += " ";
        }
      }
      if(local9 < param3) {
        local5 += "\nOnly " + local9 + " of " + param3 + " bytes have been read";
      }
      param1.position = local6;
      return local5;
    }
  }
}
