package projects.tanks.client.panel.model.premiumaccount.alert {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class PremiumAccountAlertModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PremiumAccountAlertModelServer;

    private var client:IPremiumAccountAlertModelBase = IPremiumAccountAlertModelBase(this);
    private var modelId:Long = Long.getLong(287111968,-1381886380);
    private var _showWelcomeAlertId:Long = Long.getLong(167154466,288991176);
    private var _showWelcomeAlert_wasShowAlertForFirstPurchasePremiumCodec:ICodec;

    public function PremiumAccountAlertModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PremiumAccountAlertModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(PremiumAccountAlertCC,false)));
      this._showWelcomeAlert_wasShowAlertForFirstPurchasePremiumCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    protected function getInitParam() : PremiumAccountAlertCC {
      return PremiumAccountAlertCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showWelcomeAlertId:
          this.client.showWelcomeAlert(Boolean(this._showWelcomeAlert_wasShowAlertForFirstPurchasePremiumCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
