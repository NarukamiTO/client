package alternativa.tanks.servermodels.logging {
  import alternativa.startup.StartupSettings;
  import alternativa.tanks.controller.events.logging.RegistrationUXFormEvent;
  import alternativa.tanks.controller.events.logging.RegistrationUXNavigationFinishEvent;
  import alternativa.tanks.controller.events.logging.RegistrationUXNavigationStartEvent;
  import alternativa.tanks.service.IRegistrationUXService;
  import flash.external.ExternalInterface;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.entrance.model.entrance.logging.IRegistrationUXLoggerModelBase;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXLoggerModelBase;

  [ModelInfo]
  public class RegistrationUXLoggerModel extends RegistrationUXLoggerModelBase implements IRegistrationUXLoggerModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var registrationUXService:IRegistrationUXService;

    private static const COOKIE_EXISTS_FUNC:String = "Cookie.exists";
    private static const TUTORIAL_TOKEN:String = "TUTORIAL_TOKEN";

    public function RegistrationUXLoggerModel() {
      super();
    }

    public function objectLoaded() : void {
      registrationUXService.addEventListener(RegistrationUXFormEvent.FORM_ACTION,getFunctionWrapper(this.onFormEvent));
      registrationUXService.addEventListener(RegistrationUXNavigationStartEvent.NAVIGATION_START,getFunctionWrapper(this.onNavigationStart));
      registrationUXService.addEventListener(RegistrationUXNavigationFinishEvent.NAVIGATION_FINISH,getFunctionWrapper(this.onNavigationFinish));
      var local1:Number = new Date().valueOf() - getTimer();
      server.initLogger(local1.toString(),this.isTutorialUser(),StartupSettings.isUserFromTutorial());
    }

    public function objectUnloaded() : void {
      registrationUXService.removeEventListener(RegistrationUXFormEvent.FORM_ACTION,getFunctionWrapper(this.onFormEvent));
      registrationUXService.removeEventListener(RegistrationUXNavigationStartEvent.NAVIGATION_START,getFunctionWrapper(this.onNavigationStart));
      registrationUXService.removeEventListener(RegistrationUXNavigationFinishEvent.NAVIGATION_FINISH,getFunctionWrapper(this.onNavigationFinish));
    }

    private function onFormEvent(param1:RegistrationUXFormEvent) : void {
      server.logFormAction(param1.action,param1.count);
    }

    private function onNavigationStart(param1:RegistrationUXNavigationStartEvent) : void {
      server.logNavigationStart(param1.screen);
    }

    private function onNavigationFinish(param1:RegistrationUXNavigationFinishEvent) : void {
      server.logNavigationFinish();
    }

    private function isTutorialUser() : Boolean {
      return ExternalInterface.available && ExternalInterface.call(COOKIE_EXISTS_FUNC,TUTORIAL_TOKEN) > 0;
    }
  }
}
