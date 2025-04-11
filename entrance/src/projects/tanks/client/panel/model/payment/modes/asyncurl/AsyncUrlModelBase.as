package projects.tanks.client.panel.model.payment.modes.asyncurl {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class AsyncUrlModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AsyncUrlModelServer;

    private var client:IAsyncUrlModelBase = IAsyncUrlModelBase(this);
    private var modelId:Long = Long.getLong(963439945,1016496094);
    private var _receiveUrlId:Long = Long.getLong(332392596,-133650115);
    private var _receiveUrl_urlCodec:ICodec;
    private var _showErrorUrlReceivedId:Long = Long.getLong(1900905132,-1959809828);

    public function AsyncUrlModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AsyncUrlModelServer(IModel(this));
      this._receiveUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(PaymentRequestUrl,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receiveUrlId:
          this.client.receiveUrl(PaymentRequestUrl(this._receiveUrl_urlCodec.decode(param2)));
          break;
        case this._showErrorUrlReceivedId:
          this.client.showErrorUrlReceived();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
