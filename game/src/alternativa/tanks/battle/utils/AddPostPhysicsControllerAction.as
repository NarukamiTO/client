package alternativa.tanks.battle.utils {
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.DeferredAction;
  import alternativa.tanks.battle.PostPhysicsController;

  public class AddPostPhysicsControllerAction extends BattleRunnerProvider implements DeferredAction {
    private var controller:PostPhysicsController;

    public function AddPostPhysicsControllerAction(param1:PostPhysicsController) {
      super();
      this.controller = param1;
    }

    public function execute() : void {
      getBattleRunner().addPostPhysicsController(this.controller);
    }
  }
}
