package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft {
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
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.shaft.ShaftShootSFXCC;

  public class CodecShaftShootSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_explosionSound:ICodec;
    private var codec_explosionTexture:ICodec;
    private var codec_hitMarkTexture:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_muzzleFlashTexture:ICodec;
    private var codec_shotSound:ICodec;
    private var codec_targetingSound:ICodec;
    private var codec_trailTexture:ICodec;
    private var codec_zoomModeSound:ICodec;

    public function CodecShaftShootSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_explosionSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_hitMarkTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_muzzleFlashTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_shotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_targetingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_trailTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_zoomModeSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShaftShootSFXCC = new ShaftShootSFXCC();
      local2.explosionSound = this.codec_explosionSound.decode(param1) as SoundResource;
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.hitMarkTexture = this.codec_hitMarkTexture.decode(param1) as TextureResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.muzzleFlashTexture = this.codec_muzzleFlashTexture.decode(param1) as MultiframeTextureResource;
      local2.shotSound = this.codec_shotSound.decode(param1) as SoundResource;
      local2.targetingSound = this.codec_targetingSound.decode(param1) as SoundResource;
      local2.trailTexture = this.codec_trailTexture.decode(param1) as TextureResource;
      local2.zoomModeSound = this.codec_zoomModeSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShaftShootSFXCC = ShaftShootSFXCC(param2);
      this.codec_explosionSound.encode(param1,local3.explosionSound);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_hitMarkTexture.encode(param1,local3.hitMarkTexture);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_muzzleFlashTexture.encode(param1,local3.muzzleFlashTexture);
      this.codec_shotSound.encode(param1,local3.shotSound);
      this.codec_targetingSound.encode(param1,local3.targetingSound);
      this.codec_trailTexture.encode(param1,local3.trailTexture);
      this.codec_zoomModeSound.encode(param1,local3.zoomModeSound);
    }
  }
}
