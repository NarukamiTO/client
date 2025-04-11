package _codec.projects.tanks.client.panel.model.shop.specialkit {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.specialkit.ShopKitText;
  import projects.tanks.client.panel.model.shop.specialkit.SpecialKitPackageCC;

  public class CodecSpecialKitPackageCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_crystalsAmount:ICodec;
    private var codec_everySupplyAmount:ICodec;
    private var codec_goldAmount:ICodec;
    private var codec_itemsCount:ICodec;
    private var codec_premiumDurationInDays:ICodec;
    private var codec_showPremiumIcon:ICodec;
    private var codec_texts:ICodec;
    private var codec_withAdditionalItem:ICodec;

    public function CodecSpecialKitPackageCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_crystalsAmount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_everySupplyAmount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_goldAmount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_itemsCount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_premiumDurationInDays = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_showPremiumIcon = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_texts = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ShopKitText,false),false,1));
      this.codec_withAdditionalItem = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SpecialKitPackageCC = new SpecialKitPackageCC();
      local2.crystalsAmount = this.codec_crystalsAmount.decode(param1) as int;
      local2.everySupplyAmount = this.codec_everySupplyAmount.decode(param1) as int;
      local2.goldAmount = this.codec_goldAmount.decode(param1) as int;
      local2.itemsCount = this.codec_itemsCount.decode(param1) as int;
      local2.premiumDurationInDays = this.codec_premiumDurationInDays.decode(param1) as int;
      local2.showPremiumIcon = this.codec_showPremiumIcon.decode(param1) as Boolean;
      local2.texts = this.codec_texts.decode(param1) as Vector.<ShopKitText>;
      local2.withAdditionalItem = this.codec_withAdditionalItem.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SpecialKitPackageCC = SpecialKitPackageCC(param2);
      this.codec_crystalsAmount.encode(param1,local3.crystalsAmount);
      this.codec_everySupplyAmount.encode(param1,local3.everySupplyAmount);
      this.codec_goldAmount.encode(param1,local3.goldAmount);
      this.codec_itemsCount.encode(param1,local3.itemsCount);
      this.codec_premiumDurationInDays.encode(param1,local3.premiumDurationInDays);
      this.codec_showPremiumIcon.encode(param1,local3.showPremiumIcon);
      this.codec_texts.encode(param1,local3.texts);
      this.codec_withAdditionalItem.encode(param1,local3.withAdditionalItem);
    }
  }
}
