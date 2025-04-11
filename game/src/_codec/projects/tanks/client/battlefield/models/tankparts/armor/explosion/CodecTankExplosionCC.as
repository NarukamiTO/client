package _codec.projects.tanks.client.battlefield.models.tankparts.armor.explosion {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.tankparts.armor.explosion.TankExplosionCC;

  public class CodecTankExplosionCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_explosionTexture:ICodec;
    private var codec_shockWaveTexture:ICodec;
    private var codec_smokeTextureId:ICodec;

    public function CodecTankExplosionCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_shockWaveTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
      this.codec_smokeTextureId = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankExplosionCC = new TankExplosionCC();
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      local2.shockWaveTexture = this.codec_shockWaveTexture.decode(param1) as MultiframeTextureResource;
      local2.smokeTextureId = this.codec_smokeTextureId.decode(param1) as MultiframeTextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankExplosionCC = TankExplosionCC(param2);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
      this.codec_shockWaveTexture.encode(param1,local3.shockWaveTexture);
      this.codec_smokeTextureId.encode(param1,local3.smokeTextureId);
    }
  }
}
