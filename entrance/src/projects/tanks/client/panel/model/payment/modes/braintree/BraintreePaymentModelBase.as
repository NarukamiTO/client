package projects.tanks.client.panel.model.payment.modes.braintree {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class BraintreePaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:BraintreePaymentModelServer;

    private var client:IBraintreePaymentModelBase = IBraintreePaymentModelBase(this);
    private var modelId:Long = Long.getLong(176586390,-1429295990);
    private var _receiveUrlId:Long = Long.getLong(2063915763,-1081638167);
    private var _receiveUrl_urlCodec:ICodec;

    public function BraintreePaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new BraintreePaymentModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(BraintreePaymentCC,false)));
      this._receiveUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(PaymentRequestUrl,false));
    }

    protected function getInitParam() : BraintreePaymentCC {
      return BraintreePaymentCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receiveUrlId:
          this.client.receiveUrl(PaymentRequestUrl(this._receiveUrl_urlCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
