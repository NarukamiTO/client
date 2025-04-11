package _codec.projects.tanks.client.panel.model.kitoffer {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.kitoffer.KitOfferInfo;

  public class CodecKitOfferInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currencyName:ICodec;
    private var codec_currencyRoundPrecision:ICodec;
    private var codec_image:ICodec;
    private var codec_price:ICodec;
    private var codec_shopItem:ICodec;

    public function CodecKitOfferInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currencyName = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_currencyRoundPrecision = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_image = param1.getCodec(new TypeCodecInfo(LocalizedImageResource,false));
      this.codec_price = param1.getCodec(new TypeCodecInfo(Number,false));
      this.codec_shopItem = param1.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:KitOfferInfo = new KitOfferInfo();
      local2.currencyName = this.codec_currencyName.decode(param1) as String;
      local2.currencyRoundPrecision = this.codec_currencyRoundPrecision.decode(param1) as int;
      local2.image = this.codec_image.decode(param1) as LocalizedImageResource;
      local2.price = this.codec_price.decode(param1) as Number;
      local2.shopItem = this.codec_shopItem.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:KitOfferInfo = KitOfferInfo(param2);
      this.codec_currencyName.encode(param1,local3.currencyName);
      this.codec_currencyRoundPrecision.encode(param1,local3.currencyRoundPrecision);
      this.codec_image.encode(param1,local3.image);
      this.codec_price.encode(param1,local3.price);
      this.codec_shopItem.encode(param1,local3.shopItem);
    }
  }
}
