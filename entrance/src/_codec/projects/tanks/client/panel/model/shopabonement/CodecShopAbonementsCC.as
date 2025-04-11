package _codec.projects.tanks.client.panel.model.shopabonement {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shopabonement.ShopAbonementsCC;

  public class CodecShopAbonementsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_categoriesWithBonus:ICodec;

    public function CodecShopAbonementsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_categoriesWithBonus = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(IGameObject,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopAbonementsCC = new ShopAbonementsCC();
      local2.categoriesWithBonus = this.codec_categoriesWithBonus.decode(param1) as Vector.<IGameObject>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopAbonementsCC = ShopAbonementsCC(param2);
      this.codec_categoriesWithBonus.encode(param1,local3.categoriesWithBonus);
    }
  }
}
