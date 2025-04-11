package _codec.projects.tanks.client.battleservice {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battleservice.Range;

  public class CodecRange implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_max:ICodec;
    private var codec_min:ICodec;

    public function CodecRange() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_max = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_min = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:Range = new Range();
      local2.max = this.codec_max.decode(param1) as int;
      local2.min = this.codec_min.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:Range = Range(param2);
      this.codec_max.encode(param1,local3.max);
      this.codec_min.encode(param1,local3.min);
    }
  }
}
