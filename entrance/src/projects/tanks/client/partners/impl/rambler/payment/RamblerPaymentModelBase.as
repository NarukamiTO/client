package projects.tanks.client.partners.impl.rambler.payment {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class RamblerPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RamblerPaymentModelServer;

    private var client:IRamblerPaymentModelBase = IRamblerPaymentModelBase(this);
    private var modelId:Long = Long.getLong(723546009,-53480122);
    private var _receivePaymentTransactionId:Long = Long.getLong(47453348,912731532);
    private var _receivePaymentTransaction_transactionIdCodec:ICodec;

    public function RamblerPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RamblerPaymentModelServer(IModel(this));
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
