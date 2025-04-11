package _codec.projects.tanks.client.battlefield.models.map {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.map.DynamicShadowParams;

  public class CodecDynamicShadowParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_angleX:ICodec;
    private var codec_angleZ:ICodec;
    private var codec_lightColor:ICodec;
    private var codec_shadowColor:ICodec;

    public function CodecDynamicShadowParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_angleX = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_angleZ = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_lightColor = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_shadowColor = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DynamicShadowParams = new DynamicShadowParams();
      local2.angleX = this.codec_angleX.decode(param1) as Number;
      local2.angleZ = this.codec_angleZ.decode(param1) as Number;
      local2.lightColor = this.codec_lightColor.decode(param1) as int;
      local2.shadowColor = this.codec_shadowColor.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DynamicShadowParams = DynamicShadowParams(param2);
      this.codec_angleX.encode(param1,local3.angleX);
      this.codec_angleZ.encode(param1,local3.angleZ);
      this.codec_lightColor.encode(param1,local3.lightColor);
      this.codec_shadowColor.encode(param1,local3.shadowColor);
    }
  }
}
