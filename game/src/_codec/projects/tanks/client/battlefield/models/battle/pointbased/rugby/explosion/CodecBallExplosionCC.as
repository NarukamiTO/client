package _codec.projects.tanks.client.battlefield.models.battle.pointbased.rugby.explosion {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.explosion.BallExplosionCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class CodecBallExplosionCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_explosionSound:ICodec;
    private var codec_explosionTexture:ICodec;
    private var codec_lightingSFXEntity:ICodec;
    private var codec_smokeTextureId:ICodec;

    public function CodecBallExplosionCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_explosionSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_lightingSFXEntity = param1.getCodec(new TypeCodecInfo(LightingSFXEntity,false));
      this.codec_smokeTextureId = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:BallExplosionCC = new BallExplosionCC();
      local2.explosionSound = this.codec_explosionSound.decode(param1) as SoundResource;
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.lightingSFXEntity = this.codec_lightingSFXEntity.decode(param1) as LightingSFXEntity;
      local2.smokeTextureId = this.codec_smokeTextureId.decode(param1) as MultiframeTextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:BallExplosionCC = BallExplosionCC(param2);
      this.codec_explosionSound.encode(param1,local3.explosionSound);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_lightingSFXEntity.encode(param1,local3.lightingSFXEntity);
      this.codec_smokeTextureId.encode(param1,local3.smokeTextureId);
    }
  }
}
