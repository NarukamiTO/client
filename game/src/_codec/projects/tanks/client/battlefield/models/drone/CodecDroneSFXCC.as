package _codec.projects.tanks.client.battlefield.models.drone {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.drone.DroneSFXCC;

  public class CodecDroneSFXCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_activationSound:ICodec;

    public function CodecDroneSFXCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_activationSound = param1.getCodec(new TypeCodecInfo(SoundResource,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DroneSFXCC = new DroneSFXCC();
      local2.activationSound = this.codec_activationSound.decode(param1) as SoundResource;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DroneSFXCC = DroneSFXCC(param2);
      this.codec_activationSound.encode(param1,local3.activationSound);
    }
  }
}
