package _codec.projects.tanks.client.battlefield.models.ultimate.common {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.ultimate.common.UltimateCC;

  public class CodecUltimateCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chargePercentPerSecond:ICodec;
    private var codec_charged:ICodec;
    private var codec_enabled:ICodec;

    public function CodecUltimateCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chargePercentPerSecond = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_charged = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:UltimateCC = new UltimateCC();
      local2.chargePercentPerSecond = this.codec_chargePercentPerSecond.decode(param1) as Number;
      local2.charged = this.codec_charged.decode(param1) as Boolean;
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:UltimateCC = UltimateCC(param2);
      this.codec_chargePercentPerSecond.encode(param1,local3.chargePercentPerSecond);
      this.codec_charged.encode(param1,local3.charged);
      this.codec_enabled.encode(param1,local3.enabled);
    }
  }
}
