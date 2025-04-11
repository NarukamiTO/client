package alternativa.tanks.controller.commands {
  import alternativa.tanks.controller.events.CheckEmailEvent;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class CheckEmailCommand extends Command {
    [Inject]
    public var serverFacade:IEntranceServerFacade;

    [Inject]
    public var checkEmailEvent:CheckEmailEvent;

    public function CheckEmailCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.checkEmail(this.checkEmailEvent.email);
    }
  }
}
