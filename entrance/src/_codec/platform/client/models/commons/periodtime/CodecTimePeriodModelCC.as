package _codec.platform.client.models.commons.periodtime {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.models.commons.periodtime.TimePeriodModelCC;

  public class CodecTimePeriodModelCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_isEnabled:ICodec;
    private var codec_isTimeless:ICodec;
    private var codec_timeLeftInSeconds:ICodec;
    private var codec_timeToStartInSeconds:ICodec;

    public function CodecTimePeriodModelCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_isEnabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_isTimeless = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_timeLeftInSeconds = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_timeToStartInSeconds = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TimePeriodModelCC = new TimePeriodModelCC();
      local2.isEnabled = this.codec_isEnabled.decode(param1) as Boolean;
      local2.isTimeless = this.codec_isTimeless.decode(param1) as Boolean;
      local2.timeLeftInSeconds = this.codec_timeLeftInSeconds.decode(param1) as int;
      local2.timeToStartInSeconds = this.codec_timeToStartInSeconds.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TimePeriodModelCC = TimePeriodModelCC(param2);
      this.codec_isEnabled.encode(param1,local3.isEnabled);
      this.codec_isTimeless.encode(param1,local3.isTimeless);
      this.codec_timeLeftInSeconds.encode(param1,local3.timeLeftInSeconds);
      this.codec_timeToStartInSeconds.encode(param1,local3.timeToStartInSeconds);
    }
  }
}
