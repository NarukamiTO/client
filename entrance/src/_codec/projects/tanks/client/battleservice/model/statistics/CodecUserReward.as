package _codec.projects.tanks.client.battleservice.model.statistics {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.statistics.UserReward;

  public class CodecUserReward implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_newbiesAbonementBonusReward:ICodec;
    private var codec_premiumBonusReward:ICodec;
    private var codec_reward:ICodec;
    private var codec_starsReward:ICodec;
    private var codec_starsRewardForPremium:ICodec;
    private var codec_userId:ICodec;

    public function CodecUserReward() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_newbiesAbonementBonusReward = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_premiumBonusReward = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_reward = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_starsReward = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_starsRewardForPremium = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_userId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UserReward = new UserReward();
      local2.newbiesAbonementBonusReward = this.codec_newbiesAbonementBonusReward.decode(param1) as int;
      local2.premiumBonusReward = this.codec_premiumBonusReward.decode(param1) as int;
      local2.reward = this.codec_reward.decode(param1) as int;
      local2.starsReward = this.codec_starsReward.decode(param1) as int;
      local2.starsRewardForPremium = this.codec_starsRewardForPremium.decode(param1) as int;
      local2.userId = this.codec_userId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UserReward = UserReward(param2);
      this.codec_newbiesAbonementBonusReward.encode(param1,local3.newbiesAbonementBonusReward);
      this.codec_premiumBonusReward.encode(param1,local3.premiumBonusReward);
      this.codec_reward.encode(param1,local3.reward);
      this.codec_starsReward.encode(param1,local3.starsReward);
      this.codec_starsRewardForPremium.encode(param1,local3.starsRewardForPremium);
      this.codec_userId.encode(param1,local3.userId);
    }
  }
}
