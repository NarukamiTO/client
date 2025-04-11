package _codec.projects.tanks.client.garage.models.shopabonement {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.garage.models.shopabonement.ShopAbonementCC;

  public class CodecShopAbonementCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_shopCategory:ICodec;

    public function CodecShopAbonementCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_shopCategory = param1.getCodec(new EnumCodecInfo(ShopCategoryEnum,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopAbonementCC = new ShopAbonementCC();
      local2.shopCategory = this.codec_shopCategory.decode(param1) as ShopCategoryEnum;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopAbonementCC = ShopAbonementCC(param2);
      this.codec_shopCategory.encode(param1,local3.shopCategory);
    }
  }
}
