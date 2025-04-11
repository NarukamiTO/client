package _codec.projects.tanks.client.battlefield.models.tankparts.weapon.gauss.sfx {
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
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.sfx.GaussSFXCC;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecGaussSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_antennaDownSound:ICodec;
    private var codec_antennaUpSound:ICodec;
    private var codec_electroTexture:ICodec;
    private var codec_explosionElectroTexture:ICodec;
    private var codec_explosionTexture:ICodec;
    private var codec_fireTexture:ICodec;
    private var codec_flameTexture:ICodec;
    private var codec_hitMarkerTexture:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_lightningTexture:ICodec;
    private var codec_powerShotFarSound1:ICodec;
    private var codec_powerShotFarSound2:ICodec;
    private var codec_powerShotFarSound3:ICodec;
    private var codec_primaryHitSound:ICodec;
    private var codec_primaryShellFlightSound:ICodec;
    private var codec_primaryShotSound:ICodec;
    private var codec_secondaryHitSound:ICodec;
    private var codec_secondaryShotSound:ICodec;
    private var codec_shell:ICodec;
    private var codec_shellTexture:ICodec;
    private var codec_smokeTexture:ICodec;
    private var codec_startAimingSound:ICodec;
    private var codec_targetLockSound:ICodec;
    private var codec_targetLostSound:ICodec;
    private var codec_tracerTexture:ICodec;
    private var codec_trailTexture:ICodec;

    public function CodecGaussSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_antennaDownSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_antennaUpSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_electroTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_explosionElectroTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_fireTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_flameTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_hitMarkerTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_lightningTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_powerShotFarSound1 = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_powerShotFarSound2 = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_powerShotFarSound3 = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_primaryHitSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_primaryShellFlightSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_primaryShotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_secondaryHitSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_secondaryShotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shell = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_shellTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_smokeTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_startAimingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_targetLockSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_targetLostSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_tracerTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_trailTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GaussSFXCC = new GaussSFXCC();
      local2.antennaDownSound = this.codec_antennaDownSound.decode(param1) as SoundResource;
      local2.antennaUpSound = this.codec_antennaUpSound.decode(param1) as SoundResource;
      local2.electroTexture = this.codec_electroTexture.decode(param1) as TextureResource;
      local2.explosionElectroTexture = this.codec_explosionElectroTexture.decode(param1) as MultiframeTextureResource;
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.fireTexture = this.codec_fireTexture.decode(param1) as TextureResource;
      local2.flameTexture = this.codec_flameTexture.decode(param1) as TextureResource;
      local2.hitMarkerTexture = this.codec_hitMarkerTexture.decode(param1) as TextureResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.lightningTexture = this.codec_lightningTexture.decode(param1) as TextureResource;
      local2.powerShotFarSound1 = this.codec_powerShotFarSound1.decode(param1) as SoundResource;
      local2.powerShotFarSound2 = this.codec_powerShotFarSound2.decode(param1) as SoundResource;
      local2.powerShotFarSound3 = this.codec_powerShotFarSound3.decode(param1) as SoundResource;
      local2.primaryHitSound = this.codec_primaryHitSound.decode(param1) as SoundResource;
      local2.primaryShellFlightSound = this.codec_primaryShellFlightSound.decode(param1) as SoundResource;
      local2.primaryShotSound = this.codec_primaryShotSound.decode(param1) as SoundResource;
      local2.secondaryHitSound = this.codec_secondaryHitSound.decode(param1) as SoundResource;
      local2.secondaryShotSound = this.codec_secondaryShotSound.decode(param1) as SoundResource;
      local2.shell = this.codec_shell.decode(param1) as Tanks3DSResource;
      local2.shellTexture = this.codec_shellTexture.decode(param1) as TextureResource;
      local2.smokeTexture = this.codec_smokeTexture.decode(param1) as TextureResource;
      local2.startAimingSound = this.codec_startAimingSound.decode(param1) as SoundResource;
      local2.targetLockSound = this.codec_targetLockSound.decode(param1) as SoundResource;
      local2.targetLostSound = this.codec_targetLostSound.decode(param1) as SoundResource;
      local2.tracerTexture = this.codec_tracerTexture.decode(param1) as TextureResource;
      local2.trailTexture = this.codec_trailTexture.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:GaussSFXCC = GaussSFXCC(param2);
      this.codec_antennaDownSound.encode(param1,local3.antennaDownSound);
      this.codec_antennaUpSound.encode(param1,local3.antennaUpSound);
      this.codec_electroTexture.encode(param1,local3.electroTexture);
      this.codec_explosionElectroTexture.encode(param1,local3.explosionElectroTexture);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_fireTexture.encode(param1,local3.fireTexture);
      this.codec_flameTexture.encode(param1,local3.flameTexture);
      this.codec_hitMarkerTexture.encode(param1,local3.hitMarkerTexture);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_lightningTexture.encode(param1,local3.lightningTexture);
      this.codec_powerShotFarSound1.encode(param1,local3.powerShotFarSound1);
      this.codec_powerShotFarSound2.encode(param1,local3.powerShotFarSound2);
      this.codec_powerShotFarSound3.encode(param1,local3.powerShotFarSound3);
      this.codec_primaryHitSound.encode(param1,local3.primaryHitSound);
      this.codec_primaryShellFlightSound.encode(param1,local3.primaryShellFlightSound);
      this.codec_primaryShotSound.encode(param1,local3.primaryShotSound);
      this.codec_secondaryHitSound.encode(param1,local3.secondaryHitSound);
      this.codec_secondaryShotSound.encode(param1,local3.secondaryShotSound);
      this.codec_shell.encode(param1,local3.shell);
      this.codec_shellTexture.encode(param1,local3.shellTexture);
      this.codec_smokeTexture.encode(param1,local3.smokeTexture);
      this.codec_startAimingSound.encode(param1,local3.startAimingSound);
      this.codec_targetLockSound.encode(param1,local3.targetLockSound);
      this.codec_targetLostSound.encode(param1,local3.targetLostSound);
      this.codec_tracerTexture.encode(param1,local3.tracerTexture);
      this.codec_trailTexture.encode(param1,local3.trailTexture);
    }
  }
}
