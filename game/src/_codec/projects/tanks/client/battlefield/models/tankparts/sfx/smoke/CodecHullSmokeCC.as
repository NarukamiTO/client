package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.smoke {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.HullSmokeCC;

  public class CodecHullSmokeCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_alpha:ICodec;
    private var codec_density:ICodec;
    private var codec_enabled:ICodec;
    private var codec_fadeTime:ICodec;
    private var codec_farDistance:ICodec;
    private var codec_nearDistance:ICodec;
    private var codec_particle:ICodec;
    private var codec_size:ICodec;

    public function CodecHullSmokeCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_alpha = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_density = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_enabled = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_fadeTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_farDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_nearDistance = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_particle = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,true));
      this.codec_size = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:HullSmokeCC = new HullSmokeCC();
      local2.alpha = this.codec_alpha.decode(param1) as Number;
      local2.density = this.codec_density.decode(param1) as Number;
      local2.enabled = this.codec_enabled.decode(param1) as Boolean;
      local2.fadeTime = this.codec_fadeTime.decode(param1) as int;
      local2.farDistance = this.codec_farDistance.decode(param1) as Number;
      local2.nearDistance = this.codec_nearDistance.decode(param1) as Number;
      local2.particle = this.codec_particle.decode(param1) as MultiframeTextureResource;
      local2.size = this.codec_size.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:HullSmokeCC = HullSmokeCC(param2);
      this.codec_alpha.encode(param1,local3.alpha);
      this.codec_density.encode(param1,local3.density);
      this.codec_enabled.encode(param1,local3.enabled);
      this.codec_fadeTime.encode(param1,local3.fadeTime);
      this.codec_farDistance.encode(param1,local3.farDistance);
      this.codec_nearDistance.encode(param1,local3.nearDistance);
      this.codec_particle.encode(param1,local3.particle);
      this.codec_size.encode(param1,local3.size);
    }
  }
}
