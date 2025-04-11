package platform.client.fp10.core.network.connection {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.types.Long;
  import platform.client.fp10.core.network.ICommandHandler;

  public class ConnectionInitializers {
    private var _protocol:IProtocol;
    private var _commandCodec:ICodec;
    private var _commandHandler:ICommandHandler;
    private var _secure:Boolean;
    private var _connectionId:Long;
    private var _protectionContext:IProtectionContext;

    public function ConnectionInitializers(param1:IProtocol, param2:ICodec, param3:ICommandHandler, param4:Boolean, param5:Long, param6:IProtectionContext) {
      super();
      this._protocol = param1;
      this._commandCodec = param2;
      this._commandHandler = param3;
      this._secure = param4;
      this._connectionId = param5;
      this._protectionContext = param6;
    }

    public function get protocol() : IProtocol {
      return this._protocol;
    }

    public function get commandCodec() : ICodec {
      return this._commandCodec;
    }

    public function get commandHandler() : ICommandHandler {
      return this._commandHandler;
    }

    public function get secure() : Boolean {
      return this._secure;
    }

    public function get protectionContext() : IProtectionContext {
      return this._protectionContext;
    }

    public function get connectionId() : Long {
      return this._connectionId;
    }
  }
}
