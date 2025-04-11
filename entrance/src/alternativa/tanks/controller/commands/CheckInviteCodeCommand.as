package alternativa.tanks.controller.commands {
  import alternativa.tanks.controller.events.InviteCodeEnteredEvent;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class CheckInviteCodeCommand extends Command {
    [Inject]
    public var event:InviteCodeEnteredEvent;

    [Inject]
    public var entranceGateway:IEntranceServerFacade;

    public function CheckInviteCodeCommand() {
      super();
    }

    override public function execute() : void {
      this.entranceGateway.checkInviteCode(this.event.inviteCode);
    }
  }
}
