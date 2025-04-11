package _codec.projects.tanks.client.battlefield.models.user.spawn {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Short;
  import projects.tanks.client.battlefield.models.user.spawn.TankSpawnerCC;

  public class CodecTankSpawnerCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_incarnationId:ICodec;

    public function CodecTankSpawnerCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_incarnationId = param1.getCodec(new TypeCodecInfo(Short,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankSpawnerCC = new TankSpawnerCC();
      local2.incarnationId = this.codec_incarnationId.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankSpawnerCC = TankSpawnerCC(param2);
      this.codec_incarnationId.encode(param1,local3.incarnationId);
    }
  }
}
