package alternativa.tanks.models.weapon.shaft.states.transitionhandlers {
  import alternativa.tanks.models.weapon.shaft.ShaftWeapon;
  import alternativa.tanks.models.weapon.shaft.states.ITransitionHandler;

  public class ManualTargetingStopHandler implements ITransitionHandler {
    private var weapon:ShaftWeapon;

    public function ManualTargetingStopHandler(param1:ShaftWeapon) {
      super();
      this.weapon = param1;
    }

    public function execute(param1:*) : void {
      if(param1) {
        this.weapon.onTargetingModeStop();
      }
    }
  }
}
