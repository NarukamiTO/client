package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.sfx.ShotgunSFXCC;

  public class CodecShotgunSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_explosionMarkTextures:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_magazineReloadSound:ICodec;
    private var codec_pelletTrailTexture:ICodec;
    private var codec_reloadSound:ICodec;
    private var codec_shotAcrossTexture:ICodec;
    private var codec_shotAlongTexture:ICodec;
    private var codec_shotSound:ICodec;
    private var codec_smokeTexture:ICodec;
    private var codec_sparkleTexture:ICodec;

    public function CodecShotgunSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_explosionMarkTextures = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TextureResource,false),false,1));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_magazineReloadSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_pelletTrailTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_reloadSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shotAcrossTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_shotAlongTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_shotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_smokeTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_sparkleTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShotgunSFXCC = new ShotgunSFXCC();
      local2.explosionMarkTextures = this.codec_explosionMarkTextures.decode(param1) as Vector.<TextureResource>;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.magazineReloadSound = this.codec_magazineReloadSound.decode(param1) as SoundResource;
      local2.pelletTrailTexture = this.codec_pelletTrailTexture.decode(param1) as TextureResource;
      local2.reloadSound = this.codec_reloadSound.decode(param1) as SoundResource;
      local2.shotAcrossTexture = this.codec_shotAcrossTexture.decode(param1) as MultiframeTextureResource;
      local2.shotAlongTexture = this.codec_shotAlongTexture.decode(param1) as MultiframeTextureResource;
      local2.shotSound = this.codec_shotSound.decode(param1) as SoundResource;
      local2.smokeTexture = this.codec_smokeTexture.decode(param1) as MultiframeTextureResource;
      local2.sparkleTexture = this.codec_sparkleTexture.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShotgunSFXCC = ShotgunSFXCC(param2);
      this.codec_explosionMarkTextures.encode(param1,local3.explosionMarkTextures);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_magazineReloadSound.encode(param1,local3.magazineReloadSound);
      this.codec_pelletTrailTexture.encode(param1,local3.pelletTrailTexture);
      this.codec_reloadSound.encode(param1,local3.reloadSound);
      this.codec_shotAcrossTexture.encode(param1,local3.shotAcrossTexture);
      this.codec_shotAlongTexture.encode(param1,local3.shotAlongTexture);
      this.codec_shotSound.encode(param1,local3.shotSound);
      this.codec_smokeTexture.encode(param1,local3.smokeTexture);
      this.codec_sparkleTexture.encode(param1,local3.sparkleTexture);
    }
  }
}
