package _codec.projects.tanks.client.battlefield.models.effects.duration.time {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.effects.duration.time.DurationCC;

  public class CodecDurationCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_durationTimeInMs:ICodec;
    private var codec_infinite:ICodec;

    public function CodecDurationCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_durationTimeInMs = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_infinite = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DurationCC = new DurationCC();
      local2.durationTimeInMs = this.codec_durationTimeInMs.decode(param1) as int;
      local2.infinite = this.codec_infinite.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DurationCC = DurationCC(param2);
      this.codec_durationTimeInMs.encode(param1,local3.durationTimeInMs);
      this.codec_infinite.encode(param1,local3.infinite);
    }
  }
}
