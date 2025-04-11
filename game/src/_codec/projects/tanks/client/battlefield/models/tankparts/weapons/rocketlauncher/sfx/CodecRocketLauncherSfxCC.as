package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.sfx {
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
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.sfx.RocketLauncherSfxCC;

  public class CodecRocketLauncherSfxCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_aimingCompleteSound:ICodec;
    private var codec_aimingSound:ICodec;
    private var codec_explosionMarkTexture:ICodec;
    private var codec_explosionTexture:ICodec;
    private var codec_leftHitSounds:ICodec;
    private var codec_leftShotSounds:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_rightHitSounds:ICodec;
    private var codec_rightShotSounds:ICodec;
    private var codec_rocketFlameTexture:ICodec;
    private var codec_rocketFlightSound:ICodec;
    private var codec_rocketSmokeTexture:ICodec;
    private var codec_rocketTexture:ICodec;
    private var codec_targetLostSound:ICodec;

    public function CodecRocketLauncherSfxCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_aimingCompleteSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_aimingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_explosionMarkTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_leftHitSounds = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_leftShotSounds = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_rightHitSounds = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_rightShotSounds = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_rocketFlameTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_rocketFlightSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_rocketSmokeTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_rocketTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_targetLostSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RocketLauncherSfxCC = new RocketLauncherSfxCC();
      local2.aimingCompleteSound = this.codec_aimingCompleteSound.decode(param1) as SoundResource;
      local2.aimingSound = this.codec_aimingSound.decode(param1) as SoundResource;
      local2.explosionMarkTexture = this.codec_explosionMarkTexture.decode(param1) as TextureResource;
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.leftHitSounds = this.codec_leftHitSounds.decode(param1) as SoundResource;
      local2.leftShotSounds = this.codec_leftShotSounds.decode(param1) as SoundResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.rightHitSounds = this.codec_rightHitSounds.decode(param1) as SoundResource;
      local2.rightShotSounds = this.codec_rightShotSounds.decode(param1) as SoundResource;
      local2.rocketFlameTexture = this.codec_rocketFlameTexture.decode(param1) as TextureResource;
      local2.rocketFlightSound = this.codec_rocketFlightSound.decode(param1) as SoundResource;
      local2.rocketSmokeTexture = this.codec_rocketSmokeTexture.decode(param1) as TextureResource;
      local2.rocketTexture = this.codec_rocketTexture.decode(param1) as TextureResource;
      local2.targetLostSound = this.codec_targetLostSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RocketLauncherSfxCC = RocketLauncherSfxCC(param2);
      this.codec_aimingCompleteSound.encode(param1,local3.aimingCompleteSound);
      this.codec_aimingSound.encode(param1,local3.aimingSound);
      this.codec_explosionMarkTexture.encode(param1,local3.explosionMarkTexture);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_leftHitSounds.encode(param1,local3.leftHitSounds);
      this.codec_leftShotSounds.encode(param1,local3.leftShotSounds);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_rightHitSounds.encode(param1,local3.rightHitSounds);
      this.codec_rightShotSounds.encode(param1,local3.rightShotSounds);
      this.codec_rocketFlameTexture.encode(param1,local3.rocketFlameTexture);
      this.codec_rocketFlightSound.encode(param1,local3.rocketFlightSound);
      this.codec_rocketSmokeTexture.encode(param1,local3.rocketSmokeTexture);
      this.codec_rocketTexture.encode(param1,local3.rocketTexture);
      this.codec_targetLostSound.encode(param1,local3.targetLostSound);
    }
  }
}
