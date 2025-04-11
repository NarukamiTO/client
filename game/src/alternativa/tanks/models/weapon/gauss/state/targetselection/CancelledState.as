package alternativa.tanks.models.weapon.gauss.state.targetselection {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;

  public class CancelledState implements IGaussAimState {
    private var weapon:LocalGaussWeapon;

    public function CancelledState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int, param2:GaussAimEventType, param3:*) : void {
      this.weapon.stopAiming();
      this.weapon.hideAim();
      this.weapon.processEvent(GaussEventType.DEACTIVATED);
    }

    public function update(param1:int, param2:int) : void {
    }
  }
}
