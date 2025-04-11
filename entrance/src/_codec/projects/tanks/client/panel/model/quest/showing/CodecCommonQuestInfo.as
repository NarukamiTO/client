package _codec.projects.tanks.client.panel.model.quest.showing {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.quest.showing.CommonQuestInfo;
  import projects.tanks.client.panel.model.quest.showing.QuestPrizeInfo;

  public class CodecCommonQuestInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_description:ICodec;
    private var codec_finishCriteria:ICodec;
    private var codec_image:ICodec;
    private var codec_prizes:ICodec;
    private var codec_progress:ICodec;
    private var codec_questId:ICodec;

    public function CodecCommonQuestInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_description = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_finishCriteria = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_image = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_prizes = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(QuestPrizeInfo,false),false,1));
      this.codec_progress = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_questId = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CommonQuestInfo = new CommonQuestInfo();
      local2.description = this.codec_description.decode(param1) as String;
      local2.finishCriteria = this.codec_finishCriteria.decode(param1) as int;
      local2.image = this.codec_image.decode(param1) as ImageResource;
      local2.prizes = this.codec_prizes.decode(param1) as Vector.<QuestPrizeInfo>;
      local2.progress = this.codec_progress.decode(param1) as int;
      local2.questId = this.codec_questId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CommonQuestInfo = CommonQuestInfo(param2);
      this.codec_description.encode(param1,local3.description);
      this.codec_finishCriteria.encode(param1,local3.finishCriteria);
      this.codec_image.encode(param1,local3.image);
      this.codec_prizes.encode(param1,local3.prizes);
      this.codec_progress.encode(param1,local3.progress);
      this.codec_questId.encode(param1,local3.questId);
    }
  }
}
