package alternativa.tanks.view {
  import alternativa.tanks.controller.events.CaptchaUpdatedEvent;
  import org.robotlegs.mvcs.Mediator;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaSection;

  public class CaptchaSectionMediator extends Mediator {
    [Inject]
    public var view:CaptchaSection;

    public function CaptchaSectionMediator() {
      super();
    }

    override public function onRegister() : void {
      addContextListener(CaptchaUpdatedEvent.LOGIN_FORM_CAPTCHA_UPDATED,this.onCaptchaUpdated);
      addContextListener(CaptchaUpdatedEvent.REGISTRATION_FORM_CAPTCHA_UPDATED,this.onCaptchaUpdated);
      addContextListener(CaptchaUpdatedEvent.STAND_ALONE_CAPTCHA_UPDATED,this.onCaptchaUpdated);
      addContextListener(CaptchaUpdatedEvent.RESTORE_PASSWORD_FORM_CAPTCHA_UPDATED,this.onCaptchaUpdated);
      addContextListener(CaptchaUpdatedEvent.EMAIL_CHANGE_HASH_CAPTCHA_UPDATED,this.onCaptchaUpdated);
    }

    private function onCaptchaUpdated(param1:CaptchaUpdatedEvent) : void {
      this.view.captcha = param1.image;
    }
  }
}
