package projects.tanks.client.partners.impl.kongregate {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class KongregatePaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:KongregatePaymentModelServer;

    private var client:IKongregatePaymentModelBase = IKongregatePaymentModelBase(this);
    private var modelId:Long = Long.getLong(1215969521,1635618100);
    private var _receivePaymentTransactionId:Long = Long.getLong(885983582,663395758);
    private var _receivePaymentTransaction_transactionIdCodec:ICodec;

    public function KongregatePaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new KongregatePaymentModelServer(IModel(this));
      this._receivePaymentTransaction_transactionIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receivePaymentTransactionId:
          this.client.receivePaymentTransaction(String(this._receivePaymentTransaction_transactionIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
