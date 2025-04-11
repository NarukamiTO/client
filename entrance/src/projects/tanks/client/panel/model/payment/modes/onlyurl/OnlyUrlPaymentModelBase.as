package projects.tanks.client.panel.model.payment.modes.onlyurl {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class OnlyUrlPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:OnlyUrlPaymentModelServer;

    private var client:IOnlyUrlPaymentModelBase = IOnlyUrlPaymentModelBase(this);
    private var modelId:Long = Long.getLong(969748537,-1870265676);
    private var _receiveUrlId:Long = Long.getLong(698903513,383981781);
    private var _receiveUrl_urlCodec:ICodec;

    public function OnlyUrlPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new OnlyUrlPaymentModelServer(IModel(this));
      this._receiveUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(PaymentRequestUrl,false));
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
