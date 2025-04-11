package alternativa.tanks.service.impl {
  import alternativa.tanks.servermodels.IGoogleEntranceModel;
  import alternativa.tanks.servermodels.changeuid.IChangeUid;
  import alternativa.tanks.servermodels.emailandpasswordchanger.IPasswordRecovery;
  import alternativa.tanks.servermodels.emailconfirm.IEmailConfirm;
  import alternativa.tanks.servermodels.invite.IInvite;
  import alternativa.tanks.servermodels.login.ILogin;
  import alternativa.tanks.servermodels.loginbyhash.ILoginByHash;
  import alternativa.tanks.servermodels.loginwithoutregistration.ILoginWithoutRegistration;
  import alternativa.tanks.servermodels.partners.ICompositePartnerModel;
  import alternativa.tanks.servermodels.registartion.email.IEmailRegistration;
  import alternativa.tanks.servermodels.registartion.password.IPasswordRegistration;
  import alternativa.tanks.servermodels.socialnetwork.IExternalEntranceModel;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Actor;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.IServerCaptcha;

  public class EntranceServerFacade extends Actor implements IEntranceServerFacade {
    private var _gameObject:IGameObject;

    public function EntranceServerFacade() {
      super();
    }

    public function checkCallsign(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      IPasswordRegistration(this._gameObject.adapt(IPasswordRegistration)).checkCallsign(param1);
    }

    public function checkEmail(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      IEmailRegistration(this._gameObject.adapt(IEmailRegistration)).checkEmail(param1);
    }

    public function checkInviteCode(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      IInvite(this._gameObject.adapt(IInvite)).checkInvite(param1);
    }

    public function sendEmailRestoreMessage(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      IPasswordRecovery(this._gameObject.adapt(IPasswordRecovery)).sendUsersRestorePasswordLink(param1);
    }

    public function login(param1:String, param2:String, param3:Boolean) : void {
      this.checkIfGameObjectIsLoaded();
      ILogin(this._gameObject.adapt(ILogin)).login(param1,param2,param3);
    }

    public function loginExternal(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      IExternalEntranceModel(this._gameObject.adapt(IExternalEntranceModel)).login(param1,param2);
    }

    public function fightWithoutRegistration() : void {
      this.checkIfGameObjectIsLoaded();
      ILoginWithoutRegistration(this._gameObject.adapt(ILoginWithoutRegistration)).passToFirstBattle();
    }

    public function checkEmailChangeHash(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      IPasswordRecovery(this._gameObject.adapt(IPasswordRecovery)).startEmailAndPasswordChangeProcess(param1);
    }

    public function loginByHash(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      ILoginByHash(this._gameObject.adapt(ILoginByHash)).loginByHash(param1);
    }

    public function loginBySingleUseHash(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      ILoginByHash(this._gameObject.adapt(ILoginByHash)).loginBySingleUseHash(param1);
    }

    public function confirmEmail(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      IEmailConfirm(this._gameObject.adapt(IEmailConfirm)).startEmailConfirm(param1,param2);
    }

    public function checkChangeUidHash(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      IChangeUid(this._gameObject.adapt(IChangeUid)).checkChangeUidHash(param1,param2);
    }

    public function changeUidAndPassword(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      IChangeUid(this._gameObject.adapt(IChangeUid)).changeUidAndPassword(param1,param2);
    }

    public function changeUid(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      IChangeUid(this._gameObject.adapt(IChangeUid)).changeUid(param1);
    }

    public function set entranceObject(param1:IGameObject) : void {
      this._gameObject = param1;
    }

    public function registerUserThroughPassword(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void {
      this.checkIfGameObjectIsLoaded();
      (this._gameObject.adapt(IPasswordRegistration) as IPasswordRegistration).register(param1,param2,param3,param4,param5,param6,param7);
    }

    public function registerThroughEmail(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void {
      this.checkIfGameObjectIsLoaded();
      (this._gameObject.adapt(IEmailRegistration) as IEmailRegistration).register(param1,param2,param3,param4,param5,param6);
    }

    public function getNewCaptcha(param1:CaptchaLocation) : void {
      this.checkIfGameObjectIsLoaded();
      (this._gameObject.adapt(IServerCaptcha) as IServerCaptcha).getNewCaptcha(param1);
    }

    public function checkCaptcha(param1:String, param2:CaptchaLocation) : void {
      this.checkIfGameObjectIsLoaded();
      (this._gameObject.adapt(IServerCaptcha) as IServerCaptcha).checkCaptcha(param1,param2);
    }

    public function changePasswordAndEmail(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      IPasswordRecovery(this._gameObject.adapt(IPasswordRecovery)).changePasswordAndEmail(param1,param2);
    }

    public function startExternalRegisterUser(param1:String, param2:Boolean, param3:String) : void {
      this.checkIfGameObjectIsLoaded();
      IExternalEntranceModel(this._gameObject.adapt(IExternalEntranceModel)).startExternalRegisterUser(param1,param2,param3);
    }

    public function startExternalLoginUser(param1:String, param2:Boolean, param3:String) : void {
      this.checkIfGameObjectIsLoaded();
      IExternalEntranceModel(this._gameObject.adapt(IExternalEntranceModel)).startExternalLoginUser(param1,param2,param3);
    }

    public function finishExternalRegisterUser(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      IExternalEntranceModel(this._gameObject.adapt(IExternalEntranceModel)).finishExternalRegisterUser(param1,param2);
    }

    public function loadPartnerObject(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      ICompositePartnerModel(this._gameObject.adapt(ICompositePartnerModel)).loadPartnerObject(param1);
    }

    public function finishPartnerRegistration(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      ICompositePartnerModel(this._gameObject.adapt(ICompositePartnerModel)).finishRegistration(param1,param2);
    }

    public function bindAccountToPartner(param1:String, param2:String) : void {
      this.checkIfGameObjectIsLoaded();
      ICompositePartnerModel(this._gameObject.adapt(ICompositePartnerModel)).bindAccount(param1,param2);
    }

    private function checkIfGameObjectIsLoaded() : void {
      if(this._gameObject == null) {
        throw new Error("Entrance gameObject is not loaded");
      }
    }

    public function googleLogin(param1:String) : void {
      this.checkIfGameObjectIsLoaded();
      (this._gameObject.adapt(IGoogleEntranceModel) as IGoogleEntranceModel).login(param1);
    }
  }
}
