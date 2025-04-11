package _codec.projects.tanks.client.battlefield.models.user.tank.commands {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecMoveCommand implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_angularVelocity:ICodec;
    private var codec_control:ICodec;
    private var codec_linearVelocity:ICodec;
    private var codec_orientation:ICodec;
    private var codec_position:ICodec;
    private var codec_turnSpeedNumber:ICodec;

    public function CodecMoveCommand() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_angularVelocity = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_control = param1.getCodec(new TypeCodecInfo(Byte,false));
      this.codec_linearVelocity = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_orientation = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_turnSpeedNumber = param1.getCodec(new TypeCodecInfo(Byte,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:MoveCommand = new MoveCommand();
      local2.angularVelocity = this.codec_angularVelocity.decode(param1) as Vector3d;
      local2.control = this.codec_control.decode(param1) as int;
      local2.linearVelocity = this.codec_linearVelocity.decode(param1) as Vector3d;
      local2.orientation = this.codec_orientation.decode(param1) as Vector3d;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      local2.turnSpeedNumber = this.codec_turnSpeedNumber.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:MoveCommand = MoveCommand(param2);
      this.codec_angularVelocity.encode(param1,local3.angularVelocity);
      this.codec_control.encode(param1,local3.control);
      this.codec_linearVelocity.encode(param1,local3.linearVelocity);
      this.codec_orientation.encode(param1,local3.orientation);
      this.codec_position.encode(param1,local3.position);
      this.codec_turnSpeedNumber.encode(param1,local3.turnSpeedNumber);
    }
  }
}
