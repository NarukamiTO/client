package _codec.projects.tanks.client.panel.model.quest.showing {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.panel.model.quest.showing.QuestPrizeInfo;

  public class CodecQuestPrizeInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_name:ICodec;
    private var codec_prizeObject:ICodec;

    public function CodecQuestPrizeInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_prizeObject = param1.getCodec(new TypeCodecInfo(Long,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:QuestPrizeInfo = new QuestPrizeInfo();
      local2.count = this.codec_count.decode(param1) as int;
      local2.name = this.codec_name.decode(param1) as String;
      local2.prizeObject = this.codec_prizeObject.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:QuestPrizeInfo = QuestPrizeInfo(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_name.encode(param1,local3.name);
      this.codec_prizeObject.encode(param1,local3.prizeObject);
    }
  }
}
