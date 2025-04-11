package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;

  public class ReloadState implements IGaussState {
    private var weapon:LocalGaussWeapon;
    private var reloadDuration:int = 0;
    private var accumulatedReloadTime:int = 0;
    private var lastUpdateTime:int = 0;

    public function ReloadState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int, param2:GaussEventType, param3:*) : void {
      this.lastUpdateTime = this.weapon.getTime();
      switch(param2) {
        case GaussEventType.RELOAD:
          this.reloadDuration = param3;
          this.accumulatedReloadTime = 0;
          this.update(param1,0);
          break;
        case GaussEventType.STUNNED:
          this.reloadDuration = param3;
          this.accumulatedReloadTime = 0;
      }
    }

    public function update(param1:int, param2:int) : void {
      param2 = this.weapon.getTime() - this.lastUpdateTime;
      this.lastUpdateTime = this.weapon.getTime();
      this.accumulatedReloadTime += param2;
      this.weapon.weaponStatus = this.accumulatedReloadTime / this.reloadDuration;
      if(this.accumulatedReloadTime >= this.reloadDuration) {
        this.weapon.processEvent(GaussEventType.RELOAD_COMPLETED);
      }
    }

    public function setReloadDuration(param1:int) : * {
      this.reloadDuration = param1;
    }
  }
}
