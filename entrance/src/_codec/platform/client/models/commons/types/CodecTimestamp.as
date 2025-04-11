package _codec.platform.client.models.commons.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Short;
  import platform.client.models.commons.types.Timestamp;

  public class CodecTimestamp implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_day:ICodec;
    private var codec_hours:ICodec;
    private var codec_minutes:ICodec;
    private var codec_month:ICodec;
    private var codec_seconds:ICodec;
    private var codec_year:ICodec;

    public function CodecTimestamp() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_day = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_hours = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_minutes = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_month = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_seconds = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_year = param1.getCodec(new TypeCodecInfo(Short,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Timestamp = new Timestamp();
      local2.day = this.codec_day.decode(param1) as int;
      local2.hours = this.codec_hours.decode(param1) as int;
      local2.minutes = this.codec_minutes.decode(param1) as int;
      local2.month = this.codec_month.decode(param1) as int;
      local2.seconds = this.codec_seconds.decode(param1) as int;
      local2.year = this.codec_year.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Timestamp = Timestamp(param2);
      this.codec_day.encode(param1,local3.day);
      this.codec_hours.encode(param1,local3.hours);
      this.codec_minutes.encode(param1,local3.minutes);
      this.codec_month.encode(param1,local3.month);
      this.codec_seconds.encode(param1,local3.seconds);
      this.codec_year.encode(param1,local3.year);
    }
  }
}
