package _codec.projects.tanks.client.panel.model.donationalert.user.donation {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.donationalert.user.donation.DonationProfileCC;

  public class CodecDonationProfileCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_donator:ICodec;

    public function CodecDonationProfileCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_donator = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DonationProfileCC = new DonationProfileCC();
      local2.donator = this.codec_donator.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DonationProfileCC = DonationProfileCC(param2);
      this.codec_donator.encode(param1,local3.donator);
    }
  }
}
