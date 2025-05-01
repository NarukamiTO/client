package alternativa.tanks.controller.commands.goto_ {
  import alternativa.tanks.controller.events.showform.ShowExternalEntranceFormEvent;
  import alternativa.tanks.controller.events.socialnetwork.NavigationExternalEvent;
  import alternativa.tanks.model.EntranceServerParamsModel;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import alternativa.tanks.service.AccountService;
  import alternativa.tanks.service.ICaptchaService;
  import org.robotlegs.mvcs.Command;

  public class GoToExternalLoginCommand extends Command {
    [Inject]
    public var entranceUrlParamsModel:EntranceUrlParamsModel;

    [Inject]
    public var serverParamsModel:EntranceServerParamsModel;

    [Inject]
    public var accountService:AccountService;

    [Inject]
    public var event:NavigationExternalEvent;

    [Inject]
    public var captchaService:ICaptchaService;

    public function GoToExternalLoginCommand() {
      super();
    }

    override public function execute() : void {
      var local1:Boolean = false;
      if(this.serverParamsModel.loginCaptchaEnabled) {
        local1 = true;
      } else {
        local1 = Boolean(this.captchaService.loginCaptchaEnabled);
      }
      dispatch(new ShowExternalEntranceFormEvent(ShowExternalEntranceFormEvent.LOGIN_FORM,this.event.socialNetworkId,this.entranceUrlParamsModel.passedCallsign || this.accountService.storedUserName,local1));
    }
  }
}
