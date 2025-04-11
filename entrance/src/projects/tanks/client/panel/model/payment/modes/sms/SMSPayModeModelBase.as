package projects.tanks.client.panel.model.payment.modes.sms {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSNumber;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSOperator;

  public class SMSPayModeModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:SMSPayModeModelServer;

    private var client:ISMSPayModeModelBase = ISMSPayModeModelBase(this);
    private var modelId:Long = Long.getLong(1938293825,420250171);
    private var _setNumbersId:Long = Long.getLong(726846280,221663080);
    private var _setNumbers_smsNumbersCodec:ICodec;
    private var _setOperatorsId:Long = Long.getLong(1580394283,1742910237);
    private var _setOperators_operatorsCodec:ICodec;

    public function SMSPayModeModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new SMSPayModeModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(SMSPayModeCC,false)));
      this._setNumbers_smsNumbersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(SMSNumber,false),false,1));
      this._setOperators_operatorsCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(SMSOperator,false),false,1));
    }

    protected function getInitParam() : SMSPayModeCC {
      return SMSPayModeCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setNumbersId:
          this.client.setNumbers(this._setNumbers_smsNumbersCodec.decode(param2) as Vector.<SMSNumber>);
          break;
        case this._setOperatorsId:
          this.client.setOperators(this._setOperators_operatorsCodec.decode(param2) as Vector.<SMSOperator>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
