package alternativa.tanks.view {
  import alternativa.tanks.controller.events.FightWithoutRegistrationEvent;
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.controller.events.PassToFirstBattle;
  import alternativa.tanks.controller.events.RegisterEvent;
  import alternativa.tanks.controller.events.RegistrationBackgroundLoadedEvent;
  import alternativa.tanks.controller.events.google.GoogleLoginEvent;
  import alternativa.tanks.controller.events.socialnetwork.StartExternalEntranceEvent;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.events.RegistrationFormEvent;
  import alternativa.tanks.view.forms.RegistrationForm;
  import flash.events.MouseEvent;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;

  public class RegistrationFormMediator extends Mediator {
    private static const GA_CATEGORY:String = "entrance";

    [Inject]
    public var view:RegistrationForm;

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var trackerService:ITrackerService;

    public function RegistrationFormMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(NavigationEvent.GO_TO_LOGIN_FORM,dispatch,NavigationEvent);
      addViewListener(FightWithoutRegistrationEvent.FIGHT_WITHOUT_REGISTRATION,dispatch,FightWithoutRegistrationEvent);
      addViewListener(StartExternalEntranceEvent.START_REGISTRATION,this.dispatchStartExternalRegistration,StartExternalEntranceEvent);
      addViewListener(RefreshCaptchaClickedEvent.CLICKED,this.onRefreshCaptchaClicked);
      addViewListener(RegistrationFormEvent.CLICK_REGISTRATION_BUTTON,this.onClickRegistrationButton);
      addViewListener(GoogleLoginEvent.EVENT_TYPE,dispatch,GoogleLoginEvent);
      if(this.view.skipRegistrationEnabled) {
        eventMap.mapListener(this.view.goToFirstBattleButton,MouseEvent.CLICK,this.onGoToFirstBattle);
      }
      addContextListener(RegistrationBackgroundLoadedEvent.LOADED,this.onBackgroundLoaded);
    }

    private function dispatchStartExternalRegistration(param1:StartExternalEntranceEvent) : void {
      this.trackerService.trackEvent(GA_CATEGORY,"registerVK","");
      dispatch(param1);
    }

    private function onClickRegistrationButton(param1:RegistrationFormEvent) : void {
      this.trackerService.trackEvent(GA_CATEGORY,"register","");
      dispatch(new RegisterEvent(RegisterEvent.CHECK_CAPTCHA_AND_REGISTER,this.view.callsign,this.view.emailText,this.view.password,this.view.rememberMe,this.view.realName,this.view.idNumber,this.view.captchaAnswer));
    }

    private function onRefreshCaptchaClicked(param1:RefreshCaptchaClickedEvent) : void {
      dispatch(new GetNewCaptchaEvent(CaptchaLocation.REGISTER_FORM));
    }

    private function onGoToFirstBattle(param1:MouseEvent) : void {
      this.trackerService.trackEvent(GA_CATEGORY,"goToFirstBattle","");
      dispatch(new PassToFirstBattle());
    }

    private function onBackgroundLoaded(param1:RegistrationBackgroundLoadedEvent) : void {
      this.view.setBackground(param1.backgroundImage);
    }
  }
}
