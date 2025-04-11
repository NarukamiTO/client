package _codec.projects.tanks.client.battlefield.models.drone {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.drone.DroneIndicatorCC;

  public class CodecDroneIndicatorCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_batteryAmount:ICodec;
    private var codec_canOverheal:ICodec;
    private var codec_droneReady:ICodec;
    private var codec_timeToReloadMs:ICodec;

    public function CodecDroneIndicatorCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_batteryAmount = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_canOverheal = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_droneReady = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_timeToReloadMs = param1.getCodec(new TypeCodecInfo(int,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:DroneIndicatorCC = new DroneIndicatorCC();
      local2.batteryAmount = this.codec_batteryAmount.decode(param1) as int;
      local2.canOverheal = this.codec_canOverheal.decode(param1) as Boolean;
      local2.droneReady = this.codec_droneReady.decode(param1) as Boolean;
      local2.timeToReloadMs = this.codec_timeToReloadMs.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:DroneIndicatorCC = DroneIndicatorCC(param2);
      this.codec_batteryAmount.encode(param1,local3.batteryAmount);
      this.codec_canOverheal.encode(param1,local3.canOverheal);
      this.codec_droneReady.encode(param1,local3.droneReady);
      this.codec_timeToReloadMs.encode(param1,local3.timeToReloadMs);
    }
  }
}
