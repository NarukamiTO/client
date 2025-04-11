package _codec.projects.tanks.client.battlefield.types {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import projects.tanks.client.battlefield.types.TankState;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecTankState implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_angularVelocity:ICodec;
    private var codec_chassisControl:ICodec;
    private var codec_chassisTurnSpeedNumber:ICodec;
    private var codec_linearVelocity:ICodec;
    private var codec_orientation:ICodec;
    private var codec_position:ICodec;

    public function CodecTankState() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_angularVelocity = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_chassisControl = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_chassisTurnSpeedNumber = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_linearVelocity = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_orientation = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TankState = new TankState();
      local2.angularVelocity = this.codec_angularVelocity.decode(param1) as Vector3d;
      local2.chassisControl = this.codec_chassisControl.decode(param1) as int;
      local2.chassisTurnSpeedNumber = this.codec_chassisTurnSpeedNumber.decode(param1) as int;
      local2.linearVelocity = this.codec_linearVelocity.decode(param1) as Vector3d;
      local2.orientation = this.codec_orientation.decode(param1) as Vector3d;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TankState = TankState(param2);
      this.codec_angularVelocity.encode(param1,local3.angularVelocity);
      this.codec_chassisControl.encode(param1,local3.chassisControl);
      this.codec_chassisTurnSpeedNumber.encode(param1,local3.chassisTurnSpeedNumber);
      this.codec_linearVelocity.encode(param1,local3.linearVelocity);
      this.codec_orientation.encode(param1,local3.orientation);
      this.codec_position.encode(param1,local3.position);
    }
  }
}
