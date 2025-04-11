package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;

  public class PowerShotState implements IGaussState {
    private var weapon:LocalGaussWeapon;

    public function PowerShotState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int, param2:GaussEventType, param3:*) : void {
      this.weapon.stopAiming();
      this.weapon.doSecondaryShot();
      this.weapon.hideAim();
      this.weapon.processEvent(GaussEventType.RELOAD,this.weapon.getPowerShotReloadDurationMs());
    }

    public function update(param1:int, param2:int) : void {
    }
  }
}
