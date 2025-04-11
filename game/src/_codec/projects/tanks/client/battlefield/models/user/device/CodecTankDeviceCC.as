package _codec.projects.tanks.client.battlefield.models.user.device {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.user.device.TankDeviceCC;

  public class CodecTankDeviceCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_deviceId:ICodec;

    public function CodecTankDeviceCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_deviceId = param1.getCodec(new TypeCodecInfo(Long,true));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankDeviceCC = new TankDeviceCC();
      local2.deviceId = this.codec_deviceId.decode(param1) as Long;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankDeviceCC = TankDeviceCC(param2);
      this.codec_deviceId.encode(param1,local3.deviceId);
    }
  }
}
