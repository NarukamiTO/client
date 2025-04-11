package projects.tanks.client.entrance.model.entrance.clienthalt {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ServerHaltEntranceModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ServerHaltEntranceModelServer;

    private var client:IServerHaltEntranceModelBase = IServerHaltEntranceModelBase(this);
    private var modelId:Long = Long.getLong(946668342,813083086);
    private var _serverHaltId:Long = Long.getLong(1338714818,1184888981);

    public function ServerHaltEntranceModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ServerHaltEntranceModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ServerHaltEntranceCC,false)));
    }

    protected function getInitParam() : ServerHaltEntranceCC {
      return ServerHaltEntranceCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._serverHaltId:
          this.client.serverHalt();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
