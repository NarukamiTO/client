package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx {
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
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.MachineGunSFXCC;

  public class CodecMachineGunSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chainStartSound:ICodec;
    private var codec_crumbsTexture:ICodec;
    private var codec_dustTexture:ICodec;
    private var codec_fireAcrossTexture:ICodec;
    private var codec_fireAlongTexture:ICodec;
    private var codec_hitSound:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_longFailSound:ICodec;
    private var codec_shootEndSound:ICodec;
    private var codec_shootSound:ICodec;
    private var codec_smokeTexture:ICodec;
    private var codec_sparklesTexture:ICodec;
    private var codec_tankHitSound:ICodec;
    private var codec_tankSparklesTexture:ICodec;
    private var codec_tracerTexture:ICodec;
    private var codec_turbineStartSound:ICodec;

    public function CodecMachineGunSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chainStartSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_crumbsTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_dustTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_fireAcrossTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_fireAlongTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_hitSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_longFailSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shootEndSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shootSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_smokeTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_sparklesTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_tankHitSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_tankSparklesTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_tracerTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_turbineStartSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MachineGunSFXCC = new MachineGunSFXCC();
      local2.chainStartSound = this.codec_chainStartSound.decode(param1) as SoundResource;
      local2.crumbsTexture = this.codec_crumbsTexture.decode(param1) as TextureResource;
      local2.dustTexture = this.codec_dustTexture.decode(param1) as MultiframeTextureResource;
      local2.fireAcrossTexture = this.codec_fireAcrossTexture.decode(param1) as MultiframeTextureResource;
      local2.fireAlongTexture = this.codec_fireAlongTexture.decode(param1) as MultiframeTextureResource;
      local2.hitSound = this.codec_hitSound.decode(param1) as SoundResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.longFailSound = this.codec_longFailSound.decode(param1) as SoundResource;
      local2.shootEndSound = this.codec_shootEndSound.decode(param1) as SoundResource;
      local2.shootSound = this.codec_shootSound.decode(param1) as SoundResource;
      local2.smokeTexture = this.codec_smokeTexture.decode(param1) as MultiframeTextureResource;
      local2.sparklesTexture = this.codec_sparklesTexture.decode(param1) as MultiframeTextureResource;
      local2.tankHitSound = this.codec_tankHitSound.decode(param1) as SoundResource;
      local2.tankSparklesTexture = this.codec_tankSparklesTexture.decode(param1) as MultiframeTextureResource;
      local2.tracerTexture = this.codec_tracerTexture.decode(param1) as TextureResource;
      local2.turbineStartSound = this.codec_turbineStartSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MachineGunSFXCC = MachineGunSFXCC(param2);
      this.codec_chainStartSound.encode(param1,local3.chainStartSound);
      this.codec_crumbsTexture.encode(param1,local3.crumbsTexture);
      this.codec_dustTexture.encode(param1,local3.dustTexture);
      this.codec_fireAcrossTexture.encode(param1,local3.fireAcrossTexture);
      this.codec_fireAlongTexture.encode(param1,local3.fireAlongTexture);
      this.codec_hitSound.encode(param1,local3.hitSound);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_longFailSound.encode(param1,local3.longFailSound);
      this.codec_shootEndSound.encode(param1,local3.shootEndSound);
      this.codec_shootSound.encode(param1,local3.shootSound);
      this.codec_smokeTexture.encode(param1,local3.smokeTexture);
      this.codec_sparklesTexture.encode(param1,local3.sparklesTexture);
      this.codec_tankHitSound.encode(param1,local3.tankHitSound);
      this.codec_tankSparklesTexture.encode(param1,local3.tankSparklesTexture);
      this.codec_tracerTexture.encode(param1,local3.tracerTexture);
      this.codec_turbineStartSound.encode(param1,local3.turbineStartSound);
    }
  }
}
