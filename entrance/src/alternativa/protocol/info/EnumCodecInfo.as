package alternativa.protocol.info {
  public class EnumCodecInfo extends TypeCodecInfo {
    public function EnumCodecInfo(param1:Class, param2:Boolean) {
      super(param1,param2);
    }

    override public function toString() : String {
      return "[EnumCodec " + super.toString() + " type=" + type.toString();
    }
  }
}
