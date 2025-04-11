package alternativa.tanks.controller.commands {
  import alternativa.tanks.service.IEntranceServerFacade;
  import alternativa.tanks.view.events.SendChangeUidAndPasswordEvent;
  import org.robotlegs.mvcs.Command;

  public class SendChangeUidAndPasswordCommand extends Command {
    [Inject]
    public var event:SendChangeUidAndPasswordEvent;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    public function SendChangeUidAndPasswordCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.changeUidAndPassword(this.event.uid,this.event.password);
    }
  }
}
