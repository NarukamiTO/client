package projects.tanks.client.panel.model.profile.useremailpassword {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class UserEmailAndPasswordModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UserEmailAndPasswordModelServer;

    private var client:IUserEmailAndPasswordModelBase = IUserEmailAndPasswordModelBase(this);
    private var modelId:Long = Long.getLong(740369199,944909632);
    private var _activateMessageId:Long = Long.getLong(742786754,-588207711);
    private var _activateMessage_messageCodec:ICodec;
    private var _emailAlreadyUsedId:Long = Long.getLong(134865479,1344292238);
    private var _emailConfirmedId:Long = Long.getLong(607961308,438757112);
    private var _emailConfirmed_emailCodec:ICodec;
    private var _incorrectEmailId:Long = Long.getLong(2070151898,-799055156);
    private var _notifyCorrectPasswordId:Long = Long.getLong(639769619,1507772121);
    private var _notifyIncorrectPasswordId:Long = Long.getLong(41003958,-1035229982);
    private var _notifyPasswordIsNotSetId:Long = Long.getLong(21656026,-1373860270);
    private var _notifyPasswordIsSetId:Long = Long.getLong(702539491,144211585);
    private var _passwordChangedId:Long = Long.getLong(1455847234,-1429972580);
    private var _updatePasswordErrorId:Long = Long.getLong(1807808543,-1997999313);

    public function UserEmailAndPasswordModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UserEmailAndPasswordModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(UserEmailCC,false)));
      this._activateMessage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._emailConfirmed_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    protected function getInitParam() : UserEmailCC {
      return UserEmailCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateMessageId:
          this.client.activateMessage(String(this._activateMessage_messageCodec.decode(param2)));
          break;
        case this._emailAlreadyUsedId:
          this.client.emailAlreadyUsed();
          break;
        case this._emailConfirmedId:
          this.client.emailConfirmed(String(this._emailConfirmed_emailCodec.decode(param2)));
          break;
        case this._incorrectEmailId:
          this.client.incorrectEmail();
          break;
        case this._notifyCorrectPasswordId:
          this.client.notifyCorrectPassword();
          break;
        case this._notifyIncorrectPasswordId:
          this.client.notifyIncorrectPassword();
          break;
        case this._notifyPasswordIsNotSetId:
          this.client.notifyPasswordIsNotSet();
          break;
        case this._notifyPasswordIsSetId:
          this.client.notifyPasswordIsSet();
          break;
        case this._passwordChangedId:
          this.client.passwordChanged();
          break;
        case this._updatePasswordErrorId:
          this.client.updatePasswordError();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
