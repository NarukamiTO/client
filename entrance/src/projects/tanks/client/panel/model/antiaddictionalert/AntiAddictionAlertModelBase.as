package projects.tanks.client.panel.model.antiaddictionalert {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class AntiAddictionAlertModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:AntiAddictionAlertModelServer;

    private var client:IAntiAddictionAlertModelBase = IAntiAddictionAlertModelBase(this);
    private var modelId:Long = Long.getLong(804749612,407465188);
    private var _realNameAndIDNumberSetErrorId:Long = Long.getLong(854492463,-1622748313);
    private var _realNameAndIDNumberSetError_errorMessageCodec:ICodec;
    private var _realNameAndIDNumberSetSuccesfullyId:Long = Long.getLong(1015957462,728524153);
    private var _realNameAndIDNumberSetSuccesfully_messageCodec:ICodec;
    private var _showAntiAddictionAlertId:Long = Long.getLong(548141647,-56956003);
    private var _showAntiAddictionAlert_minutesPlayedTodayCodec:ICodec;
    private var _showAntiAddictionAlert_isCurrentIDNumberCorrectCodec:ICodec;

    public function AntiAddictionAlertModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new AntiAddictionAlertModelServer(IModel(this));
      this._realNameAndIDNumberSetError_errorMessageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._realNameAndIDNumberSetSuccesfully_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._showAntiAddictionAlert_minutesPlayedTodayCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._showAntiAddictionAlert_isCurrentIDNumberCorrectCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._realNameAndIDNumberSetErrorId:
          this.client.realNameAndIDNumberSetError(String(this._realNameAndIDNumberSetError_errorMessageCodec.decode(param2)));
          break;
        case this._realNameAndIDNumberSetSuccesfullyId:
          this.client.realNameAndIDNumberSetSuccesfully(String(this._realNameAndIDNumberSetSuccesfully_messageCodec.decode(param2)));
          break;
        case this._showAntiAddictionAlertId:
          this.client.showAntiAddictionAlert(int(this._showAntiAddictionAlert_minutesPlayedTodayCodec.decode(param2)),Boolean(this._showAntiAddictionAlert_isCurrentIDNumberCorrectCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
