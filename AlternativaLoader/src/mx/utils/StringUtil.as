package mx.utils {
  import mx.core.mx_internal;

  use namespace mx_internal;

  public class StringUtil {
    mx_internal static const VERSION:String = "4.6.0.23201";

    public function StringUtil() {
      super();
    }

    public static function trim(param1:String) : String {
      if(param1 == null) {
        return "";
      }
      var local2:int = 0;
      while(isWhitespace(param1.charAt(local2))) {
        local2++;
      }
      var local3:int = param1.length - 1;
      while(isWhitespace(param1.charAt(local3))) {
        local3--;
      }
      if(local3 >= local2) {
        return param1.slice(local2,local3 + 1);
      }
      return "";
    }

    public static function trimArrayElements(param1:String, param2:String) : String {
      var local3:Array = null;
      var local4:int = 0;
      var local5:int = 0;
      if(param1 != "" && param1 != null) {
        local3 = param1.split(param2);
        local4 = int(local3.length);
        local5 = 0;
        while(local5 < local4) {
          local3[local5] = StringUtil.trim(local3[local5]);
          local5++;
        }
        if(local4 > 0) {
          param1 = local3.join(param2);
        }
      }
      return param1;
    }

    public static function isWhitespace(param1:String) : Boolean {
      switch(param1) {
        case " ":
        case "\t":
        case "\r":
        case "\n":
        case "\f":
          return true;
        default:
          return false;
      }
    }

    public static function substitute(param1:String, ... rest) : String {
      var local4:Array = null;
      if(param1 == null) {
        return "";
      }
      var local3:uint = uint(rest.length);
      if(local3 == 1 && rest[0] is Array) {
        local4 = rest[0] as Array;
        local3 = local4.length;
      } else {
        local4 = rest;
      }
      var local5:int = 0;
      while(local5 < local3) {
        param1 = param1.replace(new RegExp("\\{" + local5 + "\\}","g"),local4[local5]);
        local5++;
      }
      return param1;
    }

    public static function repeat(param1:String, param2:int) : String {
      if(param2 == 0) {
        return "";
      }
      var local3:String = param1;
      var local4:int = 1;
      while(local4 < param2) {
        local3 += param1;
        local4++;
      }
      return local3;
    }

    public static function restrict(param1:String, param2:String) : String {
      var local6:uint = 0;
      if(param2 == null) {
        return param1;
      }
      if(param2 == "") {
        return "";
      }
      var local3:Array = [];
      var local4:int = param1.length;
      var local5:int = 0;
      while(local5 < local4) {
        local6 = uint(param1.charCodeAt(local5));
        if(testCharacter(local6,param2)) {
          local3.push(local6);
        }
        local5++;
      }
      return String.fromCharCode.apply(null,local3);
    }

    private static function testCharacter(param1:uint, param2:String) : Boolean {
      var local9:uint = 0;
      var local11:Boolean = false;
      var local3:Boolean = false;
      var local4:Boolean = false;
      var local5:Boolean = false;
      var local6:* = true;
      var local7:uint = 0;
      var local8:int = param2.length;
      if(local8 > 0) {
        local9 = uint(param2.charCodeAt(0));
        if(local9 == 94) {
          local3 = true;
        }
      }
      var local10:int = 0;
      while(local10 < local8) {
        local9 = uint(param2.charCodeAt(local10));
        local11 = false;
        if(!local4) {
          if(local9 == 45) {
            local5 = true;
          } else if(local9 == 94) {
            local6 = !local6;
          } else if(local9 == 92) {
            local4 = true;
          } else {
            local11 = true;
          }
        } else {
          local11 = true;
          local4 = false;
        }
        if(local11) {
          if(local5) {
            if(local7 <= param1 && param1 <= local9) {
              local3 = local6;
            }
            local5 = false;
            local7 = 0;
          } else {
            if(param1 == local9) {
              local3 = local6;
            }
            local7 = local9;
          }
        }
        local10++;
      }
      return local3;
    }
  }
}
