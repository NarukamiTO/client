package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.freeze {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.freeze.FreezeSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class CodecFreezeSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_buffedShardsTextureResource:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_particleSpeed:ICodec;
    private var codec_particleTextureResource:ICodec;
    private var codec_planeTextureResource:ICodec;
    private var codec_shotSoundResource:ICodec;

    public function CodecFreezeSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_buffedShardsTextureResource = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_particleSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_particleTextureResource = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_planeTextureResource = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_shotSoundResource = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FreezeSFXCC = new FreezeSFXCC();
      local2.buffedShardsTextureResource = this.codec_buffedShardsTextureResource.decode(param1) as TextureResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.particleSpeed = this.codec_particleSpeed.decode(param1) as Number;
      local2.particleTextureResource = this.codec_particleTextureResource.decode(param1) as MultiframeTextureResource;
      local2.planeTextureResource = this.codec_planeTextureResource.decode(param1) as MultiframeTextureResource;
      local2.shotSoundResource = this.codec_shotSoundResource.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FreezeSFXCC = FreezeSFXCC(param2);
      this.codec_buffedShardsTextureResource.encode(param1,local3.buffedShardsTextureResource);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_particleSpeed.encode(param1,local3.particleSpeed);
      this.codec_particleTextureResource.encode(param1,local3.particleTextureResource);
      this.codec_planeTextureResource.encode(param1,local3.planeTextureResource);
      this.codec_shotSoundResource.encode(param1,local3.shotSoundResource);
    }
  }
}
