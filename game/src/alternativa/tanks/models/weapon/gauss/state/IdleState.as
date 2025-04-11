package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;

  public class IdleState implements IGaussState {
    private var weapon:LocalGaussWeapon;

    public function IdleState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int, param2:GaussEventType, param3:*) : void {
      this.weapon.weaponStatus = 1;
      if(param2 != GaussEventType.BUFF_EXPIRED) {
        this.update(param1,0);
      }
    }

    public function update(param1:int, param2:int) : void {
      if(this.weapon.isTriggerPulled() && this.weapon.isShotAllowed()) {
        this.weapon.processEvent(GaussEventType.ACTIVATED);
      }
    }
  }
}
