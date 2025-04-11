package _codec.projects.tanks.client.panel.model.mobilequest.quest {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.mobilequest.quest.MobileQuestReward;

  public class CodecMobileQuestReward implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_hint:ICodec;
    private var codec_name:ICodec;
    private var codec_preview:ICodec;
    private var codec_step:ICodec;

    public function CodecMobileQuestReward() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_hint = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_name = param1.getCodec(new TypeCodecInfo(String,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_step = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MobileQuestReward = new MobileQuestReward();
      local2.count = this.codec_count.decode(param1) as int;
      local2.hint = this.codec_hint.decode(param1) as String;
      local2.name = this.codec_name.decode(param1) as String;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      local2.step = this.codec_step.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MobileQuestReward = MobileQuestReward(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_hint.encode(param1,local3.hint);
      this.codec_name.encode(param1,local3.name);
      this.codec_preview.encode(param1,local3.preview);
      this.codec_step.encode(param1,local3.step);
    }
  }
}
