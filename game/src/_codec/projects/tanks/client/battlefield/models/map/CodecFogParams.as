package _codec.projects.tanks.client.battlefield.models.map {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.map.FogParams;

  public class CodecFogParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_alpha:ICodec;
    private var codec_color:ICodec;
    private var codec_farLimit:ICodec;
    private var codec_nearLimit:ICodec;

    public function CodecFogParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_alpha = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_color = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_farLimit = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_nearLimit = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FogParams = new FogParams();
      local2.alpha = this.codec_alpha.decode(param1) as Number;
      local2.color = this.codec_color.decode(param1) as int;
      local2.farLimit = this.codec_farLimit.decode(param1) as Number;
      local2.nearLimit = this.codec_nearLimit.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FogParams = FogParams(param2);
      this.codec_alpha.encode(param1,local3.alpha);
      this.codec_color.encode(param1,local3.color);
      this.codec_farLimit.encode(param1,local3.farLimit);
      this.codec_nearLimit.encode(param1,local3.nearLimit);
    }
  }
}
