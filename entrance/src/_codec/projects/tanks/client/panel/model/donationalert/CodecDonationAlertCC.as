package _codec.projects.tanks.client.panel.model.donationalert {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import projects.tanks.client.panel.model.donationalert.DonationAlertCC;

  public class CodecDonationAlertCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_imageWithEmail:ICodec;
    private var codec_imageWithoutEmail:ICodec;
    private var codec_message:ICodec;

    public function CodecDonationAlertCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_imageWithEmail = param1.getCodec(new TypeCodecInfo(LocalizedImageResource,false));
      this.codec_imageWithoutEmail = param1.getCodec(new TypeCodecInfo(LocalizedImageResource,false));
      this.codec_message = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DonationAlertCC = new DonationAlertCC();
      local2.imageWithEmail = this.codec_imageWithEmail.decode(param1) as LocalizedImageResource;
      local2.imageWithoutEmail = this.codec_imageWithoutEmail.decode(param1) as LocalizedImageResource;
      local2.message = this.codec_message.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DonationAlertCC = DonationAlertCC(param2);
      this.codec_imageWithEmail.encode(param1,local3.imageWithEmail);
      this.codec_imageWithoutEmail.encode(param1,local3.imageWithoutEmail);
      this.codec_message.encode(param1,local3.message);
    }
  }
}
