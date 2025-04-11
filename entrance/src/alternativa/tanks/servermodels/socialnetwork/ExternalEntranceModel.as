package alternativa.tanks.servermodels.socialnetwork {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.IEntranceClientFacade;
  import alternativa.tanks.service.IExternalEntranceService;
  import alternativa.tanks.view.forms.RegistrationForm;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import flash.external.ExternalInterface;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.entrance.model.entrance.externalentrance.ExternalEntranceModelBase;
  import projects.tanks.client.entrance.model.entrance.externalentrance.IExternalEntranceModelBase;
  import projects.tanks.client.entrance.model.entrance.externalentrance.SocialNetworkEntranceParams;
  import projects.tanks.clients.flash.commons.models.externalauth.ExternalAuthApi;
  import projects.tanks.clients.flash.commons.services.externalauth.ExternalAuthParamsService;
  import projects.tanks.clients.flash.commons.services.nameutils.SocialNetworkNameUtils;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class ExternalEntranceModel extends ExternalEntranceModelBase implements IExternalEntranceModelBase, ObjectLoadListener, IExternalEntranceModel {
    [Inject]
    public static var externalEntranceService:IExternalEntranceService;

    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var ymService:YandexMetricaService;

    [Inject]
    public static var externalAuthParamsService:ExternalAuthParamsService;

    private static const VK_REGISTRATION_COMPLETED:String = "VKRegistration:completed";
    private static const FB_REGISTRATION_COMPLETED:String = "FBRegistration:completed";
    private static const GOOGLE_REGISTRATION_COMPLETED:String = "GOOGLERegistration:completed";

    private var isSendStartRegisterFacade:Boolean;
    private var isSendStartLoginFacade:Boolean;
    private var _socialNetworkId:String;

    public function ExternalEntranceModel() {
      super();
    }

    public function login(param1:String, param2:String) : void {
      server.createLinkForExistingUser(param1,param2);
    }

    public function startExternalRegisterUser(param1:String, param2:Boolean, param3:String) : void {
      this.isSendStartRegisterFacade = true;
      this.startExternalEnter(param1,param2,param3);
    }

    public function startExternalLoginUser(param1:String, param2:Boolean, param3:String) : void {
      this.isSendStartLoginFacade = true;
      this.startExternalEnter(param1,param2,param3);
    }

    private function startExternalEnter(param1:String, param2:Boolean, param3:String) : void {
      this._socialNetworkId = param1;
      server.setLoginData(param2,param3);
      var local4:String = this.getAuthorizationUrl(param1);
      if(Boolean(local4)) {
        this.goToURL(local4);
      } else {
        ExternalAuthApi(object.adapt(ExternalAuthApi)).initLogin(param1);
      }
    }

    private function getAuthorizationUrl(param1:String) : String {
      var local2:SocialNetworkEntranceParams = null;
      for each(local2 in getInitParam().socialNetworkParams) {
        if(local2.snId == param1) {
          return local2.authorizationUrl;
        }
      }
      return null;
    }

    private function goToURL(param1:String) : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("newPopup",param1);
      } else {
        navigateToURL(new URLRequest(param1));
      }
    }

    public function finishExternalRegisterUser(param1:String, param2:String) : void {
      if(this._socialNetworkId == RegistrationForm.VK_ID) {
        ymService.reachGoalIfPlayerWasInTutorial(VK_REGISTRATION_COMPLETED);
      }
      if(this._socialNetworkId == RegistrationForm.FB_ID) {
        ymService.reachGoalIfPlayerWasInTutorial(FB_REGISTRATION_COMPLETED);
      }
      if(this._socialNetworkId == RegistrationForm.GOOGLE_ID) {
        ymService.reachGoalIfPlayerWasInTutorial(GOOGLE_REGISTRATION_COMPLETED);
      }
      server.registerNewUser(param1,param2);
    }

    public function objectLoaded() : void {
      var local2:SocialNetworkEntranceParams = null;
      var local1:Vector.<SocialNetworkEntranceParams> = getInitParam().socialNetworkParams;
      for each(local2 in local1) {
        externalEntranceService.setEnabled(local2.snId,local2.enabled);
      }
    }

    public function validationSuccess() : void {
      if(this.isSendStartRegisterFacade) {
        this.isSendStartRegisterFacade = false;
        clientFacade.goToExternalRegistrationForm(this._socialNetworkId);
      }
      if(this.isSendStartLoginFacade) {
        this.isSendStartLoginFacade = false;
        clientFacade.goToExternalLoginForm(this._socialNetworkId);
      }
    }

    public function wrongPassword() : void {
      clientFacade.wrongPasswordExternalEntrance();
    }

    public function validationFailed() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_ERROR_EXTERNAL_ENTER),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
      clientFacade.externalValidationFailed();
    }

    public function linkAlreadyExists() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_GAME_ACCOUNT_ALREADY_LINKED,SocialNetworkNameUtils.makeSocialNetworkNameFromId(this._socialNetworkId)),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
      clientFacade.externalLinkAlreadyExists();
    }
  }
}
