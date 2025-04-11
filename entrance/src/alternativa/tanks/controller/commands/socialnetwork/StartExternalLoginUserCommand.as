package alternativa.tanks.controller.commands.socialnetwork {
  import alternativa.tanks.controller.events.socialnetwork.StartExternalEntranceEvent;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class StartExternalLoginUserCommand extends Command {
    [Inject]
    public var event:StartExternalEntranceEvent;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    [Inject]
    public var urlParams:EntranceUrlParamsModel;

    public function StartExternalLoginUserCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.startExternalLoginUser(this.event.socialNetworkId,this.event.rememberMe,this.urlParams.domain);
    }
  }
}
