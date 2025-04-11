package _codec.projects.tanks.client.panel.model.payment {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.panel.model.payment.PaymentCC;

  public class CodecPaymentCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_currentCategoryType:ICodec;
    private var codec_hideLinks:ICodec;
    private var codec_manualDescription:ICodec;
    private var codec_payModes:ICodec;
    private var codec_shopCategories:ICodec;
    private var codec_shopItems:ICodec;

    public function CodecPaymentCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_currentCategoryType = param1.getCodec(new EnumCodecInfo(ShopCategoryEnum,false));
      this.codec_hideLinks = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_manualDescription = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_payModes = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this.codec_shopCategories = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
      this.codec_shopItems = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PaymentCC = new PaymentCC();
      local2.currentCategoryType = this.codec_currentCategoryType.decode(param1) as ShopCategoryEnum;
      local2.hideLinks = this.codec_hideLinks.decode(param1) as Boolean;
      local2.manualDescription = this.codec_manualDescription.decode(param1) as String;
      local2.payModes = this.codec_payModes.decode(param1) as Vector.<IGameObject>;
      local2.shopCategories = this.codec_shopCategories.decode(param1) as Vector.<IGameObject>;
      local2.shopItems = this.codec_shopItems.decode(param1) as Vector.<IGameObject>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PaymentCC = PaymentCC(param2);
      this.codec_currentCategoryType.encode(param1,local3.currentCategoryType);
      this.codec_hideLinks.encode(param1,local3.hideLinks);
      this.codec_manualDescription.encode(param1,local3.manualDescription);
      this.codec_payModes.encode(param1,local3.payModes);
      this.codec_shopCategories.encode(param1,local3.shopCategories);
      this.codec_shopItems.encode(param1,local3.shopItems);
    }
  }
}
