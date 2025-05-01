package mx.utils {
  import flash.display.DisplayObject;
  import flash.utils.getQualifiedClassName;
  import mx.core.IRepeaterClient;
  import mx.core.mx_internal;

  use namespace mx_internal;

  public class NameUtil {
    mx_internal static const VERSION:String = "4.5.0.19786";

    private static var counter:int = 0;

    public function NameUtil() {
      super();
    }

    public static function createUniqueName(object:Object) : String {
      if(!object) {
        return null;
      }
      var name:String = getQualifiedClassName(object);
      var index:int = int(name.indexOf("::"));
      if(index != -1) {
        name = name.substr(index + 2);
      }
      var charCode:int = int(name.charCodeAt(name.length - 1));
      if(charCode >= 48 && charCode <= 57) {
        name += "_";
      }
      return name + counter++;
    }

    public static function displayObjectToString(displayObject:DisplayObject) : String {
      var result:String = null;
      var o:DisplayObject = null;
      var s:String = null;
      var indices:Array = null;
      try {
        o = displayObject;
        while(o != null) {
          if(o.parent && o.stage && o.parent == o.stage) {
            break;
          }
          s = "id" in o && Boolean(o["id"]) ? o["id"] : o.name;
          if(o is IRepeaterClient) {
            indices = IRepeaterClient(o).instanceIndices;
            if(Boolean(indices)) {
              s += "[" + indices.join("][") + "]";
            }
          }
          result = result == null ? s : s + "." + result;
          o = o.parent;
        }
      }
      catch(e:SecurityError) {
      }
      return result;
    }

    public static function getUnqualifiedClassName(object:Object) : String {
      var name:String = null;
      if(object is String) {
        name = object as String;
      } else {
        name = getQualifiedClassName(object);
      }
      var index:int = int(name.indexOf("::"));
      if(index != -1) {
        name = name.substr(index + 2);
      }
      return name;
    }
  }
}
