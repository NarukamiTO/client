package alternativa.tanks.models.weapon.shaft.states {
  import alternativa.tanks.models.weapon.shaft.ShaftEventType;
  import alternativa.tanks.models.weapon.shaft.ShaftWeapon;
  import flash.utils.getTimer;

  public class ManualTargetingState implements IShaftState {
    private var weapon:ShaftWeapon;
    private var afterShotPause:int;
    private var exitTime:int;
    private var fired:Boolean;

    public function ManualTargetingState(param1:ShaftWeapon, param2:int) {
      super();
      this.weapon = param1;
      this.afterShotPause = param2;
    }

    public function enter(param1:int) : void {
      this.exitTime = -1;
      this.fired = false;
      this.weapon.startAimingState();
    }

    public function update(param1:int, param2:int) : void {
      if(this.weapon.isAimedModeLocked()) {
        this.weapon.processEvent(ShaftEventType.EXIT);
      } else if(this.exitTime > 0) {
        if(param1 >= this.exitTime) {
          this.weapon.processEvent(ShaftEventType.EXIT);
        }
      } else if(this.weapon.isBarrelOriginInsideStaticGeometry()) {
        this.weapon.processEvent(ShaftEventType.STOP,true);
      } else {
        this.weapon.updateAimingState(param1,param2);
      }
    }

    public function processEvent(param1:ShaftEventType, param2:*) : void {
      switch(param1) {
        case ShaftEventType.TRIGGER_RELEASE:
          if(!this.fired) {
            this.fired = true;
            this.weapon.performAimedShot();
            this.exitTime = getTimer() + this.afterShotPause;
          }
      }
    }

    public function exit() : void {
      this.weapon.stopAiming();
    }
  }
}
