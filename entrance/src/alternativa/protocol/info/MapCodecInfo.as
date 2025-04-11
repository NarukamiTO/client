package alternativa.protocol.info {
  import alternativa.protocol.ICodecInfo;

  public class MapCodecInfo extends CodecInfo {
    private var _keyCodec:ICodecInfo;
    private var _valueCodec:ICodecInfo;

    public function MapCodecInfo(param1:ICodecInfo, param2:ICodecInfo, param3:Boolean) {
      super(param3);
      this._keyCodec = param1;
      this._valueCodec = param2;
    }

    public function get keyCodec() : ICodecInfo {
      return this._keyCodec;
    }

    public function get valueCodec() : ICodecInfo {
      return this._valueCodec;
    }
  }
}
