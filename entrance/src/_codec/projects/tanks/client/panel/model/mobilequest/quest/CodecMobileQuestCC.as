package _codec.projects.tanks.client.panel.model.mobilequest.quest {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.panel.model.mobilequest.quest.MobileQuestCC;
  import projects.tanks.client.panel.model.mobilequest.quest.MobileQuestReward;

  public class CodecMobileQuestCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_countSteps:ICodec;
    private var codec_rewards:ICodec;
    private var codec_skipStepShopItemId:ICodec;

    public function CodecMobileQuestCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_countSteps = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_rewards = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(MobileQuestReward,false),false,1));
      this.codec_skipStepShopItemId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MobileQuestCC = new MobileQuestCC();
      local2.countSteps = this.codec_countSteps.decode(param1) as int;
      local2.rewards = this.codec_rewards.decode(param1) as Vector.<MobileQuestReward>;
      local2.skipStepShopItemId = this.codec_skipStepShopItemId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MobileQuestCC = MobileQuestCC(param2);
      this.codec_countSteps.encode(param1,local3.countSteps);
      this.codec_rewards.encode(param1,local3.rewards);
      this.codec_skipStepShopItemId.encode(param1,local3.skipStepShopItemId);
    }
  }
}
