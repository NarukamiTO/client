package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.isis {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class CodecIsisSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_damagingBall:ICodec;
    private var codec_damagingRay:ICodec;
    private var codec_damagingSound:ICodec;
    private var codec_healingBall:ICodec;
    private var codec_healingRay:ICodec;
    private var codec_healingSound:ICodec;
    private var codec_idleSound:ICodec;
    private var codec_lightingSFXEntity:ICodec;

    public function CodecIsisSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_damagingBall = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_damagingRay = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_damagingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_healingBall = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_healingRay = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_healingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_idleSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:IsisSFXCC = new IsisSFXCC();
      local2.damagingBall = this.codec_damagingBall.decode(param1) as MultiframeTextureResource;
      local2.damagingRay = this.codec_damagingRay.decode(param1) as TextureResource;
      local2.damagingSound = this.codec_damagingSound.decode(param1) as SoundResource;
      local2.healingBall = this.codec_healingBall.decode(param1) as MultiframeTextureResource;
      local2.healingRay = this.codec_healingRay.decode(param1) as TextureResource;
      local2.healingSound = this.codec_healingSound.decode(param1) as SoundResource;
      local2.idleSound = this.codec_idleSound.decode(param1) as SoundResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:IsisSFXCC = IsisSFXCC(param2);
      this.codec_damagingBall.encode(param1,local3.damagingBall);
      this.codec_damagingRay.encode(param1,local3.damagingRay);
      this.codec_damagingSound.encode(param1,local3.damagingSound);
      this.codec_healingBall.encode(param1,local3.healingBall);
      this.codec_healingRay.encode(param1,local3.healingRay);
      this.codec_healingSound.encode(param1,local3.healingSound);
      this.codec_idleSound.encode(param1,local3.idleSound);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
    }
  }
}
