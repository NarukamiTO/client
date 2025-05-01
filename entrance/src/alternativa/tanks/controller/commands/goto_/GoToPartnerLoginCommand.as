package alternativa.tanks.controller.commands.goto_ {
  import alternativa.tanks.controller.events.PartnersEvent;
  import alternativa.tanks.controller.events.showform.ShowPartnersFormEvent;
  import alternativa.tanks.model.EntranceServerParamsModel;
  import alternativa.tanks.model.RegistrationBackgroundModel;
  import alternativa.tanks.service.ICaptchaService;
  import org.robotlegs.mvcs.Command;

  public class GoToPartnerLoginCommand extends Command {
    [Inject]
    public var backgroundModel:RegistrationBackgroundModel;

    [Inject]
    public var serverParamsModel:EntranceServerParamsModel;

    [Inject]
    public var event:PartnersEvent;

    [Inject]
    public var captchaService:ICaptchaService;

    public function GoToPartnerLoginCommand() {
      super();
    }

    override public function execute() : void {
      var local1:Boolean = this.serverParamsModel.loginCaptchaEnabled || Boolean(this.captchaService.loginCaptchaEnabled);
      dispatch(new ShowPartnersFormEvent(ShowPartnersFormEvent.LOGIN_FORM,this.backgroundModel.backgroundImage,false,local1));
    }
  }
}
