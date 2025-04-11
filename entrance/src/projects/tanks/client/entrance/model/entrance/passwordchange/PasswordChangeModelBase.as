package projects.tanks.client.entrance.model.entrance.passwordchange {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class PasswordChangeModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:PasswordChangeModelServer;

    private var client:IPasswordChangeModelBase = IPasswordChangeModelBase(this);
    private var modelId:Long = Long.getLong(2144135680,-1866277160);
    private var _emailNotFoundId:Long = Long.getLong(974405304,-587001778);
    private var _emailWithRestoreLinkSuccessfullySentId:Long = Long.getLong(2039498789,445465022);
    private var _passwordRecoveryHashCorrectId:Long = Long.getLong(242182652,2008805615);
    private var _passwordRecoveryHashCorrect_currentEmailCodec:ICodec;
    private var _passwordRecoveryHashWrongId:Long = Long.getLong(2123154680,-824044686);
    private var _setPasswordChangeResultId:Long = Long.getLong(802687056,1066036723);
    private var _setPasswordChangeResult_successCodec:ICodec;
    private var _setPasswordChangeResult_errorCodec:ICodec;

    public function PasswordChangeModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new PasswordChangeModelServer(IModel(this));
      this._passwordRecoveryHashCorrect_currentEmailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._setPasswordChangeResult_successCodec = this._protocol.getCodec(new TypeCodecInfo(Boolean,false));
      this._setPasswordChangeResult_errorCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._emailNotFoundId:
          this.client.emailNotFound();
          break;
        case this._emailWithRestoreLinkSuccessfullySentId:
          this.client.emailWithRestoreLinkSuccessfullySent();
          break;
        case this._passwordRecoveryHashCorrectId:
          this.client.passwordRecoveryHashCorrect(String(this._passwordRecoveryHashCorrect_currentEmailCodec.decode(param2)));
          break;
        case this._passwordRecoveryHashWrongId:
          this.client.passwordRecoveryHashWrong();
          break;
        case this._setPasswordChangeResultId:
          this.client.setPasswordChangeResult(Boolean(this._setPasswordChangeResult_successCodec.decode(param2)),String(this._setPasswordChangeResult_errorCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
