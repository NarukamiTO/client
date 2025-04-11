package _codec.projects.tanks.client.tanksservices.model.notifier.referrals {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.tanksservices.model.notifier.referrals.ReferralNotifierData;

  public class CodecReferralNotifierData implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_referral:ICodec;
    private var codec_userId:ICodec;

    public function CodecReferralNotifierData() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_referral = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ReferralNotifierData = new ReferralNotifierData();
      local2.referral = this.codec_referral.decode(param1) as Boolean;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ReferralNotifierData = ReferralNotifierData(param2);
      this.codec_referral.encode(param1,local3.referral);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
