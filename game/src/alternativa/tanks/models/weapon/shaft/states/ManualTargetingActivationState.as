package alternativa.tanks.models.weapon.shaft.states {
  import alternativa.tanks.models.weapon.shaft.ShaftEventType;
  import alternativa.tanks.models.weapon.shaft.ShaftWeapon;

  public class ManualTargetingActivationState implements IShaftState {
    private var weapon:ShaftWeapon;
    private var stateDuration:int;
    private var timeLeft:int;

    public function ManualTargetingActivationState(param1:ShaftWeapon, param2:int) {
      super();
      this.weapon = param1;
      this.stateDuration = param2;
    }

    public function enter(param1:int) : void {
      this.weapon.startAimingActivation();
      this.timeLeft = this.stateDuration;
    }

    public function exit() : void {
    }

    public function update(param1:int, param2:int) : void {
      var local3:Number = NaN;
      if(this.weapon.isAimedModeLocked()) {
        this.weapon.processEvent(ShaftEventType.STOP);
      } else if(this.timeLeft <= 0) {
        this.weapon.setAimingActivationProgress(1);
        this.weapon.processEvent(ShaftEventType.SWITCH);
      } else {
        this.timeLeft -= param2;
        local3 = 1 - this.timeLeft / this.stateDuration;
        if(local3 > 1) {
          local3 = 1;
        }
        this.weapon.setAimingActivationProgress(local3);
      }
    }

    public function processEvent(param1:ShaftEventType, param2:*) : void {
      switch(param1) {
        case ShaftEventType.TRIGGER_RELEASE:
          this.weapon.processEvent(ShaftEventType.TRIGGER_RELEASE);
      }
    }
  }
}
