package projects.tanks.client.panel.model.usercountry {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class UserCountryModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UserCountryModelServer;

    private var client:IUserCountryModelBase = IUserCountryModelBase(this);
    private var modelId:Long = Long.getLong(484417400,-1976122270);
    private var _requestUserCountryId:Long = Long.getLong(1625272162,1958733747);
    private var _requestUserCountry_defaultCountryCodeCodec:ICodec;
    private var _showPaymentWindowId:Long = Long.getLong(432115653,1756131906);

    public function UserCountryModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UserCountryModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UserCountryCC,false)));
      this._requestUserCountry_defaultCountryCodeCodec = this._protocol.getCodec(new TypeCodecInfo(String,true));
    }

    protected function getInitParam() : UserCountryCC {
      return UserCountryCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._requestUserCountryId:
          this.client.requestUserCountry(String(this._requestUserCountry_defaultCountryCodeCodec.decode(param2)));
          break;
        case this._showPaymentWindowId:
          this.client.showPaymentWindow();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
