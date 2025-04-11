package alternativa.tanks.models.weapon.gauss.state.targetselection {
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;
  import alternativa.tanks.models.weapon.gauss.state.TargetSelectionState;

  public class LockingState implements IGaussAimState {
    private var weapon:LocalGaussWeapon;
    private var parentState:TargetSelectionState;
    private var prevTime:int = 0;
    private var remainingLockTime:Number = 0;
    private var lockResult:* = new LockResult();

    public function LockingState(param1:LocalGaussWeapon, param2:TargetSelectionState) {
      super();
      this.weapon = param1;
      this.parentState = param2;
    }

    public function enter(param1:int, param2:GaussAimEventType, param3:*) : void {
      var local4:* = TargetFoundData(param3);
      this.prevTime = this.weapon.getTime();
      if(Boolean(local4.isNewTarget)) {
        this.remainingLockTime = this.weapon.getTargetLockDurationMs();
      }
      this.lockResult.copy(local4.lockResult);
    }

    public function update(param1:int, param2:int) : void {
      if(this.weapon.isTriggerPulled()) {
        if(this.weapon.lockTarget(this.lockResult,this.lockResult.targetId)) {
          this.remainingLockTime -= this.weapon.getTime() - this.prevTime;
          this.prevTime = this.weapon.getTime();
          this.weapon.weaponStatus = this.remainingLockTime / this.weapon.getTargetLockDurationMs();
          if(this.remainingLockTime <= 0) {
            this.parentState.processEvent(GaussAimEventType.TARGET_LOCKED,this.lockResult);
          }
        } else {
          this.parentState.processEvent(GaussAimEventType.TARGET_LOCK_LOST,this.lockResult.targetId);
        }
      } else {
        this.parentState.processEvent(GaussAimEventType.DEACTIVATED,this.lockResult.targetId);
      }
    }
  }
}
