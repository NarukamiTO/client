package alternativa.tanks.battle.utils {
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.DeferredAction;
  import alternativa.tanks.battle.PhysicsController;

  public class PhysicsControllerDeferredAction extends BattleRunnerProvider implements DeferredAction {
    private var controller:PhysicsController;
    private var add:Boolean;

    public function PhysicsControllerDeferredAction(param1:PhysicsController, param2:Boolean) {
      super();
      this.controller = param1;
      this.add = param2;
    }

    public function execute() : void {
      if(this.add) {
        getBattleRunner().addPhysicsController(this.controller);
      } else {
        getBattleRunner().removePhysicsController(this.controller);
      }
    }
  }
}
