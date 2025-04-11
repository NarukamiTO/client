package projects.tanks.client.partners.impl.miniplay {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class MiniplayPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:MiniplayPaymentModelServer;

    private var client:IMiniplayPaymentModelBase = IMiniplayPaymentModelBase(this);
    private var modelId:Long = Long.getLong(922991279,696481140);
    private var _receivePaymentDataId:Long = Long.getLong(1973287099,901106954);
    private var _receivePaymentData_priceCodec:ICodec;
    private var _receivePaymentData_descriptionCodec:ICodec;
    private var _receivePaymentData_orderIdCodec:ICodec;
    private var _receivePaymentData_signCodec:ICodec;

    public function MiniplayPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new MiniplayPaymentModelServer(IModel(this));
      this._receivePaymentData_priceCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._receivePaymentData_descriptionCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._receivePaymentData_orderIdCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._receivePaymentData_signCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._receivePaymentDataId:
          this.client.receivePaymentData(int(this._receivePaymentData_priceCodec.decode(param2)),String(this._receivePaymentData_descriptionCodec.decode(param2)),String(this._receivePaymentData_orderIdCodec.decode(param2)),String(this._receivePaymentData_signCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
