package alternativa.tanks.controller.commands {
  import alternativa.tanks.service.IEntranceServerFacade;
  import alternativa.tanks.view.events.SendRestoreEmailMessageEvent;
  import org.robotlegs.mvcs.Command;

  public class SendRestoreEmailMessageCommand extends Command {
    [Inject]
    public var entranceGateway:IEntranceServerFacade;

    [Inject]
    public var sendMessageEvent:SendRestoreEmailMessageEvent;

    public function SendRestoreEmailMessageCommand() {
      super();
    }

    override public function execute() : void {
      this.entranceGateway.sendEmailRestoreMessage(this.sendMessageEvent.emailAddress);
    }
  }
}
