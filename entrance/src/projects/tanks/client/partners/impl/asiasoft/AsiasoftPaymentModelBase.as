package projects.tanks.client.partners.impl.asiasoft {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class AsiasoftPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AsiasoftPaymentModelServer;

    private var client:IAsiasoftPaymentModelBase = IAsiasoftPaymentModelBase(this);
    private var modelId:Long = Long.getLong(1386392731,192355220);
    private var _proceedToPaymentId:Long = Long.getLong(890493454,-1969693338);
    private var _showAccountBalanceId:Long = Long.getLong(710462738,-568001163);
    private var _showAccountBalance_amountInAtcCodec:ICodec;
    private var _showAccountBalance_enoughMoneyCodec:ICodec;

    public function AsiasoftPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AsiasoftPaymentModelServer(IModel(this));
      this._showAccountBalance_amountInAtcCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._showAccountBalance_enoughMoneyCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._proceedToPaymentId:
          this.client.proceedToPayment();
          break;
        case this._showAccountBalanceId:
          this.client.showAccountBalance(int(this._showAccountBalance_amountInAtcCodec.decode(param2)),Boolean(this._showAccountBalance_enoughMoneyCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
