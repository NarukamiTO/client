package projects.tanks.client.panel.model.payment.modes.gotourl {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class GoToUrlPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:GoToUrlPaymentModelServer;

    private var client:IGoToUrlPaymentModelBase = IGoToUrlPaymentModelBase(this);
    private var modelId:Long = Long.getLong(662905925,-149486694);
    private var _receiveUrlId:Long = Long.getLong(1472761253,1269708281);
    private var _receiveUrl_urlCodec:ICodec;

    public function GoToUrlPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new GoToUrlPaymentModelServer(IModel(this));
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
