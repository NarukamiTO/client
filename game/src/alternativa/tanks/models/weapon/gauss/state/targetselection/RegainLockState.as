package alternativa.tanks.models.weapon.gauss.state.targetselection {
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;
  import alternativa.tanks.models.weapon.gauss.state.TargetSelectionState;

  public class RegainLockState implements IGaussAimState {
    private var weapon:LocalGaussWeapon;
    private var parentState:TargetSelectionState;
    private var lockRegainDeadline:int;
    private var lockResult:* = new LockResult();

    public function RegainLockState(param1:LocalGaussWeapon, param2:TargetSelectionState) {
      super();
      this.weapon = param1;
      this.parentState = param2;
    }

    public function enter(param1:int, param2:GaussAimEventType, param3:*) : void {
      this.lockResult.targetId = param3;
      this.lockRegainDeadline = this.weapon.getTime() + this.weapon.getMaxLockRegainTimeMs();
    }

    public function update(param1:int, param2:int) : void {
      if(this.weapon.isTriggerPulled()) {
        if(this.weapon.getTime() < this.lockRegainDeadline) {
          if(this.weapon.lockTarget(this.lockResult,this.lockResult.targetId)) {
            this.parentState.processEvent(GaussAimEventType.TARGET_FOUND,new TargetFoundData(this.lockResult,false));
          }
        } else {
          this.weapon.hideAim();
          this.parentState.processEvent(GaussAimEventType.TARGET_LOCK_FAILED,true);
        }
      } else {
        this.parentState.processEvent(GaussAimEventType.DEACTIVATED,true);
      }
    }
  }
}
