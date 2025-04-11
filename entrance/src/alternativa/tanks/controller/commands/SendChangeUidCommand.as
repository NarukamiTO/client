package alternativa.tanks.controller.commands {
  import alternativa.tanks.service.IEntranceServerFacade;
  import alternativa.tanks.view.events.SendChangeUidEvent;
  import org.robotlegs.mvcs.Command;

  public class SendChangeUidCommand extends Command {
    [Inject]
    public var event:SendChangeUidEvent;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    public function SendChangeUidCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.changeUid(this.event.uid);
    }
  }
}
