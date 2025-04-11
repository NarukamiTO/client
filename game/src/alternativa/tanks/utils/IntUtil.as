package alternativa.tanks.utils {
  public class IntUtil {
    private static var hexChars:String = "0123456789abcdef";

    public function IntUtil() {
      super();
    }

    public static function rol(param1:int, param2:int) : int {
      return param1 << param2 | param1 >>> 32 - param2;
    }

    public static function ror(param1:int, param2:int) : uint {
      var local3:int = 32 - param2;
      return param1 << local3 | param1 >>> 32 - local3;
    }

    public static function toHex(param1:int, param2:Boolean = false) : String {
      var local4:int = 0;
      var local5:int = 0;
      var local3:String = "";
      if(param2) {
        local4 = 0;
        while(local4 < 4) {
          local3 += hexChars.charAt(param1 >> (3 - local4) * 8 + 4 & 0x0F) + hexChars.charAt(param1 >> (3 - local4) * 8 & 0x0F);
          local4++;
        }
      } else {
        local5 = 0;
        while(local5 < 4) {
          local3 += hexChars.charAt(param1 >> local5 * 8 + 4 & 0x0F) + hexChars.charAt(param1 >> local5 * 8 & 0x0F);
          local5++;
        }
      }
      return local3;
    }
  }
}
