package _codec.projects.tanks.client.tanksservices.model.notifier.premium {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.tanksservices.model.notifier.premium.PremiumNotifierCC;

  public class CodecPremiumNotifierCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_lifeTimeInSeconds:ICodec;

    public function CodecPremiumNotifierCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_lifeTimeInSeconds = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PremiumNotifierCC = new PremiumNotifierCC();
      local2.lifeTimeInSeconds = this.codec_lifeTimeInSeconds.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PremiumNotifierCC = PremiumNotifierCC(param2);
      this.codec_lifeTimeInSeconds.encode(param1,local3.lifeTimeInSeconds);
    }
  }
}
