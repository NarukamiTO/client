package alternativa.startup {
  import flash.utils.ByteArray;
  import mx.utils.Base64Encoder;

  public class URLEncoder {
    public function URLEncoder() {
      super();
    }

    public static function encode(param1:String) : String {
      var local2:Base64Encoder = new Base64Encoder();
      local2.insertNewLines = false;
      var local3:ByteArray = new ByteArray();
      local3.writeUTFBytes(param1);
      local2.encodeUTFBytes(local3.toString());
      return local2.toString();
    }
  }
}
