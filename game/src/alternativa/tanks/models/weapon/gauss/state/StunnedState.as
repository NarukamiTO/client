package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;

  public class StunnedState implements IGaussState {
    private var weapon:LocalGaussWeapon;

    public function StunnedState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int, param2:GaussEventType, param3:*) : void {
      this.weapon.weaponStatus = 1;
    }

    public function update(param1:int, param2:int) : void {
    }
  }
}
