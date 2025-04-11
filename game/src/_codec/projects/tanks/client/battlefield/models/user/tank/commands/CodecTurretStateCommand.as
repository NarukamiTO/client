package _codec.projects.tanks.client.battlefield.models.user.tank.commands {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import alternativa.types.Float;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretControlType;
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  public class CodecTurretStateCommand implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_controlInput:ICodec;
    private var codec_controlType:ICodec;
    private var codec_direction:ICodec;
    private var codec_rotationSpeedNumber:ICodec;

    public function CodecTurretStateCommand() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_controlInput = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_controlType = param1.getCodec(new EnumCodecInfo(TurretControlType,false));
      this.codec_direction = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_rotationSpeedNumber = param1.getCodec(new TypeCodecInfo(Byte,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:TurretStateCommand = new TurretStateCommand();
      local2.controlInput = this.codec_controlInput.decode(param1) as Number;
      local2.controlType = this.codec_controlType.decode(param1) as TurretControlType;
      local2.direction = this.codec_direction.decode(param1) as Number;
      local2.rotationSpeedNumber = this.codec_rotationSpeedNumber.decode(param1) as int;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:TurretStateCommand = TurretStateCommand(param2);
      this.codec_controlInput.encode(param1,local3.controlInput);
      this.codec_controlType.encode(param1,local3.controlType);
      this.codec_direction.encode(param1,local3.direction);
      this.codec_rotationSpeedNumber.encode(param1,local3.rotationSpeedNumber);
    }
  }
}
