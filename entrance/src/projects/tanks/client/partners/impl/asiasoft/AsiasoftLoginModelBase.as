package projects.tanks.client.partners.impl.asiasoft {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class AsiasoftLoginModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AsiasoftLoginModelServer;

    private var client:IAsiasoftLoginModelBase = IAsiasoftLoginModelBase(this);
    private var modelId:Long = Long.getLong(207007060,1485489233);
    private var _gotoInitialUrlId:Long = Long.getLong(341705782,434846708);
    private var _gotoUrlId:Long = Long.getLong(1221568909,812989734);
    private var _gotoUrl_urlCodec:ICodec;

    public function AsiasoftLoginModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AsiasoftLoginModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(AsiasoftLoginCC,false)));
      this._gotoUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : AsiasoftLoginCC {
      return AsiasoftLoginCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._gotoInitialUrlId:
          this.client.gotoInitialUrl();
          break;
        case this._gotoUrlId:
          this.client.gotoUrl(String(this._gotoUrl_urlCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
