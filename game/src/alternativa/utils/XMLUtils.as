package alternativa.utils {
  import flash.utils.ByteArray;

  public class XMLUtils {
    private static var buf:ByteArray = new ByteArray();

    public function XMLUtils() {
      super();
    }

    public static function copyXMLString(s:String) : String {
      buf.position = 0;
      buf.writeUTF(s);
      buf.position = 0;
      return buf.readUTF();
    }

    public static function getAttributeAsString(element:XML, attrName:String, defValue:String = null) : String {
      var attribute:XML = null;
      var attributes:XMLList = element.attribute(attrName);
      if(attributes.length() > 0) {
        attribute = attributes[0];
        return attribute.toString();
      }
      return defValue;
    }

    public static function getAttributeAsNumber(element:XML, attrName:String, defValue:Number = NaN) : Number {
      var attributes:XMLList = element.attribute(attrName);
      if(attributes.length() > 0) {
        return Number(attributes[0]);
      }
      return defValue;
    }
  }
}
