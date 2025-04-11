package alternativa.tanks.controller.commands {
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class FightWithoutRegistrationCommand extends Command {
    [Inject]
    public var entranceGateway:IEntranceServerFacade;

    public function FightWithoutRegistrationCommand() {
      super();
    }

    override public function execute() : void {
      this.entranceGateway.fightWithoutRegistration();
    }
  }
}
