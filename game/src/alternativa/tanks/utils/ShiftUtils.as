package alternativa.tanks.utils {
  public class ShiftUtils {
    public function ShiftUtils() {
      super();
    }

    public static function rotateRight(param1:int, param2:int) : int {
      var local3:int = param1 << 32 - param2;
      return (param1 >>> param2) + local3;
    }

    public static function rotateLeft(param1:int, param2:int) : int {
      var local3:int = param1 >>> 32 - param2;
      return (param1 << param2) + local3;
    }
  }
}
