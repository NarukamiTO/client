package _codec.projects.tanks.client.battlefield.models.tankparts.sfx.firebird {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.firebird.FlameThrowingSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class CodecFlameThrowingSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_buffedFireSparksTexture:ICodec;
    private var codec_fireTexture:ICodec;
    private var codec_flameSound:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_muzzlePlaneTexture:ICodec;

    public function CodecFlameThrowingSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_buffedFireSparksTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_fireTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_flameSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_muzzlePlaneTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:FlameThrowingSFXCC = new FlameThrowingSFXCC();
      local2.buffedFireSparksTexture = this.codec_buffedFireSparksTexture.decode(param1) as TextureResource;
      local2.fireTexture = this.codec_fireTexture.decode(param1) as MultiframeTextureResource;
      local2.flameSound = this.codec_flameSound.decode(param1) as SoundResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.muzzlePlaneTexture = this.codec_muzzlePlaneTexture.decode(param1) as MultiframeTextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:FlameThrowingSFXCC = FlameThrowingSFXCC(param2);
      this.codec_buffedFireSparksTexture.encode(param1,local3.buffedFireSparksTexture);
      this.codec_fireTexture.encode(param1,local3.fireTexture);
      this.codec_flameSound.encode(param1,local3.flameSound);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_muzzlePlaneTexture.encode(param1,local3.muzzlePlaneTexture);
    }
  }
}
