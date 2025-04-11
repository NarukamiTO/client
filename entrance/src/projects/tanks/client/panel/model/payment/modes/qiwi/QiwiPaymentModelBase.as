package projects.tanks.client.panel.model.payment.modes.qiwi {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class QiwiPaymentModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:QiwiPaymentModelServer;

    private var client:IQiwiPaymentModelBase = IQiwiPaymentModelBase(this);
    private var modelId:Long = Long.getLong(1394146469,-1218623146);
    private var _errorId:Long = Long.getLong(151939955,1064142569);
    private var _receiveUrlId:Long = Long.getLong(890818873,-1142094667);
    private var _receiveUrl_urlCodec:ICodec;

    public function QiwiPaymentModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new QiwiPaymentModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(QiwiPaymentCC,false)));
      this._receiveUrl_urlCodec = this._protocol.getCodec(new TypeCodecInfo(PaymentRequestUrl,false));
    }

    protected function getInitParam() : QiwiPaymentCC {
      return QiwiPaymentCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._errorId:
          this.client.error();
          break;
        case this._receiveUrlId:
          this.client.receiveUrl(PaymentRequestUrl(this._receiveUrl_urlCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
