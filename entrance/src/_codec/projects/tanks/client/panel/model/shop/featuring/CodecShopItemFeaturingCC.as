package _codec.projects.tanks.client.panel.model.shop.featuring {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.featuring.ShopItemFeaturingCC;

  public class CodecShopItemFeaturingCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_hiddenInOriginalCategory:ICodec;
    private var codec_locatedInFeaturingCategory:ICodec;
    private var codec_position:ICodec;

    public function CodecShopItemFeaturingCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_hiddenInOriginalCategory = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_locatedInFeaturingCategory = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopItemFeaturingCC = new ShopItemFeaturingCC();
      local2.hiddenInOriginalCategory = this.codec_hiddenInOriginalCategory.decode(param1) as Boolean;
      local2.locatedInFeaturingCategory = this.codec_locatedInFeaturingCategory.decode(param1) as Boolean;
      local2.position = this.codec_position.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopItemFeaturingCC = ShopItemFeaturingCC(param2);
      this.codec_hiddenInOriginalCategory.encode(param1,local3.hiddenInOriginalCategory);
      this.codec_locatedInFeaturingCategory.encode(param1,local3.locatedInFeaturingCategory);
      this.codec_position.encode(param1,local3.position);
    }
  }
}
