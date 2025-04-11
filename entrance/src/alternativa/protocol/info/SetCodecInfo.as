package alternativa.protocol.info {
  import alternativa.protocol.ICodecInfo;

  public class SetCodecInfo extends CodecInfo {
    private var _elementCodec:ICodecInfo;

    public function SetCodecInfo(param1:ICodecInfo, param2:Boolean) {
      super(param2);
      this._elementCodec = param1;
    }

    public function get elementCodec() : ICodecInfo {
      return this._elementCodec;
    }

    override public function toString() : String {
      return "[SetCodecInfo " + super.toString() + " element=" + this.elementCodec.toString() + "]";
    }
  }
}
