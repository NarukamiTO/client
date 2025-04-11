package alternativa.tanks.controller.commands.partners {
  import alternativa.tanks.controller.events.CheckCaptchaAnswerEvent;
  import alternativa.tanks.controller.events.partners.PartnerLoginEvent;
  import alternativa.tanks.service.ICaptchaService;
  import org.robotlegs.mvcs.Command;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class CheckCaptchaPartnetsLoginFormCommand extends Command {
    [Inject]
    public var captchaService:ICaptchaService;

    [Inject]
    public var event:PartnerLoginEvent;

    public function CheckCaptchaPartnetsLoginFormCommand() {
      super();
    }

    override public function execute() : void {
      var local1:PartnerLoginEvent = new PartnerLoginEvent(PartnerLoginEvent.LOGIN_AFTER_CAPTCHA_CHECKED,this.event.callsign,this.event.password,this.event.captchaAnswer);
      if(this.captchaService.loginCaptchaEnabled) {
        dispatch(new CheckCaptchaAnswerEvent(this.event.captchaAnswer,CaptchaLocation.LOGIN_FORM,local1));
      } else {
        dispatch(local1);
      }
    }
  }
}
