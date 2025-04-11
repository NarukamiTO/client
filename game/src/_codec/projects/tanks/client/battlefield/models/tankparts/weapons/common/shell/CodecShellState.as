package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.common.shell {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellState;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class CodecShellState implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_clientTime:ICodec;
    private var codec_direction:ICodec;
    private var codec_position:ICodec;

    public function CodecShellState() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_clientTime = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_direction = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShellState = new ShellState();
      local2.clientTime = this.codec_clientTime.decode(param1) as int;
      local2.direction = this.codec_direction.decode(param1) as Vector3d;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShellState = ShellState(param2);
      this.codec_clientTime.encode(param1,local3.clientTime);
      this.codec_direction.encode(param1,local3.direction);
      this.codec_position.encode(param1,local3.position);
    }
  }
}
