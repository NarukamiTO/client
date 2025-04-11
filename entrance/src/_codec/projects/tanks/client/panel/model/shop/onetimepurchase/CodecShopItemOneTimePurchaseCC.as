package _codec.projects.tanks.client.panel.model.shop.onetimepurchase {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.onetimepurchase.ShopItemOneTimePurchaseCC;

  public class CodecShopItemOneTimePurchaseCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_oneTimePurchase:ICodec;
    private var codec_triedToBuy:ICodec;

    public function CodecShopItemOneTimePurchaseCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_oneTimePurchase = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_triedToBuy = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopItemOneTimePurchaseCC = new ShopItemOneTimePurchaseCC();
      local2.oneTimePurchase = this.codec_oneTimePurchase.decode(param1) as Boolean;
      local2.triedToBuy = this.codec_triedToBuy.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopItemOneTimePurchaseCC = ShopItemOneTimePurchaseCC(param2);
      this.codec_oneTimePurchase.encode(param1,local3.oneTimePurchase);
      this.codec_triedToBuy.encode(param1,local3.triedToBuy);
    }
  }
}
