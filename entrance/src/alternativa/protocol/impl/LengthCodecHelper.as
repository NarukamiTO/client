package alternativa.protocol.impl {
  import alternativa.protocol.ProtocolBuffer;

  public class LengthCodecHelper {
    public function LengthCodecHelper() {
      super();
    }

    public static function encodeLength(param1:ProtocolBuffer, param2:int) : void {
      var local3:Number = NaN;
      if(param2 < 0) {
        throw new Error("Length is incorrect (" + param2 + ")");
      }
      if(param2 < 128) {
        param1.writer.writeByte(int(param2 & 0x7F));
      } else if(param2 < 16384) {
        local3 = (param2 & 0x3FFF) + 32768;
        param1.writer.writeByte(int((local3 & 0xFF00) >> 8));
        param1.writer.writeByte(int(local3 & 0xFF));
      } else {
        if(param2 >= 4194304) {
          throw new Error("Length is incorrect (" + param2 + ")");
        }
        local3 = (param2 & 0x3FFFFF) + 12582912;
        param1.writer.writeByte(int((local3 & 0xFF0000) >> 16));
        param1.writer.writeByte(int((local3 & 0xFF00) >> 8));
        param1.writer.writeByte(int(local3 & 0xFF));
      }
    }

    public static function decodeLength(param1:ProtocolBuffer) : int {
      var local4:int = 0;
      var local5:Boolean = false;
      var local6:int = 0;
      var local2:int = int(param1.reader.readByte());
      var local3:Boolean = (local2 & 0x80) == 0;
      if(local3) {
        return local2;
      }
      local4 = int(param1.reader.readByte());
      local5 = (local2 & 0x40) == 0;
      if(local5) {
        return ((local2 & 0x3F) << 8) + (local4 & 0xFF);
      }
      local6 = int(param1.reader.readByte());
      return ((local2 & 0x3F) << 16) + ((local4 & 0xFF) << 8) + (local6 & 0xFF);
    }
  }
}
