package _codec.projects.tanks.client.panel.model.payment.modes.description {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.payment.modes.description.BottomDescriptionCC;

  public class CodecBottomDescriptionCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_description:ICodec;
    private var codec_images:ICodec;

    public function CodecBottomDescriptionCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_description = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_images = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ImageResource,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BottomDescriptionCC = new BottomDescriptionCC();
      local2.description = this.codec_description.decode(param1) as String;
      local2.images = this.codec_images.decode(param1) as Vector.<ImageResource>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BottomDescriptionCC = BottomDescriptionCC(param2);
      this.codec_description.encode(param1,local3.description);
      this.codec_images.encode(param1,local3.images);
    }
  }
}
