package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins {
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
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.twins.TwinsShootSFXCC;

  public class CodecTwinsShootSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_explosionTexture:ICodec;
    private var codec_hitMarkTexture:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_muzzleFlashTexture:ICodec;
    private var codec_shotSound:ICodec;
    private var codec_shotTexture:ICodec;

    public function CodecTwinsShootSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_hitMarkTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_muzzleFlashTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_shotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shotTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TwinsShootSFXCC = new TwinsShootSFXCC();
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.hitMarkTexture = this.codec_hitMarkTexture.decode(param1) as TextureResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.muzzleFlashTexture = this.codec_muzzleFlashTexture.decode(param1) as TextureResource;
      local2.shotSound = this.codec_shotSound.decode(param1) as SoundResource;
      local2.shotTexture = this.codec_shotTexture.decode(param1) as MultiframeTextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TwinsShootSFXCC = TwinsShootSFXCC(param2);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_hitMarkTexture.encode(param1,local3.hitMarkTexture);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_muzzleFlashTexture.encode(param1,local3.muzzleFlashTexture);
      this.codec_shotSound.encode(param1,local3.shotSound);
      this.codec_shotTexture.encode(param1,local3.shotTexture);
    }
  }
}
