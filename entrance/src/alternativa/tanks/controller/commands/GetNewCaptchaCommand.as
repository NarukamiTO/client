package alternativa.tanks.controller.commands {
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class GetNewCaptchaCommand extends Command {
    [Inject]
    public var serverFacade:IEntranceServerFacade;

    [Inject]
    public var event:GetNewCaptchaEvent;

    public function GetNewCaptchaCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.getNewCaptcha(this.event.location);
    }
  }
}
