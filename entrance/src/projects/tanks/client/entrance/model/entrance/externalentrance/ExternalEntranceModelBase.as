package projects.tanks.client.entrance.model.entrance.externalentrance {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ExternalEntranceModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ExternalEntranceModelServer;

    private var client:IExternalEntranceModelBase = IExternalEntranceModelBase(this);
    private var modelId:Long = Long.getLong(108568170,1674173608);
    private var _linkAlreadyExistsId:Long = Long.getLong(440559406,964760605);
    private var _validationFailedId:Long = Long.getLong(1703558387,-1533773165);
    private var _validationSuccessId:Long = Long.getLong(1270702467,-1082907539);
    private var _wrongPasswordId:Long = Long.getLong(914150414,-1180956683);

    public function ExternalEntranceModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ExternalEntranceModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ExternalEntranceCC,false)));
    }

    protected function getInitParam() : ExternalEntranceCC {
      return ExternalEntranceCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._linkAlreadyExistsId:
          this.client.linkAlreadyExists();
          break;
        case this._validationFailedId:
          this.client.validationFailed();
          break;
        case this._validationSuccessId:
          this.client.validationSuccess();
          break;
        case this._wrongPasswordId:
          this.client.wrongPassword();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
