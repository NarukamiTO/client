package projects.tanks.client.panel.model.payment.modes.platbox {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class PlatBoxPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PlatBoxPaymentModelServer;

    private var client:IPlatBoxPaymentModelBase = IPlatBoxPaymentModelBase(this);
    private var modelId:Long = Long.getLong(1738044130,-258469210);
    private var _paymentErrorId:Long = Long.getLong(907995372,2081080733);
    private var _paymentInitedId:Long = Long.getLong(1916914524,-199552186);
    private var _phoneIsInvalidId:Long = Long.getLong(1929960861,1764460250);
    private var _phoneIsInvalid_phoneCodec:ICodec;
    private var _phoneIsValidId:Long = Long.getLong(909269845,-241303137);
    private var _phoneIsValid_phoneCodec:ICodec;

    public function PlatBoxPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PlatBoxPaymentModelServer(IModel(this));
      this._phoneIsInvalid_phoneCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._phoneIsValid_phoneCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._paymentErrorId:
          this.client.paymentError();
          break;
        case this._paymentInitedId:
          this.client.paymentInited();
          break;
        case this._phoneIsInvalidId:
          this.client.phoneIsInvalid(String(this._phoneIsInvalid_phoneCodec.decode(param2)));
          break;
        case this._phoneIsValidId:
          this.client.phoneIsValid(String(this._phoneIsValid_phoneCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
