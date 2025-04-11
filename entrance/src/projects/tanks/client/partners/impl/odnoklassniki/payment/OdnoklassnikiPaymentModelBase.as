package projects.tanks.client.partners.impl.odnoklassniki.payment {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class OdnoklassnikiPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:OdnoklassnikiPaymentModelServer;

    private var client:IOdnoklassnikiPaymentModelBase = IOdnoklassnikiPaymentModelBase(this);
    private var modelId:Long = Long.getLong(1273864280,-1855777834);
    private var _receivePaymentTransactionId:Long = Long.getLong(801007651,-1207089136);
    private var _receivePaymentTransaction_shopOrderIdCodec:ICodec;
    private var _receivePaymentTransaction_descriptionCodec:ICodec;
    private var _receivePaymentTransaction_priceCodec:ICodec;

    public function OdnoklassnikiPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new OdnoklassnikiPaymentModelServer(IModel(this));
      this._receivePaymentTransaction_shopOrderIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._receivePaymentTransaction_descriptionCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._receivePaymentTransaction_priceCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receivePaymentTransactionId:
          this.client.receivePaymentTransaction(String(this._receivePaymentTransaction_shopOrderIdCodec.decode(param2)),String(this._receivePaymentTransaction_descriptionCodec.decode(param2)),String(this._receivePaymentTransaction_priceCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
