package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx {
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
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx.ArtillerySfxCC;

  public class CodecArtillerySfxCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_chargingSound:ICodec;
    private var codec_explosionSound:ICodec;
    private var codec_explosionTexture:ICodec;
    private var codec_farShotSound:ICodec;
    private var codec_flameTexture:ICodec;
    private var codec_flyBySound:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_markTexture:ICodec;
    private var codec_reloadSound:ICodec;
    private var codec_shot1Sound:ICodec;
    private var codec_shot2Sound:ICodec;
    private var codec_shot3Sound:ICodec;
    private var codec_shot4Sound:ICodec;
    private var codec_smokeTexture:ICodec;
    private var codec_streamTexture:ICodec;
    private var codec_trailTexture:ICodec;

    public function CodecArtillerySfxCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_chargingSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_explosionSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_farShotSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_flameTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_flyBySound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_markTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_reloadSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shot1Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shot2Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shot3Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_shot4Sound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_smokeTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_streamTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_trailTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ArtillerySfxCC = new ArtillerySfxCC();
      local2.chargingSound = this.codec_chargingSound.decode(param1) as SoundResource;
      local2.explosionSound = this.codec_explosionSound.decode(param1) as SoundResource;
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.farShotSound = this.codec_farShotSound.decode(param1) as SoundResource;
      local2.flameTexture = this.codec_flameTexture.decode(param1) as TextureResource;
      local2.flyBySound = this.codec_flyBySound.decode(param1) as SoundResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.markTexture = this.codec_markTexture.decode(param1) as TextureResource;
      local2.reloadSound = this.codec_reloadSound.decode(param1) as SoundResource;
      local2.shot1Sound = this.codec_shot1Sound.decode(param1) as SoundResource;
      local2.shot2Sound = this.codec_shot2Sound.decode(param1) as SoundResource;
      local2.shot3Sound = this.codec_shot3Sound.decode(param1) as SoundResource;
      local2.shot4Sound = this.codec_shot4Sound.decode(param1) as SoundResource;
      local2.smokeTexture = this.codec_smokeTexture.decode(param1) as MultiframeTextureResource;
      local2.streamTexture = this.codec_streamTexture.decode(param1) as TextureResource;
      local2.trailTexture = this.codec_trailTexture.decode(param1) as TextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ArtillerySfxCC = ArtillerySfxCC(param2);
      this.codec_chargingSound.encode(param1,local3.chargingSound);
      this.codec_explosionSound.encode(param1,local3.explosionSound);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_farShotSound.encode(param1,local3.farShotSound);
      this.codec_flameTexture.encode(param1,local3.flameTexture);
      this.codec_flyBySound.encode(param1,local3.flyBySound);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_markTexture.encode(param1,local3.markTexture);
      this.codec_reloadSound.encode(param1,local3.reloadSound);
      this.codec_shot1Sound.encode(param1,local3.shot1Sound);
      this.codec_shot2Sound.encode(param1,local3.shot2Sound);
      this.codec_shot3Sound.encode(param1,local3.shot3Sound);
      this.codec_shot4Sound.encode(param1,local3.shot4Sound);
      this.codec_smokeTexture.encode(param1,local3.smokeTexture);
      this.codec_streamTexture.encode(param1,local3.streamTexture);
      this.codec_trailTexture.encode(param1,local3.trailTexture);
    }
  }
}
