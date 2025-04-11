package projects.tanks.client.partners.impl.vkontakte {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class VkontaktePaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:VkontaktePaymentModelServer;

    private var client:IVkontaktePaymentModelBase = IVkontaktePaymentModelBase(this);
    private var modelId:Long = Long.getLong(982237961,270527442);
    private var _receivePaymentTransactionId:Long = Long.getLong(780155353,1879122584);
    private var _receivePaymentTransaction_transactionIdCodec:ICodec;

    public function VkontaktePaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new VkontaktePaymentModelServer(IModel(this));
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
