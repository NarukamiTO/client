package alternativa.tanks.view {
  import alternativa.tanks.controller.events.CallsignCheckResultEvent;
  import alternativa.tanks.controller.events.CaptchaAnswerIsIncorrectEvent;
  import alternativa.tanks.controller.events.CheckCallsignEvent;
  import alternativa.tanks.controller.events.CheckEmailEvent;
  import alternativa.tanks.controller.events.EmailCheckResultEvent;
  import alternativa.tanks.controller.events.RegistrationFailedEvent;
  import alternativa.tanks.view.forms.commons.RegistrationCommonElementsSection;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;

  public class RegistrationCommonElementsSectionMediator extends Mediator {
    [Inject]
    public var view:RegistrationCommonElementsSection;

    [Inject]
    public var injector:IInjector;

    public function RegistrationCommonElementsSectionMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(CheckCallsignEvent.CHECK_CALLSIGN,dispatch,CheckCallsignEvent);
      addViewListener(CheckEmailEvent.CHECK_EMAIL,dispatch,CheckEmailEvent);
      addContextListener(CaptchaAnswerIsIncorrectEvent.EVENT_TYPE,this.onCaptchaFailed);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_BUSY,this.onCallsignBusy);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_FREE,this.onCallsignFree);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_INCORRECT,this.onCallsignIncorrect);
      addContextListener(RegistrationFailedEvent.PASSWORD_IS_INCORRECT,this.onPasswordIsIncorrect);
      addContextListener(EmailCheckResultEvent.EMAIL_IS_BUSY,this.onEmailIsBusy);
      addContextListener(EmailCheckResultEvent.EMAIL_IS_FREE,this.onEmailIsFree);
      addContextListener(EmailCheckResultEvent.EMAIL_IS_INVALID,this.onEmailIsInvalid);
      addContextListener(EmailCheckResultEvent.EMAIL_DOMAIN_IS_FORBIDDEN,this.onEmailDomainIsForbidden);
    }

    private function onCaptchaFailed(param1:CaptchaAnswerIsIncorrectEvent) : void {
      this.view.captchaFailed();
    }

    private function onPasswordIsIncorrect(param1:RegistrationFailedEvent) : void {
      this.view.alertAboutIncorrectPassword();
    }

    private function onCallsignFree(param1:CallsignCheckResultEvent) : void {
      this.view.alertAboutFreeUid();
    }

    private function onCallsignBusy(param1:CallsignCheckResultEvent) : void {
      this.view.alertAboutBusyUid(param1.freeUids);
    }

    private function onCallsignIncorrect(param1:CallsignCheckResultEvent) : void {
      this.view.alertAboutIncorrectUid();
    }

    private function onEmailIsBusy(param1:EmailCheckResultEvent) : void {
      this.view.alertAboutEmailIsBusy();
    }

    private function onEmailIsFree(param1:EmailCheckResultEvent) : void {
      this.view.alertAboutEmailIsFree();
    }

    private function onEmailIsInvalid(param1:EmailCheckResultEvent) : void {
      this.view.alertAboutEmailIsInvalid();
    }

    private function onEmailDomainIsForbidden(param1:EmailCheckResultEvent) : void {
      this.view.alertAboutEmailDomainIsForbidden();
    }
  }
}
