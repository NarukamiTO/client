package _codec.projects.tanks.client.panel.model.abonements {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.commons.types.ShopAbonementBonusTypeEnum;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.panel.model.abonements.ShopAbonementData;

  public class CodecShopAbonementData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bonusType:ICodec;
    private var codec_remainingTime:ICodec;
    private var codec_shopCategory:ICodec;

    public function CodecShopAbonementData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bonusType = param1.getCodec(new EnumCodecInfo(ShopAbonementBonusTypeEnum,false));
      this.codec_remainingTime = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_shopCategory = param1.getCodec(new EnumCodecInfo(ShopCategoryEnum,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopAbonementData = new ShopAbonementData();
      local2.bonusType = this.codec_bonusType.decode(param1) as ShopAbonementBonusTypeEnum;
      local2.remainingTime = this.codec_remainingTime.decode(param1) as Long;
      local2.shopCategory = this.codec_shopCategory.decode(param1) as ShopCategoryEnum;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopAbonementData = ShopAbonementData(param2);
      this.codec_bonusType.encode(param1,local3.bonusType);
      this.codec_remainingTime.encode(param1,local3.remainingTime);
      this.codec_shopCategory.encode(param1,local3.shopCategory);
    }
  }
}
