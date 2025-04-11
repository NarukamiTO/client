package alternativa.protocol.info {
  import alternativa.protocol.ICodecInfo;

  public class CodecInfo implements ICodecInfo {
    private var optional:Boolean;

    public function CodecInfo(param1:Boolean) {
      super();
      this.optional = param1;
    }

    public function isOptional() : Boolean {
      return this.optional;
    }

    public function toString() : String {
      return "[CodecInfo optional = " + this.optional + "]";
    }
  }
}
