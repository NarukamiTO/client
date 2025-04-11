package _codec.projects.tanks.client.battlefield.models.tankparts.weapons.common.shell {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellHit;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellState;

  public class CodecShellHit implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_shotId:ICodec;
    private var codec_states:ICodec;
    private var codec_targets:ICodec;

    public function CodecShellHit() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_shotId = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_states = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(ShellState,false),false,1));
      this.codec_targets = param1.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TargetPosition,false),false,1));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:ShellHit = new ShellHit();
      local2.shotId = this.codec_shotId.decode(param1) as int;
      local2.states = this.codec_states.decode(param1) as Vector.<ShellState>;
      local2.targets = this.codec_targets.decode(param1) as Vector.<TargetPosition>;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:ShellHit = ShellHit(param2);
      this.codec_shotId.encode(param1,local3.shotId);
      this.codec_states.encode(param1,local3.states);
      this.codec_targets.encode(param1,local3.targets);
    }
  }
}
