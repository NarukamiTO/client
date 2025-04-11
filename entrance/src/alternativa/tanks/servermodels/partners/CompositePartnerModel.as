package alternativa.tanks.servermodels.partners {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.IEntranceClientFacade;
  import flash.events.Event;
  import flash.external.ExternalInterface;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.type.IGameObject;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.entrance.model.entrance.partners.CompositePartnerModelBase;
  import projects.tanks.client.entrance.model.entrance.partners.ICompositePartnerModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class CompositePartnerModel extends CompositePartnerModelBase implements ICompositePartnerModelBase, ICompositePartnerModel, IParametersListener {
    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var launcherParams:ILauncherParams;

    public function CompositePartnerModel() {
      super();
    }

    private static function navigateToFailRedirectUrl(param1:Event) : void {
      navigateToURL(new URLRequest(partnerService.getFailRedirectUrl()),"_top");
    }

    public function loadPartnerObject(param1:String) : void {
      server.loadPartnerObjectOnClient(param1);
    }

    public function finishRegistration(param1:String, param2:String) : void {
      server.finishRegistration(param1,param2);
    }

    public function bindAccount(param1:String, param2:String) : void {
      server.bindAccount(param1,param2);
    }

    public function startPartnerRegistration() : void {
      clientFacade.startPartnerRegistration();
    }

    public function linkAlreadyExists() : void {
      clientFacade.partnerLinkAlreadyExists();
    }

    public function wrongPassword() : void {
      clientFacade.partnerWrongPassword();
    }

    public function showTutorial() : void {
      if(!ExternalInterface.available || ExternalInterface.call("showTutorial") == null) {
        navigateToFailRedirectUrl(null);
      }
    }

    public function loginFailed() : void {
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,navigateToFailRedirectUrl);
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_PARTNER_PARAMETRS_ERROR),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function setPartnerObject(param1:IGameObject) : void {
      partnerService.setPartner(param1);
      var local2:IPartner = IPartner(param1.adapt(IPartner));
      local2.getLoginParameters(IParametersListener(object.adapt(IParametersListener)));
    }

    public function onSetParameters(param1:LoginParameters) : void {
      server.loginViaPartner(partnerService.getEnvironmentPartnerId(),param1);
    }

    public function onFailSetParameters() : void {
      alertService.showAlert("Login failed",Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }
  }
}
