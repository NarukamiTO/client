package _codec.projects.tanks.client.panel.model.quest.daily {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.quest.daily.DailyQuestShowingCC;

  public class CodecDailyQuestShowingCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_hasNewQuests:ICodec;
    private var codec_timeToNextQuest:ICodec;

    public function CodecDailyQuestShowingCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_hasNewQuests = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_timeToNextQuest = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DailyQuestShowingCC = new DailyQuestShowingCC();
      local2.hasNewQuests = this.codec_hasNewQuests.decode(param1) as Boolean;
      local2.timeToNextQuest = this.codec_timeToNextQuest.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DailyQuestShowingCC = DailyQuestShowingCC(param2);
      this.codec_hasNewQuests.encode(param1,local3.hasNewQuests);
      this.codec_timeToNextQuest.encode(param1,local3.timeToNextQuest);
    }
  }
}
