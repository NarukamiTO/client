package _codec.projects.tanks.client.panel.model.shop.shopitemcategory {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.shopitemcategory.ShopItemCategoryCC;

  public class CodecShopItemCategoryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_category:ICodec;

    public function CodecShopItemCategoryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_category = param1.getCodec(new TypeCodecInfo(IGameObject,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopItemCategoryCC = new ShopItemCategoryCC();
      local2.category = this.codec_category.decode(param1) as IGameObject;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopItemCategoryCC = ShopItemCategoryCC(param2);
      this.codec_category.encode(param1,local3.category);
    }
  }
}
