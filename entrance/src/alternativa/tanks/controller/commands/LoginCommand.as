package alternativa.tanks.controller.commands {
  import alternativa.tanks.controller.events.LoginEvent;
  import alternativa.tanks.service.AccountService;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class LoginCommand extends Command {
    [Inject]
    public var entranceGateway:IEntranceServerFacade;

    [Inject]
    public var loginEvent:LoginEvent;

    [Inject]
    public var accountService:AccountService;

    public function LoginCommand() {
      super();
    }

    override public function execute() : void {
      this.accountService.storedUserName = this.loginEvent.callsign;
      this.entranceGateway.login(this.loginEvent.callsign,this.loginEvent.password,this.loginEvent.rememberMe);
    }
  }
}
