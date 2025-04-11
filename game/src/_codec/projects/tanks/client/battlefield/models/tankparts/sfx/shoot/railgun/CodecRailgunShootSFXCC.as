package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun {
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
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.railgun.RailgunShootSFXCC;

  public class CodecRailgunShootSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chargingPart1:ICodec;
    private var codec_chargingPart2:ICodec;
    private var codec_chargingPart3:ICodec;
    private var codec_hitMarkTexture:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_powTexture:ICodec;
    private var codec_ringsTexture:ICodec;
    private var codec_shotSound:ICodec;
    private var codec_smokeImage:ICodec;
    private var codec_sphereTexture:ICodec;
    private var codec_trailImage:ICodec;

    public function CodecRailgunShootSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chargingPart1 = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_chargingPart2 = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_chargingPart3 = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_hitMarkTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_powTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_ringsTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_shotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_smokeImage = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_sphereTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_trailImage = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:RailgunShootSFXCC = new RailgunShootSFXCC();
      local2.chargingPart1 = this.codec_chargingPart1.decode(param1) as TextureResource;
      local2.chargingPart2 = this.codec_chargingPart2.decode(param1) as TextureResource;
      local2.chargingPart3 = this.codec_chargingPart3.decode(param1) as TextureResource;
      local2.hitMarkTexture = this.codec_hitMarkTexture.decode(param1) as TextureResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.powTexture = this.codec_powTexture.decode(param1) as MultiframeTextureResource;
      local2.ringsTexture = this.codec_ringsTexture.decode(param1) as MultiframeTextureResource;
      local2.shotSound = this.codec_shotSound.decode(param1) as SoundResource;
      local2.smokeImage = this.codec_smokeImage.decode(param1) as TextureResource;
      local2.sphereTexture = this.codec_sphereTexture.decode(param1) as MultiframeTextureResource;
      local2.trailImage = this.codec_trailImage.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:RailgunShootSFXCC = RailgunShootSFXCC(param2);
      this.codec_chargingPart1.encode(param1,local3.chargingPart1);
      this.codec_chargingPart2.encode(param1,local3.chargingPart2);
      this.codec_chargingPart3.encode(param1,local3.chargingPart3);
      this.codec_hitMarkTexture.encode(param1,local3.hitMarkTexture);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_powTexture.encode(param1,local3.powTexture);
      this.codec_ringsTexture.encode(param1,local3.ringsTexture);
      this.codec_shotSound.encode(param1,local3.shotSound);
      this.codec_smokeImage.encode(param1,local3.smokeImage);
      this.codec_sphereTexture.encode(param1,local3.sphereTexture);
      this.codec_trailImage.encode(param1,local3.trailImage);
    }
  }
}
