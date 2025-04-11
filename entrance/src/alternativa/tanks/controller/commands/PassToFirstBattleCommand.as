package alternativa.tanks.controller.commands {
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class PassToFirstBattleCommand extends Command {
    [Inject]
    public var serverFacade:IEntranceServerFacade;

    public function PassToFirstBattleCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.fightWithoutRegistration();
    }
  }
}
