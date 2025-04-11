package _codec.projects.tanks.client.battlefield.models.coloradjust {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustCC;
  import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustParams;

  public class CodecColorAdjustCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_frostParamsHW:ICodec;
    private var codec_frostParamsSoft:ICodec;
    private var codec_heatParamsHW:ICodec;
    private var codec_heatParamsSoft:ICodec;

    public function CodecColorAdjustCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_frostParamsHW = param1.getCodec(new TypeCodecInfo(ColorAdjustParams,false));
      this.codec_frostParamsSoft = param1.getCodec(new TypeCodecInfo(ColorAdjustParams,false));
      this.codec_heatParamsHW = param1.getCodec(new TypeCodecInfo(ColorAdjustParams,false));
      this.codec_heatParamsSoft = param1.getCodec(new TypeCodecInfo(ColorAdjustParams,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ColorAdjustCC = new ColorAdjustCC();
      local2.frostParamsHW = this.codec_frostParamsHW.decode(param1) as ColorAdjustParams;
      local2.frostParamsSoft = this.codec_frostParamsSoft.decode(param1) as ColorAdjustParams;
      local2.heatParamsHW = this.codec_heatParamsHW.decode(param1) as ColorAdjustParams;
      local2.heatParamsSoft = this.codec_heatParamsSoft.decode(param1) as ColorAdjustParams;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ColorAdjustCC = ColorAdjustCC(param2);
      this.codec_frostParamsHW.encode(param1,local3.frostParamsHW);
      this.codec_frostParamsSoft.encode(param1,local3.frostParamsSoft);
      this.codec_heatParamsHW.encode(param1,local3.heatParamsHW);
      this.codec_heatParamsSoft.encode(param1,local3.heatParamsSoft);
    }
  }
}
