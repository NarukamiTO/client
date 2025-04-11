package _codec.projects.tanks.client.panel.model.quest.notifier {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.panel.model.quest.notifier.QuestNotifierCC;

  public class CodecQuestNotifierCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_hasCompletedDailyQuests:ICodec;
    private var codec_hasCompletedWeeklyQuests:ICodec;
    private var codec_hasNewDailyQuests:ICodec;
    private var codec_hasNewWeeklyQuests:ICodec;
    private var codec_hasNotCompletedQuests:ICodec;

    public function CodecQuestNotifierCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_hasCompletedDailyQuests = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_hasCompletedWeeklyQuests = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_hasNewDailyQuests = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_hasNewWeeklyQuests = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_hasNotCompletedQuests = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:QuestNotifierCC = new QuestNotifierCC();
      local2.hasCompletedDailyQuests = this.codec_hasCompletedDailyQuests.decode(param1) as Boolean;
      local2.hasCompletedWeeklyQuests = this.codec_hasCompletedWeeklyQuests.decode(param1) as Boolean;
      local2.hasNewDailyQuests = this.codec_hasNewDailyQuests.decode(param1) as Boolean;
      local2.hasNewWeeklyQuests = this.codec_hasNewWeeklyQuests.decode(param1) as Boolean;
      local2.hasNotCompletedQuests = this.codec_hasNotCompletedQuests.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:QuestNotifierCC = QuestNotifierCC(param2);
      this.codec_hasCompletedDailyQuests.encode(param1,local3.hasCompletedDailyQuests);
      this.codec_hasCompletedWeeklyQuests.encode(param1,local3.hasCompletedWeeklyQuests);
      this.codec_hasNewDailyQuests.encode(param1,local3.hasNewDailyQuests);
      this.codec_hasNewWeeklyQuests.encode(param1,local3.hasNewWeeklyQuests);
      this.codec_hasNotCompletedQuests.encode(param1,local3.hasNotCompletedQuests);
    }
  }
}
