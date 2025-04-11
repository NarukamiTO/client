package alternativa.tanks.models.weapon.shaft.states {
  import alternativa.tanks.models.weapon.shaft.ShaftEventType;
  import alternativa.tanks.models.weapon.shaft.ShaftWeapon;

  public class IdleState implements IShaftState {
    private var weapon:ShaftWeapon;
    private var triggerPulled:Boolean;

    public function IdleState(param1:ShaftWeapon) {
      super();
      this.weapon = param1;
    }

    public function enter(param1:int) : void {
      this.weapon.startIdleState();
      this.triggerPulled = this.weapon.isTriggerPulled();
    }

    public function update(param1:int, param2:int) : void {
      if(this.triggerPulled) {
        this.readyToShoot();
      }
    }

    public function exit() : void {
    }

    public function processEvent(param1:ShaftEventType, param2:*) : void {
      switch(param1) {
        case ShaftEventType.TRIGGER_PULL:
          if(!this.triggerPulled) {
            this.triggerPulled = true;
            this.readyToShoot();
          }
          break;
        case ShaftEventType.TRIGGER_RELEASE:
          this.triggerPulled = false;
      }
    }

    private function readyToShoot() : void {
      if(this.weapon.canShoot()) {
        this.weapon.processEvent(ShaftEventType.READY_TO_SHOOT);
        this.triggerPulled = false;
      }
    }
  }
}
