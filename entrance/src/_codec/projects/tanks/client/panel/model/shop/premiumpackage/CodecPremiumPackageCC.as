package _codec.projects.tanks.client.panel.model.shop.premiumpackage {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.shop.premiumpackage.PremiumPackageCC;

  public class CodecPremiumPackageCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_durationInDays:ICodec;

    public function CodecPremiumPackageCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_durationInDays = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PremiumPackageCC = new PremiumPackageCC();
      local2.durationInDays = this.codec_durationInDays.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PremiumPackageCC = PremiumPackageCC(param2);
      this.codec_durationInDays.encode(param1,local3.durationInDays);
    }
  }
}
