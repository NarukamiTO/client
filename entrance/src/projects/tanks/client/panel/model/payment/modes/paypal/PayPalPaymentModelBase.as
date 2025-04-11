package projects.tanks.client.panel.model.payment.modes.paypal {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class PayPalPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PayPalPaymentModelServer;

    private var client:IPayPalPaymentModelBase = IPayPalPaymentModelBase(this);
    private var modelId:Long = Long.getLong(111164588,-1792267498);
    private var _receiveErrorUrlId:Long = Long.getLong(102939338,2503765);
    private var _receiveErrorUrl_urlCodec:ICodec;
    private var _receivePaymentUrlId:Long = Long.getLong(140391626,-1874835949);
    private var _receivePaymentUrl_urlCodec:ICodec;

    public function PayPalPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PayPalPaymentModelServer(IModel(this));
      this._receiveErrorUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(PaymentRequestUrl,false));
      this._receivePaymentUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(PaymentRequestUrl,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receiveErrorUrlId:
          this.client.receiveErrorUrl(PaymentRequestUrl(this._receiveErrorUrl_urlCodec.decode(param2)));
          break;
        case this._receivePaymentUrlId:
          this.client.receivePaymentUrl(PaymentRequestUrl(this._receivePaymentUrl_urlCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
