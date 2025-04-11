package platform.client.fp10.core.protocol.codec {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Byte;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.network.command.ControlCommand;
  import platform.client.fp10.core.network.command.SpaceOpenedCommand;
  import platform.client.fp10.core.network.command.control.client.HashRequestCommandCodec;
  import platform.client.fp10.core.network.command.control.client.LogCommandCodec;
  import platform.client.fp10.core.network.command.control.server.HashResponseCommandCodec;
  import platform.client.fp10.core.network.command.control.server.OpenSpaceCommandCodec;

  public class ControlRootCodec implements ICodec {
    [Inject]
    public static var logService:LogService;

    private static var logger:Logger;

    private var byteCodec:ICodec;
    private var serverCommandCodecs:Dictionary = new Dictionary();
    private var clientCommandCodecs:Dictionary = new Dictionary();

    public function ControlRootCodec() {
      super();
    }

    private static function getLogger() : Logger {
      return logger || (logger = logService.getLogger("codec"));
    }

    public function init(param1:IProtocol) : void {
      this.byteCodec = param1.getCodec(new TypeCodecInfo(Byte,false));
      param1.registerCodec(new TypeCodecInfo(SpaceOpenedCommand,false),new SpaceOpenedCommandCodec());
      this.serverCommandCodecs[ControlCommand.SV_HASH_RESPONSE] = new HashResponseCommandCodec(param1);
      this.serverCommandCodecs[ControlCommand.SV_OPEN_SPACE] = new OpenSpaceCommandCodec(param1);
      this.clientCommandCodecs[ControlCommand.CL_HASH_REQUEST] = new HashRequestCommandCodec(param1);
      this.clientCommandCodecs[ControlCommand.CL_LOG] = new LogCommandCodec(param1);
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      var local3:ControlCommand = ControlCommand(param2);
      this.byteCodec.encode(param1,local3.id);
      var local4:ICodec = this.clientCommandCodecs[local3.id];
      if(local4 != null) {
        local4.encode(param1,param2);
      }
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:int = int(this.byteCodec.decode(param1));
      var local3:ICodec = this.serverCommandCodecs[local2];
      if(local3 == null) {
        getLogger().error("ControlRootCodec::doDecode() No codec found for command id=" + local2);
        return null;
      }
      return local3.decode(param1);
    }
  }
}
