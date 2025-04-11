package mx.utils {
  import flash.display.DisplayObject;
  import flash.utils.getQualifiedClassName;
  import mx.core.IRepeaterClient;
  import mx.core.mx_internal;

  use namespace mx_internal;

  public class NameUtil {
    mx_internal static const VERSION:String = "4.6.0.23201";

    private static var counter:int = 0;

    public function NameUtil() {
      super();
    }

    public static function createUniqueName(param1:Object) : String {
      if(!param1) {
        return null;
      }
      var local2:* = getQualifiedClassName(param1);
      var local3:int = int(local2.indexOf("::"));
      if(local3 != -1) {
        local2 = local2.substr(local3 + 2);
      }
      var local4:int = int(local2.charCodeAt(local2.length - 1));
      if(local4 >= 48 && local4 <= 57) {
        local2 += "_";
      }
      return local2 + counter++;
    }

    public static function displayObjectToString(param1:DisplayObject) : String {
      var local2:String = null;
      var local3:DisplayObject = null;
      var local4:String = null;
      var local5:Array = null;
      try {
        local3 = param1;
        while(local3 != null) {
          if(local3.parent && local3.stage && local3.parent == local3.stage) {
            break;
          }
          local4 = "id" in local3 && Boolean(local3["id"]) ? local3["id"] : local3.name;
          if(local3 is IRepeaterClient) {
            local5 = IRepeaterClient(local3).instanceIndices;
            if(local5) {
              local4 += "[" + local5.join("][") + "]";
            }
          }
          local2 = local2 == null ? local4 : local4 + "." + local2;
          local3 = local3.parent;
        }
      }
      catch(e:SecurityError) {
      }
      return local2;
    }

    public static function getUnqualifiedClassName(param1:Object) : String {
      var local2:String = null;
      if(param1 is String) {
        local2 = param1 as String;
      } else {
        local2 = getQualifiedClassName(param1);
      }
      var local3:int = int(local2.indexOf("::"));
      if(local3 != -1) {
        local2 = local2.substr(local3 + 2);
      }
      return local2;
    }
  }
}
