package _codec.projects.tanks.client.panel.model.shop.description {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.description.ShopItemAdditionalDescriptionCC;

  public class CodecShopItemAdditionalDescriptionCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_additionalDescription:ICodec;

    public function CodecShopItemAdditionalDescriptionCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_additionalDescription = param1.getCodec(new TypeCodecInfo(String,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShopItemAdditionalDescriptionCC = new ShopItemAdditionalDescriptionCC();
      local2.additionalDescription = this.codec_additionalDescription.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShopItemAdditionalDescriptionCC = ShopItemAdditionalDescriptionCC(param2);
      this.codec_additionalDescription.encode(param1,local3.additionalDescription);
    }
  }
}
