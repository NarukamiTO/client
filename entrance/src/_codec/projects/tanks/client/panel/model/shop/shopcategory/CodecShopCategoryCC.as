package _codec.projects.tanks.client.panel.model.shop.shopcategory {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.panel.model.shop.shopcategory.ShopCategoryCC;

  public class CodecShopCategoryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_orderIndex:ICodec;
    private var codec_type:ICodec;
    private var codec_withJumpButton:ICodec;

    public function CodecShopCategoryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_orderIndex = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_type = param1.getCodec(new EnumCodecInfo(ShopCategoryEnum,false));
      this.codec_withJumpButton = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopCategoryCC = new ShopCategoryCC();
      local2.orderIndex = this.codec_orderIndex.decode(param1) as int;
      local2.type = this.codec_type.decode(param1) as ShopCategoryEnum;
      local2.withJumpButton = this.codec_withJumpButton.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopCategoryCC = ShopCategoryCC(param2);
      this.codec_orderIndex.encode(param1,local3.orderIndex);
      this.codec_type.encode(param1,local3.type);
      this.codec_withJumpButton.encode(param1,local3.withJumpButton);
    }
  }
}
