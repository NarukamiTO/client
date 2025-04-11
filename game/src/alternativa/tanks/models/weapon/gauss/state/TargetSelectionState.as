package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;
  import alternativa.tanks.models.weapon.gauss.LocalGaussWeapon;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.AimTransition;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.CancelledState;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.GaussAimEventType;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.GaussAimState;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.IGaussAimState;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.LockingState;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.RegainLockState;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.TargetLockedState;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.TargetSearchState;
  import flash.utils.Dictionary;

  public class TargetSelectionState implements IGaussState {
    private var states:Dictionary = new Dictionary();
    private var transitions:Vector.<AimTransition>;
    private var weapon:LocalGaussWeapon;
    private var currentState:IGaussAimState;

    public function TargetSelectionState(param1:LocalGaussWeapon) {
      super();
      this.weapon = param1;
      this.initStateMachine();
    }

    private function initStateMachine() : void {
      this.states[GaussAimState.LOCKING] = new LockingState(this.weapon,this);
      this.states[GaussAimState.CANCELLED] = new CancelledState(this.weapon);
      this.states[GaussAimState.REGAIN_LOCK] = new RegainLockState(this.weapon,this);
      this.states[GaussAimState.TARET_LOCKED] = new TargetLockedState(this.weapon);
      this.states[GaussAimState.TARGET_SEARCH] = new TargetSearchState(this.weapon,this);
      this.transitions = Vector.<AimTransition>([this.createTransition(GaussAimState.TARGET_SEARCH,GaussAimEventType.TARGET_FOUND,GaussAimState.LOCKING),this.createTransition(GaussAimState.TARGET_SEARCH,GaussAimEventType.DEACTIVATED,GaussAimState.CANCELLED),this.createTransition(GaussAimState.LOCKING,GaussAimEventType.TARGET_LOCKED,GaussAimState.TARET_LOCKED),this.createTransition(GaussAimState.LOCKING,GaussAimEventType.TARGET_LOCK_LOST,GaussAimState.REGAIN_LOCK),this.createTransition(GaussAimState.LOCKING,GaussAimEventType.DEACTIVATED,GaussAimState.CANCELLED),this.createTransition(GaussAimState.REGAIN_LOCK,GaussAimEventType.TARGET_FOUND,GaussAimState.LOCKING),this.createTransition(GaussAimState.REGAIN_LOCK,GaussAimEventType.TARGET_LOCK_FAILED,GaussAimState.TARGET_SEARCH),this.createTransition(GaussAimState.REGAIN_LOCK,GaussAimEventType.DEACTIVATED,GaussAimState.CANCELLED)]);
    }

    public function processEvent(param1:GaussAimEventType, param2:* = undefined) : void {
      var local3:AimTransition = null;
      for each(local3 in this.transitions) {
        if(local3.eventType == param1 && local3.state == this.currentState) {
          this.currentState = local3.newState;
          this.currentState.enter(this.weapon.getTime(),param1,param2);
          return;
        }
      }
      throw new Error("Transition not found (currentState: " + this.currentState + ", eventType:" + " " + param1);
    }

    private function createTransition(param1:GaussAimState, param2:GaussAimEventType, param3:GaussAimState) : AimTransition {
      return new AimTransition(param2,this.states[param1],this.states[param3]);
    }

    public function enter(param1:int, param2:GaussEventType, param3:*) : void {
      this.currentState = this.states[GaussAimState.TARGET_SEARCH];
      this.currentState.enter(this.weapon.getTime(),GaussAimEventType.RESET,param3);
      this.weapon.startAiming();
    }

    public function update(param1:int, param2:int) : void {
      if(this.weapon.isBuffed()) {
        this.weapon.stopAiming();
        this.weapon.hideAim();
        this.weapon.processEvent(GaussEventType.DEACTIVATED);
        return;
      }
      this.currentState.update(param1,param2);
    }
  }
}
