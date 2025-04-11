package _codec.projects.tanks.client.garage.models.item.drone {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.garage.models.item.drone.HasBatteriesNotifyCC;

  public class CodecHasBatteriesNotifyCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_hasBatteries:ICodec;

    public function CodecHasBatteriesNotifyCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_hasBatteries = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:HasBatteriesNotifyCC = new HasBatteriesNotifyCC();
      local2.hasBatteries = this.codec_hasBatteries.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:HasBatteriesNotifyCC = HasBatteriesNotifyCC(param2);
      this.codec_hasBatteries.encode(param1,local3.hasBatteries);
    }
  }
}
