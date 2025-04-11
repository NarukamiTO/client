package projects.tanks.client.partners.impl.mailru.payment {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MailruGamesPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MailruGamesPaymentModelServer;

    private var client:IMailruGamesPaymentModelBase = IMailruGamesPaymentModelBase(this);
    private var modelId:Long = Long.getLong(588118997,-1972708299);
    private var _receivePaymentTransactionId:Long = Long.getLong(418477357,1914357093);
    private var _receivePaymentTransaction_orderIdCodec:ICodec;
    private var _receivePaymentTransaction_priceCodec:ICodec;
    private var _receivePaymentTransaction_descriptionCodec:ICodec;

    public function MailruGamesPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MailruGamesPaymentModelServer(IModel(this));
      this._receivePaymentTransaction_orderIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._receivePaymentTransaction_priceCodec = this._protocol.getCodec(new TypeCodecInfo(Number,false));
      this._receivePaymentTransaction_descriptionCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receivePaymentTransactionId:
          this.client.receivePaymentTransaction(String(this._receivePaymentTransaction_orderIdCodec.decode(param2)),Number(this._receivePaymentTransaction_priceCodec.decode(param2)),String(this._receivePaymentTransaction_descriptionCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
