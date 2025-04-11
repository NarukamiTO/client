package alternativa.tanks.models.weapon.gauss.state.targetselection {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;

  public class TargetLockedState implements IGaussAimState {
    private var weapon:LocalGaussWeapon;

    public function TargetLockedState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int, param2:GaussAimEventType, param3:*) : void {
      this.weapon.processEvent(GaussEventType.TARGET_LOCKED,param3);
    }

    public function update(param1:int, param2:int) : void {
    }
  }
}
