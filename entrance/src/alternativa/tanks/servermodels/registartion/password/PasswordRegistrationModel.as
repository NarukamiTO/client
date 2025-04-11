package alternativa.tanks.servermodels.registartion.password {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.newbieservice.NewbieUserService;
  import alternativa.tanks.service.IEntranceClientFacade;
  import alternativa.tanks.service.IPasswordParamsService;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.ymservice.YandexMetricaService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.entrance.model.entrance.registration.IRegistrationModelBase;
  import projects.tanks.client.entrance.model.entrance.registration.RegistrationModelBase;
  import projects.tanks.clients.flash.commons.models.layout.LobbyLayoutModel;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import services.alertservice.AlertAnswer;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  [ModelInfo]
  public class PasswordRegistrationModel extends RegistrationModelBase implements IRegistrationModelBase, IPasswordRegistration, ObjectLoadListener, IImageResource {
    [Inject]
    public static var facade:IEntranceClientFacade;

    [Inject]
    public static var passwordParamsService:IPasswordParamsService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var launcherParams:ILauncherParams;

    [Inject]
    public static var ymService:YandexMetricaService;

    [Inject]
    public static var newbieUserService:NewbieUserService;

    [Inject]
    public static var storageService:IStorageService;

    private static const USER_IS_REGISTERED:String = "registered";

    public function PasswordRegistrationModel() {
      super();
    }

    public function objectLoaded() : void {
      this.checkFormerUser();
      passwordParamsService.minPasswordLength = getInitParam().minPasswordLength;
      passwordParamsService.maxPasswordLength = getInitParam().maxPasswordLength;
      facade.registrationThroughEmail = getInitParam().enableRequiredEmail;
      var local1:ImageResource = getInitParam().bgResource;
      if(local1.isLazy && !local1.isLoaded) {
        local1.loadLazyResource(new ImageResourceLoadingWrapper(this));
      } else {
        this.setPreviewResource(local1);
      }
    }

    private function checkFormerUser() : void {
      var local1:Object = storageService.getStorage().data.uniqueUserIdHighDWord;
      var local2:Object = storageService.getStorage().data.uniqueUserIdLowDWord;
      if(Boolean(local1) && Boolean(local2)) {
        server.setFormerUserId(Long.getLong(int(local1),int(local2)));
      }
    }

    public function enteredUidIsFree() : void {
      facade.callsignIsFree();
    }

    public function anchorRegistration() : void {
      if(launcherParams.getParameter("partner") != null) {
        trackerService.trackPageView("registered/" + launcherParams.getParameter("partner"));
      } else {
        trackerService.trackPageView("registered");
      }
      ymService.reachGoalIfPlayerWasInTutorial(USER_IS_REGISTERED);
      newbieUserService.isNewbieUser = true;
      storageService.getStorage().data[LobbyLayoutModel.USE_BATTLE_LIST_KEY] = false;
    }

    public function enteredUidIsBusy(param1:Vector.<String>) : void {
      facade.callsignIsBusy(param1);
    }

    public function enteredUidIsIncorrect() : void {
      facade.callsignIsIncorrect();
    }

    public function passwordIsIncorrect() : void {
      facade.registrationPasswordIsIncorrect();
    }

    public function registrationFailed() : void {
      alertService.showAlert("Registration failed. Try again.",Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    public function register(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void {
      this.resetUniqueUser();
      server.register(param1,param2,param3,param4,param5,param6,param7);
    }

    private function resetUniqueUser() : void {
      var local1:Object = storageService.getStorage().data;
      local1.uniqueUserIdLowDWord = null;
      local1.uniqueUserIdHighDWord = null;
    }

    public function checkCallsign(param1:String) : void {
      server.checkUid(param1);
    }

    public function setPreviewResource(param1:ImageResource) : void {
      if(facade != null) {
        facade.registrationFormBackgroundRGB = param1.data;
      }
    }
  }
}
