package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.twins {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;

  public class CodecTwinsCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_shellRadius:ICodec;
    private var codec_speed:ICodec;

    public function CodecTwinsCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_shellRadius = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_speed = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TwinsCC = new TwinsCC();
      local2.shellRadius = this.codec_shellRadius.decode(param1) as Number;
      local2.speed = this.codec_speed.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TwinsCC = TwinsCC(param2);
      this.codec_shellRadius.encode(param1,local3.shellRadius);
      this.codec_speed.encode(param1,local3.speed);
    }
  }
}
