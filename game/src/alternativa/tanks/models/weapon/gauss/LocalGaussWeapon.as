package alternativa.tanks.models.weapon.gauss {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.LocalWeapon;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.gauss.state.GaussState;
  import alternativa.tanks.models.weapon.gauss.state.IGaussState;
  import alternativa.tanks.models.weapon.gauss.state.IdleState;
  import alternativa.tanks.models.weapon.gauss.state.ModeSelectionState;
  import alternativa.tanks.models.weapon.gauss.state.PowerShotState;
  import alternativa.tanks.models.weapon.gauss.state.ReloadPauseState;
  import alternativa.tanks.models.weapon.gauss.state.ReloadState;
  import alternativa.tanks.models.weapon.gauss.state.SimpleShotState;
  import alternativa.tanks.models.weapon.gauss.state.StunnedState;
  import alternativa.tanks.models.weapon.gauss.state.TargetSelectionState;
  import alternativa.tanks.models.weapon.gauss.state.Transition;
  import alternativa.tanks.models.weapon.gauss.state.TransitionNotFoundError;
  import alternativa.tanks.models.weapon.gauss.state.targetselection.LockResult;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim.AimWeaponStatus;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim.RocketLauncherAim;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.GaussCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class LocalGaussWeapon extends CommonGaussWeapon implements Weapon, LocalWeapon, LogicUnit, AimWeaponStatus {
    private static var shotId:int = 0;

    private static const rayHit:RayHit = new RayHit();

    private var triggerPulled:Boolean = false;
    private var gaussData:GaussCC;
    private var states:Dictionary;
    private var currentState:IGaussState;
    private var transitions:Vector.<Transition>;
    private var controller:SimpleWeaponController;
    private var _weaponStatus:Number = 1;
    private var _buffed:Boolean;
    private var callback:GaussWeaponCallback;
    private var targetingSystem:TargetingSystem;
    private var secondaryHitPoint:Vector3 = new Vector3();
    private var target:RocketTargetPoint = new RocketTargetPoint();
    private var aim:RocketLauncherAim;

    public function LocalGaussWeapon(param1:WeaponObject, param2:GaussCC, param3:TargetingSystem, param4:WeaponForces) {
      this.callback = GaussWeaponCallback(param1.getObject().adapt(GaussWeaponCallback));
      super(param1,param2,this.callback);
      this.gaussData = param2;
      this.primaryWeaponForces = param4;
      this.targetingSystem = param3;
      this.controller = new SimpleWeaponController();
      this.controller.setWeapon(this);
    }

    override public function init(param1:WeaponPlatform) : void {
      super.init(param1);
      this.weaponPlatform = param1;
      this.aim = new RocketLauncherAim(this.target,this,effects);
      this.initStateMachine();
      this.controller.init();
    }

    public function processEvent(param1:GaussEventType, param2:* = undefined) : void {
      var local3:Transition = null;
      for each(local3 in this.transitions) {
        if(local3.eventType == param1 && local3.state == this.currentState) {
          this.currentState = local3.newState;
          this.currentState.enter(battleService.getPhysicsTime(),param1,param2);
          return;
        }
      }
      throw new TransitionNotFoundError(this.currentState,param1);
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.GAUSS_RESISTANCE;
    }

    private function createTransition(param1:GaussState, param2:GaussEventType, param3:GaussState) : Transition {
      return new Transition(param2,this.states[param1],this.states[param3]);
    }

    private function initStateMachine() : void {
      this.states = new Dictionary();
      this.states[GaussState.IDLE] = new IdleState(this);
      this.states[GaussState.RELOAD] = new ReloadState(this);
      this.states[GaussState.STUNNED] = new StunnedState(this);
      this.states[GaussState.POWER_SHOT] = new PowerShotState(this);
      this.states[GaussState.SIMPLE_SHOT] = new SimpleShotState(this);
      this.states[GaussState.RELOAD_PAUSE] = new ReloadPauseState(this);
      this.states[GaussState.MODE_SELECTION] = new ModeSelectionState(this);
      this.states[GaussState.TARGET_SELECTION] = new TargetSelectionState(this);
      this.currentState = this.states[GaussState.IDLE];
      this.transitions = Vector.<Transition>([this.createTransition(GaussState.IDLE,GaussEventType.ACTIVATED,GaussState.MODE_SELECTION),this.createTransition(GaussState.IDLE,GaussEventType.STUNNED,GaussState.STUNNED),this.createTransition(GaussState.STUNNED,GaussEventType.STUN_EXPIRED,GaussState.IDLE),this.createTransition(GaussState.MODE_SELECTION,GaussEventType.TARGET_SEARCH_STARTED,GaussState.TARGET_SELECTION),this.createTransition(GaussState.MODE_SELECTION,GaussEventType.SIMPLE_SHOT,GaussState.SIMPLE_SHOT),this.createTransition(GaussState.MODE_SELECTION,GaussEventType.STUNNED,GaussState.STUNNED),this.createTransition(GaussState.TARGET_SELECTION,GaussEventType.TARGET_LOCKED,GaussState.POWER_SHOT),this.createTransition(GaussState.TARGET_SELECTION,GaussEventType.DEACTIVATED,GaussState.IDLE),this.createTransition(GaussState.TARGET_SELECTION,GaussEventType.BUFFED,GaussState.IDLE),this.createTransition(GaussState.TARGET_SELECTION,GaussEventType.STUNNED,GaussState.STUNNED),this.createTransition(GaussState
      .SIMPLE_SHOT,GaussEventType.RELOAD,GaussState.RELOAD),this.createTransition(GaussState.POWER_SHOT,GaussEventType.RELOAD,GaussState.RELOAD),this.createTransition(GaussState.RELOAD,GaussEventType.RELOAD_COMPLETED,GaussState.IDLE),this.createTransition(GaussState.RELOAD,GaussEventType.BUFF_EXPIRED,GaussState.IDLE),this.createTransition(GaussState.RELOAD,GaussEventType.STUNNED,GaussState.RELOAD_PAUSE),this.createTransition(GaussState.RELOAD_PAUSE,GaussEventType.STUN_EXPIRED,GaussState.RELOAD)]);
    }

    public function set weaponStatus(param1:Number) : void {
      this._weaponStatus = param1;
    }

    public function isTriggerPulled() : Boolean {
      return this.triggerPulled;
    }

    public function destroy() : void {
      this.controller.destroy();
      weaponPlatform = null;
      battleService.getBattleRunner().removeLogicUnit(this);
    }

    public function activate() : void {
      battleService.getBattleRunner().addLogicUnit(this);
    }

    public function deactivate() : void {
      battleService.getBattleRunner().removeLogicUnit(this);
    }

    public function stun() : void {
      if(this.isTargetSelection()) {
        this.stopAiming();
      }
      this.hideAim();
      this.processEvent(GaussEventType.STUNNED);
    }

    private function isTargetSelection() : Boolean {
      return this.currentState == this.states[GaussState.TARGET_SELECTION];
    }

    private function isIdle() : Boolean {
      return this.currentState == this.states[GaussState.IDLE];
    }

    private function isReload() : Boolean {
      return this.currentState == this.states[GaussState.RELOAD];
    }

    public function calm(param1:int) : void {
      this.processEvent(GaussEventType.STUN_EXPIRED);
    }

    public function reset() : void {
      this.hideAim();
      if(!this.isIdle()) {
        this.currentState = this.states[GaussState.IDLE];
      }
      this.currentState.enter(battleService.getPhysicsTime(),GaussEventType.RESET,null);
      effects.reset();
    }

    public function getStatus() : Number {
      return this._weaponStatus;
    }

    public function fullyRecharge() : void {
      if(!this.isTargetSelection()) {
        this._weaponStatus = 1;
      }
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      if(this.isReload()) {
        ReloadState(this.states[GaussState.RELOAD]).setReloadDuration(param2);
      }
    }

    public function pullTrigger() : void {
      this.triggerPulled = true;
    }

    public function releaseTrigger() : void {
      this.triggerPulled = false;
    }

    public function runLogic(param1:int, param2:int) : void {
      if(enabled || this.isReload()) {
        this.currentState.update(param1,param2);
      }
    }

    public function getTime() : int {
      return battleService.getPhysicsTime();
    }

    public function isShotAllowed() : Boolean {
      return true;
    }

    public function isBuffed() : Boolean {
      return this._buffed;
    }

    private function barrelCollidesWithStatic(param1:Vector3, param2:Vector3, param3:Number) : Boolean {
      return battleService.getBattleRunner().getCollisionDetector().raycastStatic(param1,param2,CollisionGroup.STATIC,param3,null,rayHit);
    }

    public function getPrimaryReloadDuration() : int {
      return weaponObject.getReloadTimeMS();
    }

    public function lockTarget(param1:LockResult, param2:Long = null) : Boolean {
      var local3:TargetingResult = null;
      var local4:RayHit = null;
      var local5:Tank = null;
      var local6:Long = null;
      var local7:Vector3 = null;
      weaponPlatform.getAllGunParams(gunParams);
      if(!this.isCollideStatic() && BattleUtils.isTurretAboveGround(weaponPlatform.getBody(),gunParams)) {
        local3 = this.targetingSystem.target(gunParams);
        if(local3.hasTankHit()) {
          local4 = local3.getSingleHit();
          local5 = local4.shape.body.tank;
          local6 = local5.getUser().id;
          if((param2 == null || param2 == local6) && local5.state == ClientTankState.ACTIVE && !local5.isSameTeam(weaponPlatform.teamType)) {
            local7 = this.getTargetLocalPoint(local4,local5);
            this.target.setTank(local5);
            this.target.setLocalPoint(local7);
            param1.update(local6,local4.position,local7);
            return true;
          }
        }
      }
      this.target.markAsLost();
      return false;
    }

    private function getTargetLocalPoint(param1:RayHit, param2:Tank) : Vector3 {
      var local3:Vector3 = BattleUtils.tmpVector;
      local3.copy(param1.position);
      BattleUtils.globalToLocal(param2.getBody(),local3);
      return local3;
    }

    public function getMaxLockRegainTimeMs() : int {
      return this.gaussData.aimingGracePeriod;
    }

    public function getTargetLockDurationMs() : int {
      return this.gaussData.aimingTime;
    }

    private function isCollideStatic() : Boolean {
      return this.barrelCollidesWithStatic(gunParams.barrelOrigin,gunParams.direction,weaponPlatform.getBarrelLength());
    }

    public function doPrimaryShot() : void {
      if(!battleService.isBattleActive()) {
        return;
      }
      weaponPlatform.getAllGunParams(gunParams);
      effects.playSoundEffect(sfxData.primaryShotSound,gunParams.muzzlePosition);
      if(!BattleUtils.isTurretAboveGround(weaponPlatform.getBody(),gunParams)) {
        this.callback.doDummyShot();
        weaponPlatform.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-primaryWeaponForces.getRecoilForce());
        return;
      }
      var local1:Vector3 = this.targetingSystem.target(gunParams).getDirection();
      this.callback.doPrimaryShot(++shotId,local1);
      effects.playCommonShotEffect(gunParams.muzzlePosition,local1,primaryWeaponForces);
      getShell().addToGame(gunParams,local1,weaponPlatform.getBody(),false,shotId);
    }

    public function doSecondaryShot() : void {
      effects.playTargetLockSoundEffect();
      if(!battleService.isBattleActive() || !this.target.hasTarget()) {
        return;
      }
      weaponPlatform.getAllGunParams(gunParams);
      var local1:Tank = this.target.getTank();
      this.callback.doSecondaryShot(local1.user,local1.getBody().state.position,this.target.getLocalPoint());
      this.secondaryHitPoint.copy(this.target.getLocalPoint());
      BattleUtils.localToGlobal(local1.getBody(),this.secondaryHitPoint);
      var local2:Vector3 = new Vector3().copy(this.secondaryHitPoint).subtract(gunParams.muzzlePosition).normalize();
      effects.playCommonShotEffect(gunParams.muzzlePosition,local2,secondaryWeaponForces);
      effects.playPowerShotEffect(local1.getBody(),this.secondaryHitPoint);
      local1.applyWeaponHit(this.secondaryHitPoint,gunParams.direction,secondaryWeaponForces.getImpactForce());
      applySecondarySplashImpact(this.secondaryHitPoint,local1.getBody());
    }

    public function getPowerShotReloadDurationMs() : Number {
      return this.gaussData.powerShotReloadDurationMs;
    }

    override public function disable(param1:Boolean) : void {
      super.disable(param1);
      if(this.isTargetSelection()) {
        this.stopAiming();
        this._weaponStatus = 1;
        this.currentState = this.states[GaussState.IDLE];
      }
      this.hideAim();
    }

    public function showAim() : void {
      this.aim.show();
    }

    public function hideAim() : void {
      this.target.resetTarget();
      this.aim.hide();
    }

    public function startAiming() : void {
      this.callback.doStartAiming();
      effects.playOpenEffect();
    }

    public function stopAiming() : void {
      this.callback.doStopAiming();
      effects.playHideEffect();
    }

    public function setBuffedMode(param1:Boolean) : void {
      this._buffed = param1;
      if(!param1 && this.isReload()) {
        this.processEvent(GaussEventType.BUFF_EXPIRED);
      }
    }
  }
}
