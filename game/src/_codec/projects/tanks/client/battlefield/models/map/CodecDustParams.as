package _codec.projects.tanks.client.battlefield.models.map {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.map.DustParams;

  public class CodecDustParams implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_alpha:ICodec;
    private var codec_density:ICodec;
    private var codec_dustFarDistance:ICodec;
    private var codec_dustNearDistance:ICodec;
    private var codec_dustParticle:ICodec;
    private var codec_dustSize:ICodec;

    public function CodecDustParams() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_alpha = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_density = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_dustFarDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_dustNearDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_dustParticle = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_dustSize = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DustParams = new DustParams();
      local2.alpha = this.codec_alpha.decode(param1) as Number;
      local2.density = this.codec_density.decode(param1) as Number;
      local2.dustFarDistance = this.codec_dustFarDistance.decode(param1) as Number;
      local2.dustNearDistance = this.codec_dustNearDistance.decode(param1) as Number;
      local2.dustParticle = this.codec_dustParticle.decode(param1) as MultiframeTextureResource;
      local2.dustSize = this.codec_dustSize.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DustParams = DustParams(param2);
      this.codec_alpha.encode(param1,local3.alpha);
      this.codec_density.encode(param1,local3.density);
      this.codec_dustFarDistance.encode(param1,local3.dustFarDistance);
      this.codec_dustNearDistance.encode(param1,local3.dustNearDistance);
      this.codec_dustParticle.encode(param1,local3.dustParticle);
      this.codec_dustSize.encode(param1,local3.dustSize);
    }
  }
}
