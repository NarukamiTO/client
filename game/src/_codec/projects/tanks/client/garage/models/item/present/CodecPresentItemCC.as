package _codec.projects.tanks.client.garage.models.item.present {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.present.PresentItemCC;

  public class CodecPresentItemCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_image:ICodec;

    public function CodecPresentItemCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PresentItemCC = new PresentItemCC();
      local2.image = this.codec_image.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PresentItemCC = PresentItemCC(param2);
      this.codec_image.encode(param1,local3.image);
    }
  }
}
