package _codec.projects.tanks.client.panel.model.shop.specialkit.view.singleitem {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.specialkit.view.singleitem.SingleItemKitViewCC;

  public class CodecSingleItemKitViewCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_brandIcon:ICodec;
    private var codec_button:ICodec;
    private var codec_buttonOver:ICodec;
    private var codec_preview:ICodec;

    public function CodecSingleItemKitViewCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_brandIcon = param1.getCodec(new TypeCodecInfo(ImageResource,true));
      this.codec_button = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_buttonOver = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:SingleItemKitViewCC = new SingleItemKitViewCC();
      local2.brandIcon = this.codec_brandIcon.decode(param1) as ImageResource;
      local2.button = this.codec_button.decode(param1) as ImageResource;
      local2.buttonOver = this.codec_buttonOver.decode(param1) as ImageResource;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:SingleItemKitViewCC = SingleItemKitViewCC(param2);
      this.codec_brandIcon.encode(param1,local3.brandIcon);
      this.codec_button.encode(param1,local3.button);
      this.codec_buttonOver.encode(param1,local3.buttonOver);
      this.codec_preview.encode(param1,local3.preview);
    }
  }
}
