package alternativa.tanks.controller.commands.partners {
  import alternativa.tanks.controller.events.partners.PartnerLoginEvent;
  import alternativa.tanks.service.AccountService;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class BindAccountToPartnerCommand extends Command {
    [Inject]
    public var server:IEntranceServerFacade;

    [Inject]
    public var loginEvent:PartnerLoginEvent;

    [Inject]
    public var accountService:AccountService;

    public function BindAccountToPartnerCommand() {
      super();
    }

    override public function execute() : void {
      this.accountService.storedUserName = this.loginEvent.callsign;
      this.server.bindAccountToPartner(this.loginEvent.callsign,this.loginEvent.password);
    }
  }
}
