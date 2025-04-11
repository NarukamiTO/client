package alternativa.tanks.view {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.tanks.controller.events.AccountLoginEvent;
  import alternativa.tanks.controller.events.AccountLoginPressed;
  import alternativa.tanks.controller.events.AuthorizationFailedEvent;
  import alternativa.tanks.controller.events.CaptchaAnswerIsIncorrectEvent;
  import alternativa.tanks.controller.events.CaptchaUpdatedEvent;
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.controller.events.LoginButtonPressed;
  import alternativa.tanks.controller.events.LoginEvent;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.controller.events.google.GoogleLoginEvent;
  import alternativa.tanks.controller.events.socialnetwork.StartExternalEntranceEvent;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.forms.LoginForm;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;

  public class LoginFormMediator extends Mediator {
    [Inject]
    public static var clientLog:IClientLog;

    private static const GA_CATEGORY:String = "entrance";

    [Inject]
    public var view:LoginForm;

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var trackerService:ITrackerService;

    public function LoginFormMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(RefreshCaptchaClickedEvent.CLICKED,this.onRefreshCaptchaClicked,RefreshCaptchaClickedEvent);
      addViewListener(LoginButtonPressed.EVENT_TYPE,this.onLoginClicked,LoginButtonPressed);
      addViewListener(AccountLoginPressed.EVENT_TYPE,this.onAccountLoginClicked,AccountLoginPressed);
      addViewListener(NavigationEvent.GO_TO_REGISTRATION_FORM,dispatch,NavigationEvent);
      addViewListener(NavigationEvent.GO_TO_RESTORE_PASSWORD_FORM,dispatch,NavigationEvent);
      addViewListener(StartExternalEntranceEvent.START_LOGIN,this.dispatchStartExternalLogin,StartExternalEntranceEvent);
      addViewListener(GoogleLoginEvent.EVENT_TYPE,dispatch,GoogleLoginEvent);
      addContextListener(AuthorizationFailedEvent.HASH_AUTHORIZATION_FAILED,this.onHashAuthorizationFailed,AuthorizationFailedEvent);
      addContextListener(AuthorizationFailedEvent.PASSWORD_AUTHORIZATION_FAILED,this.onPasswordAuthorizationFailed,AuthorizationFailedEvent);
      addContextListener(CaptchaUpdatedEvent.LOGIN_FORM_CAPTCHA_UPDATED,this.onCaptchaUpdated,CaptchaUpdatedEvent);
      addContextListener(CaptchaAnswerIsIncorrectEvent.EVENT_TYPE,this.onCaptchaFailed);
    }

    private function onCaptchaFailed(param1:CaptchaAnswerIsIncorrectEvent) : void {
      this.view.captchaFailed();
    }

    private function onRefreshCaptchaClicked(param1:RefreshCaptchaClickedEvent) : void {
      dispatch(new GetNewCaptchaEvent(CaptchaLocation.LOGIN_FORM));
    }

    private function onLoginClicked(param1:LoginButtonPressed) : void {
      this.trackerService.trackEvent(GA_CATEGORY,"play",this.view.rememberMe ? "remember" : "no_remember");
      dispatch(new LoginEvent(LoginEvent.CHECK_CAPTCHA_AND_LOGIN,this.view.callsign,this.view.password,this.view.rememberMe,this.view.captchaAnswer));
    }

    private function onAccountLoginClicked(param1:AccountLoginPressed) : void {
      this.trackerService.trackEvent(GA_CATEGORY,"play",this.view.rememberMe ? "remember" : "no_remember");
      dispatch(new AccountLoginEvent(this.view.hash));
    }

    private function dispatchStartExternalLogin(param1:StartExternalEntranceEvent) : void {
      this.trackerService.trackEvent(GA_CATEGORY,"externalLogin",Boolean(param1.socialNetworkId + " " + this.view.rememberMe) ? "remember" : "no_remember");
      dispatch(param1);
    }

    private function dispatchGoogleLogin(param1:GoogleLoginEvent) : void {
      this.trackerService.trackEvent(GA_CATEGORY,"externalLogin","google");
      dispatch(param1);
    }

    private function onCaptchaUpdated(param1:CaptchaUpdatedEvent) : void {
      clientLog.logError("er","capcha reg");
      this.view.showCaptchaSection();
      this.view.captchaImage = param1.image;
    }

    private function onPasswordAuthorizationFailed(param1:AuthorizationFailedEvent) : void {
      this.view.alertAboutWrongPassword();
    }

    private function onHashAuthorizationFailed(param1:AuthorizationFailedEvent) : void {
      if(Boolean(this.view.stage)) {
        this.view.alertAboutWrongPassword();
      }
    }
  }
}
