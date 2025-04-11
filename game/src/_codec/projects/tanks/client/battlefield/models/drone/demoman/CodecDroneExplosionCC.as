package _codec.projects.tanks.client.battlefield.models.drone.demoman {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.drone.demoman.DroneExplosionCC;

  public class CodecDroneExplosionCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_explosionTexture:ICodec;

    public function CodecDroneExplosionCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_explosionTexture = param1.getCodec(new TypeCodecInfo(MultiframeTextureResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DroneExplosionCC = new DroneExplosionCC();
      local2.explosionTexture = this.codec_explosionTexture.decode(param1) as MultiframeTextureResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DroneExplosionCC = DroneExplosionCC(param2);
      this.codec_explosionTexture.encode(param1,local3.explosionTexture);
    }
  }
}
