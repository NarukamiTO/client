package alternativa.protocol.impl {
  import flash.utils.ByteArray;

  public class DebugHelper {
    public function DebugHelper() {
      super();
    }

    public static function bytesToString(param1:ByteArray, param2:int, param3:int, param4:int) : String {
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
