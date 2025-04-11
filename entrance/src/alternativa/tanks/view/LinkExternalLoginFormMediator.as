package alternativa.tanks.view {
  import alternativa.tanks.controller.events.AuthorizationFailedEvent;
  import alternativa.tanks.controller.events.CaptchaAnswerIsIncorrectEvent;
  import alternativa.tanks.controller.events.CaptchaUpdatedEvent;
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.controller.events.LoginButtonPressed;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.controller.events.socialnetwork.ExternalLoginEvent;
  import alternativa.tanks.tracker.ITrackerService;
  import alternativa.tanks.view.forms.LinkExternalLoginForm;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;

  public class LinkExternalLoginFormMediator extends Mediator {
    private static const GA_CATEGORY:String = "entrance";

    [Inject]
    public var view:LinkExternalLoginForm;

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var trackerService:ITrackerService;

    public function LinkExternalLoginFormMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(RefreshCaptchaClickedEvent.CLICKED,this.onRefreshCaptchaClicked,RefreshCaptchaClickedEvent);
      addViewListener(NavigationEvent.GO_TO_LOGIN_FORM,dispatch,NavigationEvent);
      addViewListener(LoginButtonPressed.EVENT_TYPE,this.onLoginClicked,LoginButtonPressed);
      addContextListener(AuthorizationFailedEvent.PASSWORD_EXTERNAL_AUTHORIZATION_FAILED,this.onPasswordAuthorizationFailed);
      addContextListener(AuthorizationFailedEvent.EXTERNAL_LINK_ALREADY_EXISTS,this.onExternalLinkAlreadyExists);
      addContextListener(AuthorizationFailedEvent.EXTERNAL_VALIDATION_FAILED,this.onExternalValidation);
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
      this.trackerService.trackEvent(GA_CATEGORY,"externalLink","");
      dispatch(new ExternalLoginEvent(ExternalLoginEvent.CHECK_CAPTCHA_AND_LOGIN,this.view.callsign,this.view.password,this.view.captchaAnswer));
    }

    private function onCaptchaUpdated(param1:CaptchaUpdatedEvent) : void {
      this.view.showCaptchaSection();
      this.view.captchaImage = param1.image;
    }

    private function onPasswordAuthorizationFailed(param1:AuthorizationFailedEvent) : void {
      this.view.showAlertAboutWrongPassword();
    }

    private function onExternalLinkAlreadyExists(param1:AuthorizationFailedEvent) : void {
      this.view.externalLinkAlreadyExists();
    }

    private function onExternalValidation(param1:AuthorizationFailedEvent) : void {
      this.view.externalValidationFailed();
    }
  }
}
