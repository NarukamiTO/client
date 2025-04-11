package projects.tanks.client.partners.impl.facebook.payment {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class FacebookPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:FacebookPaymentModelServer;

    private var client:IFacebookPaymentModelBase = IFacebookPaymentModelBase(this);
    private var modelId:Long = Long.getLong(698539894,1283037116);
    private var _receivePaymentTransactionId:Long = Long.getLong(10593173,209532726);
    private var _receivePaymentTransaction_shopItemIdCodec:ICodec;
    private var _receivePaymentTransaction_transactionIdCodec:ICodec;

    public function FacebookPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new FacebookPaymentModelServer(IModel(this));
      this._receivePaymentTransaction_shopItemIdCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
      this._receivePaymentTransaction_transactionIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receivePaymentTransactionId:
          this.client.receivePaymentTransaction(Long(this._receivePaymentTransaction_shopItemIdCodec.decode(param2)),String(this._receivePaymentTransaction_transactionIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
