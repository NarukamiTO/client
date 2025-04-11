package _codec.projects.tanks.client.battlefield.models.bonus.bonuslight {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.bonus.bonuslight.BonusLightCC;

  public class CodecBonusLightCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_attenuationBegin:ICodec;
    private var codec_attenuationEnd:ICodec;
    private var codec_intensity:ICodec;
    private var codec_lightColor:ICodec;

    public function CodecBonusLightCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_attenuationBegin = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_attenuationEnd = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_intensity = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_lightColor = param1.getCodec(new TypeCodecInfo(String,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BonusLightCC = new BonusLightCC();
      local2.attenuationBegin = this.codec_attenuationBegin.decode(param1) as Number;
      local2.attenuationEnd = this.codec_attenuationEnd.decode(param1) as Number;
      local2.intensity = this.codec_intensity.decode(param1) as Number;
      local2.lightColor = this.codec_lightColor.decode(param1) as String;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BonusLightCC = BonusLightCC(param2);
      this.codec_attenuationBegin.encode(param1,local3.attenuationBegin);
      this.codec_attenuationEnd.encode(param1,local3.attenuationEnd);
      this.codec_intensity.encode(param1,local3.intensity);
      this.codec_lightColor.encode(param1,local3.lightColor);
    }
  }
}
