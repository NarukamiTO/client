package alternativa.tanks.controller.commands.google {
  import alternativa.tanks.controller.events.google.GoogleLoginEvent;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import alternativa.tanks.service.IEntranceServerFacade;
  import alternativa.tanks.service.impl.ExternalEntranceService;
  import org.robotlegs.mvcs.Command;

  public class GoogleLoginCommand extends Command {
    [Inject]
    public var urlParams:EntranceUrlParamsModel;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    [Inject]
    public var event:GoogleLoginEvent;

    public function GoogleLoginCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.startExternalRegisterUser(ExternalEntranceService.GOOGLE,this.event.rememberMe,this.urlParams.domain);
      this.serverFacade.googleLogin(this.event.token);
    }
  }
}
