package alternativa.tanks.controller.commands.goto_ {
  import alternativa.tanks.controller.events.showform.ShowLoginFormEvent;
  import alternativa.tanks.model.EntranceServerParamsModel;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import alternativa.tanks.service.AccountService;
  import alternativa.tanks.service.ICaptchaService;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class GoToLoginCommand extends Command {
    [Inject]
    public var entranceUrlParamsModel:EntranceUrlParamsModel;

    [Inject]
    public var accountService:AccountService;

    [Inject]
    public var serverParamsModel:EntranceServerParamsModel;

    [Inject]
    public var captchaService:ICaptchaService;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    public function GoToLoginCommand() {
      super();
    }

    override public function execute() : void {
      var local1:Boolean = false;
      if(this.serverParamsModel.loginCaptchaEnabled) {
        local1 = true;
      } else {
        local1 = Boolean(this.captchaService.loginCaptchaEnabled);
      }
      dispatch(new ShowLoginFormEvent(this.entranceUrlParamsModel.passedCallsign || this.accountService.storedUserName,true,local1,this.entranceUrlParamsModel.passedPassword));
    }
  }
}
