package alternativa.tanks.model.useremailandpassword {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.socialnetwork.ISocialNetworkPanelService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.profile.useremailpassword.IUserEmailAndPasswordModelBase;
  import projects.tanks.client.panel.model.profile.useremailpassword.UserEmailAndPasswordModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.Alert;

  [ModelInfo]
  public class UserEmailAndPasswordModel extends UserEmailAndPasswordModelBase implements IUserEmailAndPasswordModelBase, ObjectLoadListener, ObjectUnloadListener, IUserEmailAndPassword, PasswordService {
    [Inject]
    public static var panelView:IPanelView;

    [Inject]
    public static var socialNetworkPanelService:ISocialNetworkPanelService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var settingService:ISettingsService;

    private var email:String;
    private var unconfirmedEmail:String;
    private var callbackCheckPassword:Function;
    private var callbackPasswordIsSet:Function;

    public function UserEmailAndPasswordModel() {
      super();
    }

    public function objectLoaded() : void {
      this.email = getInitParam().email;
      settingService.setEmail(this.email,getInitParam().emailConfirmed);
      OSGi.getInstance().registerService(PasswordService,object.adapt(PasswordService));
    }

    public function objectUnloaded() : void {
      OSGi.getInstance().unregisterService(PasswordService);
    }

    public function activateMessage(param1:String) : void {
      panelView.showAlert(param1);
      this.email = this.unconfirmedEmail;
    }

    public function emailAlreadyUsed() : void {
      alertService.showAlertById(Alert.ERROR_EMAIL_UNIQUE);
    }

    public function emailConfirmed(param1:String) : void {
      settingService.setEmail(param1,true);
      this.email = param1;
    }

    public function incorrectEmail() : void {
      alertService.showAlertById(Alert.ERROR_EMAIL_INVALID);
    }

    public function notifyCorrectPassword() : void {
      this.callbackFunction(this.callbackCheckPassword,true);
    }

    public function notifyIncorrectPassword() : void {
      this.callbackFunction(this.callbackCheckPassword,false);
    }

    public function notifyPasswordIsNotSet() : void {
      this.callbackFunction(this.callbackPasswordIsSet,false);
    }

    public function notifyPasswordIsSet() : void {
      this.callbackFunction(this.callbackPasswordIsSet,true);
    }

    private function callbackFunction(param1:Function, param2:Boolean) : * {
      if(Boolean(param1)) {
        param1(param2);
      }
      param1 = null;
    }

    public function passwordChanged() : void {
      socialNetworkPanelService.passwordCreated = true;
    }

    public function updatePasswordError() : void {
      alertService.showAlertById(Alert.ERROR_PASSWORD_CHANGE);
    }

    public function changeEmail(param1:String) : void {
      this.unconfirmedEmail = param1;
      settingService.setEmail(param1,false);
      server.updateEmail(param1);
    }

    public function getEmail() : String {
      return this.email;
    }

    public function sendChangeInstruction() : void {
      server.sendPasswordAndEmailChangeInstruction();
    }

    public function checkIsPasswordSet(param1:Function) : void {
      this.callbackPasswordIsSet = param1;
      server.checkPasswordIsSet();
    }

    public function setPassword(param1:String) : void {
      server.setPassword(param1);
    }

    public function checkPassword(param1:String, param2:Function) : void {
      this.callbackCheckPassword = param2;
      server.checkPasswordCorrectness(param1);
    }

    public function updatePassword(param1:String, param2:String) : void {
      server.updatePassword(param1,param2);
    }
  }
}
