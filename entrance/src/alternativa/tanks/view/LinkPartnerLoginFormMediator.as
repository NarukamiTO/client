package alternativa.tanks.view {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.tanks.controller.events.AuthorizationFailedEvent;
  import alternativa.tanks.controller.events.CaptchaAnswerIsIncorrectEvent;
  import alternativa.tanks.controller.events.CaptchaUpdatedEvent;
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.controller.events.LoginButtonPressed;
  import alternativa.tanks.controller.events.PartnersEvent;
  import alternativa.tanks.controller.events.RegistrationBackgroundLoadedEvent;
  import alternativa.tanks.controller.events.partners.PartnerLoginEvent;
  import alternativa.tanks.view.forms.LinkPartnerLoginForm;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;

  public class LinkPartnerLoginFormMediator extends Mediator {
    [Inject]
    public static var log:LogService;

    [Inject]
    public static var clientLog:IClientLog;

    private static const GA_CATEGORY:String = "entrance";

    [Inject]
    public var view:LinkPartnerLoginForm;

    [Inject]
    public var injector:IInjector;

    public function LinkPartnerLoginFormMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(RefreshCaptchaClickedEvent.CLICKED,this.onRefreshCaptchaClicked,RefreshCaptchaClickedEvent);
      addViewListener(PartnersEvent.START_REGISTRATION,dispatch,PartnersEvent);
      addViewListener(LoginButtonPressed.EVENT_TYPE,this.onLoginClicked,LoginButtonPressed);
      addContextListener(AuthorizationFailedEvent.PARTNER_PASSWORD_AUTHORIZATION_FAILED,this.onPasswordAuthorizationFailed);
      addContextListener(AuthorizationFailedEvent.PARTNER_LINK_ALREADY_EXISTS,this.onPartnerLinkAlreadyExists);
      addContextListener(CaptchaUpdatedEvent.LOGIN_FORM_CAPTCHA_UPDATED,this.onCaptchaUpdated,CaptchaUpdatedEvent);
      addContextListener(CaptchaAnswerIsIncorrectEvent.EVENT_TYPE,this.onCaptchaFailed);
      addContextListener(RegistrationBackgroundLoadedEvent.LOADED,this.onBackgroundLoaded);
    }

    private function onBackgroundLoaded(param1:RegistrationBackgroundLoadedEvent) : void {
      this.view.setBackground(param1.backgroundImage);
    }

    private function onCaptchaFailed(param1:CaptchaAnswerIsIncorrectEvent) : void {
      this.view.captchaFailed();
    }

    private function onRefreshCaptchaClicked(param1:RefreshCaptchaClickedEvent) : void {
      dispatch(new GetNewCaptchaEvent(CaptchaLocation.LOGIN_FORM));
    }

    private function onLoginClicked(param1:LoginButtonPressed) : void {
      dispatch(new PartnerLoginEvent(PartnerLoginEvent.CHECK_CAPTCHA_AND_LOGIN,this.view.callsign,this.view.password,this.view.captchaAnswer));
    }

    private function onCaptchaUpdated(param1:CaptchaUpdatedEvent) : void {
      this.view.showCaptchaSection();
      this.view.captchaImage = param1.image;
    }

    private function onPasswordAuthorizationFailed(param1:AuthorizationFailedEvent) : void {
      this.view.showAlertAboutWrongPassword();
    }

    private function onPartnerLinkAlreadyExists(param1:AuthorizationFailedEvent) : void {
      this.view.linkAlreadyExists();
    }
  }
}
