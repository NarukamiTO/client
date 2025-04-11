package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder {
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
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
  import projects.tanks.client.battlefield.models.tankparts.sfx.shoot.thunder.ThunderShootSFXCC;

  public class CodecThunderShootSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_explosionMarkTexture:ICodec;
    private var codec_explosionSize:ICodec;
    private var codec_explosionSound:ICodec;
    private var codec_explosionTexture:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_shotSound:ICodec;
    private var codec_shotTexture:ICodec;

    public function CodecThunderShootSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_explosionMarkTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_explosionSize = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_explosionSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_shotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shotTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ThunderShootSFXCC = new ThunderShootSFXCC();
      local2.explosionMarkTexture = this.codec_explosionMarkTexture.decode(param1) as TextureResource;
      local2.explosionSize = this.codec_explosionSize.decode(param1) as Number;
      local2.explosionSound = this.codec_explosionSound.decode(param1) as SoundResource;
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.shotSound = this.codec_shotSound.decode(param1) as SoundResource;
      local2.shotTexture = this.codec_shotTexture.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ThunderShootSFXCC = ThunderShootSFXCC(param2);
      this.codec_explosionMarkTexture.encode(param1,local3.explosionMarkTexture);
      this.codec_explosionSize.encode(param1,local3.explosionSize);
      this.codec_explosionSound.encode(param1,local3.explosionSound);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_shotSound.encode(param1,local3.shotSound);
      this.codec_shotTexture.encode(param1,local3.shotTexture);
    }
  }
}
