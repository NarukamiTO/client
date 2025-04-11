package _codec.projects.tanks.client.panel.model.shop.price {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.price.ShopItemCC;

  public class CodecShopItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currencyName:ICodec;
    private var codec_preview:ICodec;
    private var codec_price:ICodec;
    private var codec_roundingPrecision:ICodec;

    public function CodecShopItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currencyName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_price = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_roundingPrecision = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopItemCC = new ShopItemCC();
      local2.currencyName = this.codec_currencyName.decode(param1) as String;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      local2.price = this.codec_price.decode(param1) as Number;
      local2.roundingPrecision = this.codec_roundingPrecision.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopItemCC = ShopItemCC(param2);
      this.codec_currencyName.encode(param1,local3.currencyName);
      this.codec_preview.encode(param1,local3.preview);
      this.codec_price.encode(param1,local3.price);
      this.codec_roundingPrecision.encode(param1,local3.roundingPrecision);
    }
  }
}
