package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;

  public class ModeSelectionState implements IGaussState {
    private static const TARGET_SEARCH_DELAY:Number = 200;

    private var weapon:LocalGaussWeapon;
    private var targetSearchStartTime:int = 0;

    public function ModeSelectionState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int, param2:GaussEventType, param3:*) : void {
      this.targetSearchStartTime = this.weapon.getTime() + TARGET_SEARCH_DELAY;
      this.update(param1,0);
    }

    public function update(param1:int, param2:int) : void {
      if(!this.weapon.isTriggerPulled() || this.weapon.isBuffed()) {
        this.weapon.processEvent(GaussEventType.SIMPLE_SHOT);
      } else if(this.weapon.getTime() >= this.targetSearchStartTime) {
        this.weapon.processEvent(GaussEventType.TARGET_SEARCH_STARTED);
      }
    }
  }
}
