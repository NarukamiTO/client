package alternativa.protocol.info {
  import alternativa.protocol.ICodecInfo;

  public class CollectionCodecInfo extends CodecInfo {
    private var _elementCodec:ICodecInfo;
    private var _level:int;

    public function CollectionCodecInfo(param1:ICodecInfo, param2:Boolean, param3:int) {
      super(param2);
      this._elementCodec = param1;
      this._level = param3;
    }

    public function get level() : int {
      return this._level;
    }

    public function get elementCodec() : ICodecInfo {
      return this._elementCodec;
    }

    override public function toString() : String {
      return "[CollectionCodecInfo " + super.toString() + " element=" + this.elementCodec.toString() + " level=" + this.level + "]";
    }
  }
}
