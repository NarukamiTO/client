package mx.core {
  use namespace mx_internal;

  public class Singleton {
    mx_internal static const VERSION:String = "4.6.0.23201";

    private static var classMap:Object = {};

    public function Singleton() {
      super();
    }

    public static function registerClass(param1:String, param2:Class) : void {
      var local3:Class = classMap[param1];
      if(!local3) {
        classMap[param1] = param2;
      }
    }

    public static function getClass(param1:String) : Class {
      return classMap[param1];
    }

    public static function getInstance(param1:String) : Object {
      var local2:Class = classMap[param1];
      if(!local2) {
        throw new Error("No class registered for interface \'" + param1 + "\'.");
      }
      return local2["getInstance"]();
    }
  }
}
