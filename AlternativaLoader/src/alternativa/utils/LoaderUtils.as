package alternativa.utils {
  import flash.utils.ByteArray;

  public class LoaderUtils {
    private static const SEPARATOR:String = "/";

    public function LoaderUtils() {
      super();
    }

    public static function getResourcePath(param1:ByteArray, param2:ByteArray) : String {
      var local3:uint = 0;
      var local4:uint = 0;
      local3 = param2.readUnsignedInt();
      local4 = param2.readUnsignedInt();
      var local5:String = new Long(local3,local4).toOct();
      return SEPARATOR + param1.readUnsignedInt().toString(8) + SEPARATOR + param1.readUnsignedShort().toString(8) + SEPARATOR + param1.readUnsignedByte().toString(8) + SEPARATOR + param1.readUnsignedByte().toString(8) + SEPARATOR + local5 + SEPARATOR;
    }
  }
}
