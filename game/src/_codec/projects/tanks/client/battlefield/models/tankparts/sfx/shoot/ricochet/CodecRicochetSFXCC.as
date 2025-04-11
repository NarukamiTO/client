package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.ricochet.RicochetSFXCC;

  public class CodecRicochetSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_bumpFlashTexture:ICodec;
    private var codec_explosionTexture:ICodec;
    private var codec_explostinSound:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_ricochetSound:ICodec;
    private var codec_shotFlashTexture:ICodec;
    private var codec_shotSound:ICodec;
    private var codec_shotTexture:ICodec;
    private var codec_tailTrailTexutre:ICodec;

    public function CodecRicochetSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_bumpFlashTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_explostinSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_ricochetSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shotFlashTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_shotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shotTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_tailTrailTexutre = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RicochetSFXCC = new RicochetSFXCC();
      local2.bumpFlashTexture = this.codec_bumpFlashTexture.decode(param1) as MultiframeTextureResource;
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.explostinSound = this.codec_explostinSound.decode(param1) as SoundResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.ricochetSound = this.codec_ricochetSound.decode(param1) as SoundResource;
      local2.shotFlashTexture = this.codec_shotFlashTexture.decode(param1) as TextureResource;
      local2.shotSound = this.codec_shotSound.decode(param1) as SoundResource;
      local2.shotTexture = this.codec_shotTexture.decode(param1) as MultiframeTextureResource;
      local2.tailTrailTexutre = this.codec_tailTrailTexutre.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RicochetSFXCC = RicochetSFXCC(param2);
      this.codec_bumpFlashTexture.encode(param1,local3.bumpFlashTexture);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_explostinSound.encode(param1,local3.explostinSound);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_ricochetSound.encode(param1,local3.ricochetSound);
      this.codec_shotFlashTexture.encode(param1,local3.shotFlashTexture);
      this.codec_shotSound.encode(param1,local3.shotSound);
      this.codec_shotTexture.encode(param1,local3.shotTexture);
      this.codec_tailTrailTexutre.encode(param1,local3.tailTrailTexutre);
    }
  }
}
