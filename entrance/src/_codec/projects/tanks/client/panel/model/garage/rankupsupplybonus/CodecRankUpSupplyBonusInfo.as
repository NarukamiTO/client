package _codec.projects.tanks.client.panel.model.garage.rankupsupplybonus {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.garage.rankupsupplybonus.RankUpSupplyBonusInfo;

  public class CodecRankUpSupplyBonusInfo implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_count:ICodec;
    private var codec_preview:ICodec;
    private var codec_text:ICodec;

    public function CodecRankUpSupplyBonusInfo() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_count = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_preview = param1.getCodec(new TypeCodecInfo(ImageResource,false));
      this.codec_text = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RankUpSupplyBonusInfo = new RankUpSupplyBonusInfo();
      local2.count = this.codec_count.decode(param1) as int;
      local2.preview = this.codec_preview.decode(param1) as ImageResource;
      local2.text = this.codec_text.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RankUpSupplyBonusInfo = RankUpSupplyBonusInfo(param2);
      this.codec_count.encode(param1,local3.count);
      this.codec_preview.encode(param1,local3.preview);
      this.codec_text.encode(param1,local3.text);
    }
  }
}
