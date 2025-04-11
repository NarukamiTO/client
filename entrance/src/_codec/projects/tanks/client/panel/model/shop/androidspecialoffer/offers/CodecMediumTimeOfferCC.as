package _codec.projects.tanks.client.panel.model.shop.androidspecialoffer.offers {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.androidspecialoffer.offers.MediumTimeOfferCC;

  public class CodecMediumTimeOfferCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_paintPreview:ICodec;

    public function CodecMediumTimeOfferCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_paintPreview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MediumTimeOfferCC = new MediumTimeOfferCC();
      local2.paintPreview = this.codec_paintPreview.decode(param1) as ImageResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MediumTimeOfferCC = MediumTimeOfferCC(param2);
      this.codec_paintPreview.encode(param1,local3.paintPreview);
    }
  }
}
