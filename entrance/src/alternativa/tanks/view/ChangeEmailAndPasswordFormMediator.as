package alternativa.tanks.view {
  import alternativa.tanks.controller.events.CaptchaAnswerIsIncorrectEvent;
  import alternativa.tanks.controller.events.CaptchaUpdatedEvent;
  import alternativa.tanks.controller.events.ChangeEmailCaptchaEvent;
  import alternativa.tanks.controller.events.CheckCaptchaAnswerEvent;
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.controller.events.SendNewPasswordAndEmailToChangeEvent;
  import alternativa.tanks.controller.events.SetPasswordChangeResultEvent;
  import alternativa.tanks.view.forms.ChangeEmailAndPasswordForm;
  import org.robotlegs.mvcs.Mediator;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;

  public class ChangeEmailAndPasswordFormMediator extends Mediator {
    [Inject]
    public var view:ChangeEmailAndPasswordForm;

    public function ChangeEmailAndPasswordFormMediator() {
      super();
    }

    override public function onRegister() : void {
      addViewListener(ChangeEmailCaptchaEvent.CAPTCHA,this.onChangeEmailCaptcha,ChangeEmailCaptchaEvent);
      addViewListener(NavigationEvent.GO_TO_LOGIN_FORM,dispatch,NavigationEvent);
      addViewListener(RefreshCaptchaClickedEvent.CLICKED,this.onRefreshCaptchaClicked,RefreshCaptchaClickedEvent);
      addContextListener(SetPasswordChangeResultEvent.SET,this.onPasswordChangeResult,SetPasswordChangeResultEvent);
      addContextListener(CaptchaUpdatedEvent.EMAIL_CHANGE_HASH_CAPTCHA_UPDATED,this.onCaptchaUpdated,CaptchaUpdatedEvent);
      addContextListener(CaptchaAnswerIsIncorrectEvent.EVENT_TYPE,this.onCaptchaFailed);
    }

    private function onChangeEmailCaptcha(param1:ChangeEmailCaptchaEvent) : void {
      var local2:SendNewPasswordAndEmailToChangeEvent = new SendNewPasswordAndEmailToChangeEvent(param1.getPassword(),param1.getEmail());
      dispatch(new CheckCaptchaAnswerEvent(param1.getCaptchaAnswer(),CaptchaLocation.EMAIL_CHANGE_HASH,local2));
    }

    private function onPasswordChangeResult(param1:SetPasswordChangeResultEvent) : void {
      this.view.setPasswordChangeResult(param1.success,param1.error);
    }

    private function onCaptchaFailed(param1:CaptchaAnswerIsIncorrectEvent) : void {
      this.view.captchaFailed();
    }

    private function onRefreshCaptchaClicked(param1:RefreshCaptchaClickedEvent) : void {
      dispatch(new GetNewCaptchaEvent(CaptchaLocation.EMAIL_CHANGE_HASH));
    }

    private function onCaptchaUpdated(param1:CaptchaUpdatedEvent) : void {
      this.view.setCaptchaImage(param1.image);
    }
  }
}
