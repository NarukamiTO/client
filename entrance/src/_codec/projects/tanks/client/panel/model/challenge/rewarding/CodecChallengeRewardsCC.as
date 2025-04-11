package _codec.projects.tanks.client.panel.model.challenge.rewarding {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.challenge.rewarding.ChallengeRewardsCC;
  import projects.tanks.client.panel.model.challenge.rewarding.Tier;

  public class CodecChallengeRewardsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_tiers:ICodec;

    public function CodecChallengeRewardsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_tiers = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(Tier,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ChallengeRewardsCC = new ChallengeRewardsCC();
      local2.tiers = this.codec_tiers.decode(param1) as Vector.<Tier>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ChallengeRewardsCC = ChallengeRewardsCC(param2);
      this.codec_tiers.encode(param1,local3.tiers);
    }
  }
}
