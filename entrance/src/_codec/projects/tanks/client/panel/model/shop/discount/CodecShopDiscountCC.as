package _codec.projects.tanks.client.panel.model.shop.discount {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.discount.ShopDiscountCC;

  public class CodecShopDiscountCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_discountInPercent:ICodec;
    private var codec_enabled:ICodec;

    public function CodecShopDiscountCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_discountInPercent = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopDiscountCC = new ShopDiscountCC();
      local2.discountInPercent = this.codec_discountInPercent.decode(param1) as int;
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopDiscountCC = ShopDiscountCC(param2);
      this.codec_discountInPercent.encode(param1,local3.discountInPercent);
      this.codec_enabled.encode(param1,local3.enabled);
    }
  }
}
