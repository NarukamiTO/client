package _codec.projects.tanks.client.panel.model.bonus.showing.info {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import projects.tanks.client.panel.model.bonus.showing.info.BonusInfoCC;

  public class CodecBonusInfoCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bottomText:ICodec;
    private var codec_image:ICodec;
    private var codec_topText:ICodec;

    public function CodecBonusInfoCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bottomText = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_image = param1.getCodec(new TypeCodecInfo(LocalizedImageResource,true));
      this.codec_topText = param1.getCodec(new TypeCodecInfo(String,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusInfoCC = new BonusInfoCC();
      local2.bottomText = this.codec_bottomText.decode(param1) as String;
      local2.image = this.codec_image.decode(param1) as LocalizedImageResource;
      local2.topText = this.codec_topText.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusInfoCC = BonusInfoCC(param2);
      this.codec_bottomText.encode(param1,local3.bottomText);
      this.codec_image.encode(param1,local3.image);
      this.codec_topText.encode(param1,local3.topText);
    }
  }
}
