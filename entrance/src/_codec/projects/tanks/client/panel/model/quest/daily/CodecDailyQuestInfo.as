package _codec.projects.tanks.client.panel.model.quest.daily {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.quest.common.specification.QuestLevel;
  import projects.tanks.client.panel.model.quest.daily.DailyQuestInfo;
  import projects.tanks.client.panel.model.quest.showing.QuestPrizeInfo;

  public class CodecDailyQuestInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_canSkipForFree:ICodec;
    private var codec_description:ICodec;
    private var codec_finishCriteria:ICodec;
    private var codec_image:ICodec;
    private var codec_level:ICodec;
    private var codec_prizes:ICodec;
    private var codec_progress:ICodec;
    private var codec_questId:ICodec;
    private var codec_skipCost:ICodec;

    public function CodecDailyQuestInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_canSkipForFree = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_description = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_finishCriteria = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_level = param1.getCodec(new EnumCodecInfo(QuestLevel,false));
      this.codec_prizes = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(QuestPrizeInfo,false),false,1));
      this.codec_progress = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_questId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_skipCost = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DailyQuestInfo = new DailyQuestInfo();
      local2.canSkipForFree = this.codec_canSkipForFree.decode(param1) as Boolean;
      local2.description = this.codec_description.decode(param1) as String;
      local2.finishCriteria = this.codec_finishCriteria.decode(param1) as int;
      local2.image = this.codec_image.decode(param1) as ImageResource;
      local2.level = this.codec_level.decode(param1) as QuestLevel;
      local2.prizes = this.codec_prizes.decode(param1) as Vector.<QuestPrizeInfo>;
      local2.progress = this.codec_progress.decode(param1) as int;
      local2.questId = this.codec_questId.decode(param1) as Long;
      local2.skipCost = this.codec_skipCost.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DailyQuestInfo = DailyQuestInfo(param2);
      this.codec_canSkipForFree.encode(param1,local3.canSkipForFree);
      this.codec_description.encode(param1,local3.description);
      this.codec_finishCriteria.encode(param1,local3.finishCriteria);
      this.codec_image.encode(param1,local3.image);
      this.codec_level.encode(param1,local3.level);
      this.codec_prizes.encode(param1,local3.prizes);
      this.codec_progress.encode(param1,local3.progress);
      this.codec_questId.encode(param1,local3.questId);
      this.codec_skipCost.encode(param1,local3.skipCost);
    }
  }
}
