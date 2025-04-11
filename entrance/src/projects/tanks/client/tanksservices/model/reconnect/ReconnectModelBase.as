package projects.tanks.client.tanksservices.model.reconnect {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ReconnectModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ReconnectModelServer;

    private var client:IReconnectModelBase = IReconnectModelBase(this);
    private var modelId:Long = Long.getLong(1511581132,-1911657689);
    private var _reconnectFastId:Long = Long.getLong(1048793908,1208118313);
    private var _reconnectFast_remoteEndpointDataCodec:ICodec;
    private var _serverReadyToReconnectId:Long = Long.getLong(1752522899,-540791768);
    private var _setSingleEntranceHashId:Long = Long.getLong(1594746948,-1573293870);
    private var _setSingleEntranceHash_hashCodec:ICodec;

    public function ReconnectModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ReconnectModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ReconnectCC,false)));
      this._reconnectFast_remoteEndpointDataCodec = this._protocol.getCodec(new TypeCodecInfo(RemoteEndpointData,false));
      this._setSingleEntranceHash_hashCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : ReconnectCC {
      return ReconnectCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._reconnectFastId:
          this.client.reconnectFast(RemoteEndpointData(this._reconnectFast_remoteEndpointDataCodec.decode(param2)));
          break;
        case this._serverReadyToReconnectId:
          this.client.serverReadyToReconnect();
          break;
        case this._setSingleEntranceHashId:
          this.client.setSingleEntranceHash(String(this._setSingleEntranceHash_hashCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
