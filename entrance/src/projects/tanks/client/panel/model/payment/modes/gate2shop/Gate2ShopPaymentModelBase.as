package projects.tanks.client.panel.model.payment.modes.gate2shop {
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

  public class Gate2ShopPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:Gate2ShopPaymentModelServer;

    private var client:IGate2ShopPaymentModelBase = IGate2ShopPaymentModelBase(this);
    private var modelId:Long = Long.getLong(1004681856,-270220968);
    private var _receiveUrlId:Long = Long.getLong(1018287029,-103071689);
    private var _receiveUrl_urlCodec:ICodec;
    private var _showEmailIsBusyId:Long = Long.getLong(996435325,2910117);
    private var _showEmailIsBusy_emailCodec:ICodec;
    private var _showEmailIsForbiddenId:Long = Long.getLong(1910558556,-1549323827);
    private var _showEmailIsForbidden_emailCodec:ICodec;
    private var _showEmailIsFreeId:Long = Long.getLong(996435325,3025944);
    private var _showEmailIsFree_emailCodec:ICodec;

    public function Gate2ShopPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new Gate2ShopPaymentModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(Gate2ShopPaymentCC,false)));
      this._receiveUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(PaymentRequestUrl,false));
      this._showEmailIsBusy_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showEmailIsForbidden_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showEmailIsFree_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : Gate2ShopPaymentCC {
      return Gate2ShopPaymentCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receiveUrlId:
          this.client.receiveUrl(PaymentRequestUrl(this._receiveUrl_urlCodec.decode(param2)));
          break;
        case this._showEmailIsBusyId:
          this.client.showEmailIsBusy(String(this._showEmailIsBusy_emailCodec.decode(param2)));
          break;
        case this._showEmailIsForbiddenId:
          this.client.showEmailIsForbidden(String(this._showEmailIsForbidden_emailCodec.decode(param2)));
          break;
        case this._showEmailIsFreeId:
          this.client.showEmailIsFree(String(this._showEmailIsFree_emailCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
