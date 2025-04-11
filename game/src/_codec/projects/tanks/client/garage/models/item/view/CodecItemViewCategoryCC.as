package _codec.projects.tanks.client.garage.models.item.view {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.garage.models.item.view.ItemViewCategoryCC;

  public class CodecItemViewCategoryCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_category:ICodec;

    public function CodecItemViewCategoryCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_category = param1.getCodec(new EnumCodecInfo(ItemViewCategoryEnum,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ItemViewCategoryCC = new ItemViewCategoryCC();
      local2.category = this.codec_category.decode(param1) as ItemViewCategoryEnum;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ItemViewCategoryCC = ItemViewCategoryCC(param2);
      this.codec_category.encode(param1,local3.category);
    }
  }
}
