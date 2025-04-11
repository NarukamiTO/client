package _codec.projects.tanks.client.battlefield.models.mapbonuslight {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustParams;
  import projects.tanks.client.battlefield.models.mapbonuslight.MapBonusLightCC;

  public class CodecMapBonusLightCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bonusLightIntensity:ICodec;
    private var codec_hwColorAdjust:ICodec;
    private var codec_softColorAdjust:ICodec;

    public function CodecMapBonusLightCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bonusLightIntensity = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_hwColorAdjust = param1.getCodec(new TypeCodecInfo(ColorAdjustParams,false));
      this.codec_softColorAdjust = param1.getCodec(new TypeCodecInfo(ColorAdjustParams,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MapBonusLightCC = new MapBonusLightCC();
      local2.bonusLightIntensity = this.codec_bonusLightIntensity.decode(param1) as Number;
      local2.hwColorAdjust = this.codec_hwColorAdjust.decode(param1) as ColorAdjustParams;
      local2.softColorAdjust = this.codec_softColorAdjust.decode(param1) as ColorAdjustParams;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MapBonusLightCC = MapBonusLightCC(param2);
      this.codec_bonusLightIntensity.encode(param1,local3.bonusLightIntensity);
      this.codec_hwColorAdjust.encode(param1,local3.hwColorAdjust);
      this.codec_softColorAdjust.encode(param1,local3.softColorAdjust);
    }
  }
}
