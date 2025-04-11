package alternativa.tanks.models.weapon.shaft {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.math.Matrix3;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.PhysicsInterpolator;
  import alternativa.tanks.battle.objects.tank.LocalWeapon;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.CameraFovCalculator;
  import alternativa.tanks.battle.scene3d.Object3DNames;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAngles;
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import alternativa.tanks.models.weapon.shaft.cameracontrollers.AimingActivationCameraController;
  import alternativa.tanks.models.weapon.shaft.cameracontrollers.AimingCameraController;
  import alternativa.tanks.models.weapon.shaft.sfx.Indicator;
  import alternativa.tanks.models.weapon.shaft.states.IShaftState;
  import alternativa.tanks.models.weapon.shaft.states.ITransitionHandler;
  import alternativa.tanks.models.weapon.shaft.states.IdleState;
  import alternativa.tanks.models.weapon.shaft.states.ManualTargetingActivationState;
  import alternativa.tanks.models.weapon.shaft.states.ManualTargetingState;
  import alternativa.tanks.models.weapon.shaft.states.ReadyToShootState;
  import alternativa.tanks.models.weapon.shaft.states.ShaftTargetPoint;
  import alternativa.tanks.models.weapon.shaft.states.Transition;
  import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.ManualTargetingActivationStopHandler;
  import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.ManualTargetingActivationTriggerReleaseHandler;
  import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.ManualTargetingStopHandler;
  import alternativa.tanks.models.weapon.shaft.states.transitionhandlers.QuickShotHandler;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;
  import alternativa.tanks.utils.MathUtils;
  import alternativa.tanks.utils.SetControllerForTemporaryItems;
  import alternativa.utils.removeDisplayObject;
  import flash.display.BitmapData;
  import flash.display.DisplayObjectContainer;
  import flash.geom.Point;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class ShaftWeapon extends BattleRunnerProvider implements Weapon, LocalWeapon, LogicUnit, PhysicsInterpolator {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    private static const MAX_DIRECTION_DELTA:Number = MathUtils.toRadians(15);
    private static const MAX_SPOT_SCALE:Number = 8;
    private static const MIN_SPOT_SCALE:Number = 1;
    private static const MAX_SPOT_DISTANCE:Number = 5000;
    private static const MIN_SPOT_DISTANCE:Number = 50;
    private static const SPOT_SCALE_DISTANCE:Number = MAX_SPOT_DISTANCE - MIN_SPOT_DISTANCE;
    private static const SPOT_SCALE:Number = MAX_SPOT_SCALE - MIN_SPOT_SCALE;
    private static const SWITCH_INTERVAL:int = 200;
    private static const INDICATOR_SHIFT:Number = 9;
    private static const _origin:Vector3 = new Vector3();
    private static const _direction:Vector3 = new Vector3();
    private static const _m:Matrix4 = new Matrix4();
    private static const _m3:Matrix3 = new Matrix3();
    private static const _p:Vector3 = new Vector3();
    private static const _barrelOrigin:Vector3 = new Vector3();
    private static const _closestBarrelOrigin:Vector3 = new Vector3();
    private static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private static const _aimDirection:Vector3 = new Vector3();
    private static const _targetPoint:ShaftTargetPoint = new ShaftTargetPoint();
    private static const INDICATOR_OFFSET:int = 75;

    private var laser:LaserPointer;
    private var callback:IShaftWeaponCallback;
    private var effects:ShaftEffects;
    private var targetingSystem:TargetingSystem;
    private var shaftData:ShaftCC;
    private var weaponForces:WeaponForces;
    private var triggerPulled:Boolean = false;
    private var object3DToTank:Dictionary = new Dictionary();
    private var weaponPlatform:WeaponPlatform;
    private var states:Dictionary;
    private var currentState:IShaftState;
    private var transitions:Vector.<Transition>;
    private var energy:EncryptedNumber = new EncryptedNumberImpl();
    private var energyChangeRate:EncryptedNumber = new EncryptedNumberImpl();
    private var energyMode:ShaftEnergyMode = ShaftEnergyMode.RECHARGE;
    private var aimingActivationEnergy:Number = 0;
    private var deactivationTask:ShaftDeactivationTask;
    private var enabled:Boolean;
    private var reloadTimeMS:int;
    private var reloadFinishTime:int;
    private var team:BattleTeam;
    private var exclusionSetController:SetControllerForTemporaryItems;
    private var exclusionSet:Dictionary;
    private var speedCharacteristics:SpeedCharacteristics;
    private var weakening:DistanceWeakening;
    private var reticleDisplay:ReticleDisplay;
    private var titleIndicator:Indicator = new Indicator();
    private var shaftObject:ShaftObject;
    private var normalTurnAcceleration:Number = 0;
    private var aimingActivationCameraController:AimingActivationCameraController;
    private var aimingCameraController:AimingCameraController;
    private var skinAlphaInterpolator:LinearInterpolator = new LinearInterpolator();
    private var indicatorAlphaInterpolator:LinearInterpolator = new LinearInterpolator();
    private var indicatorInterpolatorX:LinearInterpolator = new LinearInterpolator();
    private var indicatorInterpolatorY:LinearInterpolator = new LinearInterpolator();
    private var rangeInterpolator:LinearInterpolator = new LinearInterpolator();
    private var verticalAngles:VerticalAngles;
    private var aimingListener:ShaftAimingStateListener;
    private var aimingType:ShaftAimingType = ShaftAimingType.DIRECTIONAL;
    private var prevElevation:Number = 0;
    private var elevation:Number = 0;
    private var targetElevation:Number = 0;
    private var interpolatedElevation:Number = 0;
    private var prevElevationDirection:Number = 0;
    private var elevationDirection:Number = 0;
    private var elevationSpeed:Number = 0;
    private var isElevationPaused:Boolean = false;
    private var targetDirection:Number = 0;
    private var aimingModeSpeedMultiplier:Number = 1;
    private var isChargingEffectActive:Boolean = false;
    private var aimedModeLocked:Boolean = false;
    private var stunned:Boolean = false;
    private var stunStatus:Number = 0;

    public function ShaftWeapon(param1:ShaftObject, param2:IShaftWeaponCallback, param3:ShaftCC, param4:VerticalAngles, param5:WeaponForces, param6:Dictionary, param7:IGameObject, param8:TargetingSystem, param9:DistanceWeakening) {
      super();
      this.shaftObject = param1;
      this.laser = param1.laser();
      this.reloadTimeMS = param1.getReloadTimeMS();
      this.callback = param2;
      this.effects = param1.getEffects();
      this.targetingSystem = param8;
      this.shaftData = param3;
      this.verticalAngles = param4;
      this.weaponForces = param5;
      this.object3DToTank = param6;
      this.speedCharacteristics = SpeedCharacteristics(param7.adapt(SpeedCharacteristics));
      this.weakening = param9;
      var local10:BattleScene3D = battleService.getBattleScene3D();
      this.deactivationTask = new ShaftDeactivationTask(local10);
      this.exclusionSet = local10.getShaftRaycastExcludedObjects();
      this.exclusionSetController = new SetControllerForTemporaryItems(this.exclusionSet);
      this.energy.setNumber(param3.maxEnergy);
      var local11:uint = uint(this.shaftObject.laser().getLaserPointerRedColor());
      this.reticleDisplay = new ReticleDisplay(param3.reticleImage,local11);
      this.rangeInterpolator.setInterval(param3.shrubsHidingRadiusMin,param3.shrubsHidingRadiusMax);
    }

    private static function getClosestBarrelOrigin(param1:Vector3, param2:Vector.<Vector3>, param3:Vector3) : void {
      var local6:Number = NaN;
      _barrelOrigin.copy(param2[0]);
      _barrelOrigin.y = 0;
      param3.copy(_barrelOrigin);
      var local4:Number = param1.distanceToSquared(_barrelOrigin);
      var local5:int = 1;
      while(local5 < param2.length) {
        _barrelOrigin.copy(param2[local5]);
        _barrelOrigin.y = 0;
        local6 = param1.distanceToSquared(_barrelOrigin);
        if(local6 < local4) {
          local4 = local6;
          param3.copy(_barrelOrigin);
        }
        local5++;
      }
    }

    public function getAimingModeEnergyFraction() : Number {
      return (this.aimingActivationEnergy - this.getEnergy()) / this.getMaxEnergy();
    }

    public function setAimingListener(param1:ShaftAimingStateListener) : void {
      this.aimingListener = param1;
    }

    private function get weaponMount() : WeaponMount {
      return this.weaponPlatform.getWeaponMount();
    }

    public function startIdleState() : void {
      this.setEnergyMode(ShaftEnergyMode.RECHARGE);
      this.weaponPlatform.getWeaponMount().setMaxTurnSpeed(this.speedCharacteristics.getMaxTurretTurnSpeed(),false);
      this.weaponPlatform.getWeaponMount().setTurnAcceleration(this.normalTurnAcceleration);
      battleService.activateFollowCamera();
    }

    public function startAimingActivation() : void {
      this.weaponPlatform.stopMovement();
      this.weaponPlatform.lockMovement(true);
      this.weaponPlatform.enableTurretSound(false);
      this.weaponMount.setTurnAcceleration(this.shaftData.targetingAcceleration);
      this.weaponMount.setMaxTurnSpeed(this.shaftData.horizontalTargetingSpeed * this.speedCharacteristics.getTurretRotationCoefficient(),false);
      this.aimingActivationEnergy = this.getEnergy();
      this.setEnergyMode(ShaftEnergyMode.DRAIN);
      battleService.getBattleScene3D().setCameraController(this.aimingActivationCameraController);
      this.skinAlphaInterpolator.setInterval(this.weaponPlatform.getSkin().getHullAlpha(),0);
      this.initTitleIndicator();
      this.isChargingEffectActive = true;
      this.effects.createManualModeEffects(this.weaponPlatform.getTurret3D());
    }

    public function setAimingActivationProgress(param1:Number) : void {
      this.setIndicatorPosition(this.indicatorInterpolatorX.interpolate(param1),this.indicatorInterpolatorY.interpolate(param1));
      this.titleIndicator.alpha = this.indicatorAlphaInterpolator.interpolate(param1);
      var local2:Number = this.skinAlphaInterpolator.interpolate(param1);
      this.weaponPlatform.getSkin().setAlpha(local2);
    }

    public function getAimDirection(param1:Vector3) : void {
      this.weaponPlatform.getAllGunParams(gunParams);
      _m3.fromAxisAngle(gunParams.elevationAxis,this.interpolatedElevation);
      _m3.transformVector(gunParams.direction,param1);
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      this.aimingActivationCameraController = new AimingActivationCameraController(param1,this.shaftData.targetingTransitionTime,this.shaftData.initialFOV);
      this.aimingCameraController = new AimingCameraController(this,param1,this.shaftData.initialFOV,this.shaftData.minimumFOV);
      this.deactivationTask.setSkin(param1.getSkin());
      this.team = this.getTank().teamType;
      this.normalTurnAcceleration = param1.getWeaponMount().getTurnAcceleration();
      this.initStateMachine();
    }

    public function destroy() : void {
      this.shaftObject = null;
      this.laser = null;
      this.callback = null;
      this.effects = null;
      this.targetingSystem = null;
      this.shaftData = null;
      this.weaponForces = null;
      this.object3DToTank = null;
      this.speedCharacteristics = null;
      this.weakening = null;
      this.currentState.exit();
      this.deactivationTask.stop();
    }

    public function activate() : void {
      getBattleRunner().addLogicUnit(this);
      getBattleRunner().addPhysicsInterpolator(this);
    }

    public function deactivate() : void {
      getBattleRunner().removeLogicUnit(this);
      getBattleRunner().removePhysicsInterpolator(this);
    }

    public function enable() : void {
      if(!this.enabled) {
        this.enabled = true;
        this.currentState.enter(battleService.getPhysicsTime());
      }
    }

    public function disable(param1:Boolean) : void {
      if(this.enabled) {
        this.enabled = false;
        this.processEvent(ShaftEventType.STOP,param1);
      }
    }

    public function reset() : void {
      var local1:int = int(battleService.getPhysicsTime());
      if(this.currentState != this.states[ShaftState.IDLE]) {
        this.currentState.exit();
        this.currentState = this.states[ShaftState.IDLE];
      }
      var local2:BattleTeam = this.getTank().teamType;
      if(this.team != local2) {
        this.team = local2;
        this.reticleDisplay.changeLaserSpotColor(this.getColorForTeam(this.team));
      }
      this.currentState.enter(local1);
      this.doSetEnergyMode(ShaftEnergyMode.RECHARGE,this.shaftData.maxEnergy,local1);
    }

    private function getTank() : Tank {
      return this.weaponPlatform.getBody().tank;
    }

    public function getStatus() : Number {
      return this.stunned ? this.stunStatus : this.getEnergy() / this.shaftData.maxEnergy;
    }

    public function pullTrigger() : void {
      this.triggerPulled = true;
      if(this.enabled) {
        this.currentState.processEvent(ShaftEventType.TRIGGER_PULL,null);
      }
    }

    public function releaseTrigger() : void {
      this.triggerPulled = false;
      if(this.enabled) {
        this.currentState.processEvent(ShaftEventType.TRIGGER_RELEASE,null);
      }
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:Number = NaN;
      if(this.enabled) {
        this.currentState.update(param1,param2);
      }
      if(!this.stunned) {
        local3 = MathUtils.clamp(this.energy.getNumber() + this.energyChangeRate.getNumber() * 0.001 * param2,0,this.shaftData.maxEnergy);
        this.energy.setNumber(local3);
      }
    }

    public function interpolatePhysicsState(param1:Number, param2:int) : void {
      this.interpolatedElevation = this.prevElevation + param1 * (this.elevation - this.prevElevation);
    }

    public function isTriggerPulled() : Boolean {
      return this.triggerPulled;
    }

    private function setEnergyMode(param1:ShaftEnergyMode) : void {
      var local2:Number = NaN;
      if(param1 != this.energyMode) {
        local2 = this.getEnergy();
        this.doSetEnergyMode(param1,local2,battleService.getPhysicsTime());
      }
    }

    public function processEvent(param1:ShaftEventType, param2:* = undefined) : void {
      var local3:Transition = null;
      for each(local3 in this.transitions) {
        if(local3.eventType == param1 && local3.state == this.currentState) {
          this.currentState.exit();
          if(local3.handler != null) {
            local3.handler.execute(param2);
          }
          this.currentState = local3.newState;
          this.currentState.enter(battleService.getPhysicsTime());
          return;
        }
      }
      throw new TransitionNotFoundError(this.currentState,param1);
    }

    public function getEnergy() : Number {
      return this.energy.getNumber();
    }

    public function setIndicatorPosition(param1:int, param2:int) : void {
      this.titleIndicator.x = param1 + INDICATOR_SHIFT;
      this.titleIndicator.y = param2;
    }

    private function getColorForTeam(param1:BattleTeam) : uint {
      switch(param1) {
        case BattleTeam.BLUE:
          return this.shaftObject.laser().getLaserPointerBlueColor();
        case BattleTeam.RED:
          return this.shaftObject.laser().getLaserPointerRedColor();
        default:
          return this.shaftObject.laser().getLaserPointerRedColor();
      }
    }

    public function startAimingState() : void {
      this.setEnergyMode(ShaftEnergyMode.DRAIN);
      this.elevationSpeed = 0;
      this.prevElevationDirection = 0;
      this.elevationDirection = 0;
      this.prevElevation = 0;
      this.elevation = 0;
      this.interpolatedElevation = 0;
      this.targetElevation = 0;
      this.targetDirection = this.weaponMount.getTurretInterpolatedDirection();
      this.updateAimingModeSpeedMultiplier(1);
      this.deactivationTask.stop();
      this.callback.onManualTargetingStart();
      this.callback.enteredInManualMode();
      var local1:BattleScene3D = battleService.getBattleScene3D();
      local1.enableObjectHiding();
      local1.hidableGraphicObjects.setCenterAndRadius(this.weaponPlatform.getBody().state.position,0);
      battleService.getBattleScene3D().setCameraController(this.aimingCameraController);
      if(this.aimingListener != null) {
        this.aimingListener.onAimingStart();
      }
    }

    public function updateAimingState(param1:int, param2:int) : void {
      var local3:Number = 0.001 * param2;
      var local4:Number = this.getEnergy();
      if(local4 == 0 && this.isChargingEffectActive) {
        this.isChargingEffectActive = false;
        this.effects.fadeChargingEffect();
      }
      var local5:Number = this.getAimingModeEnergyFraction();
      this.updateAimingModeSpeedMultiplier(local5);
      this.updateLaserPointer();
      this.hideObjectsInRange(this.rangeInterpolator.interpolate(local5));
      switch(this.aimingType) {
        case ShaftAimingType.DIRECTIONAL:
          this.updateDirectionalAiming(local3);
          break;
        case ShaftAimingType.MOUSE:
          this.updateMouseAiming(local3);
      }
      this.effects.playTargetingSound(this.elevationSpeed != 0 || Boolean(this.weaponMount.isRotating()));
    }

    private function updateLaserPointer() : void {
      var local1:GameCamera = null;
      var local2:Number = NaN;
      this.getAimDirection(_aimDirection);
      if(this.calculateTargetPoint(_aimDirection,_targetPoint)) {
        local1 = battleService.getBattleScene3D().getCamera();
        local2 = Vector3.distanceBetween(local1.position,_targetPoint.getGlobalPoint());
        this.setLaserPointerScale(this.calculateSpotScale(local2));
      } else {
        this.setLaserPointerScale(MIN_SPOT_SCALE);
      }
      if(_targetPoint.hasTank()) {
        this.getLaser().aimAtTank(_targetPoint.getTank(),_targetPoint.getLocalPoint());
      } else {
        this.getLaser().updateDirection(_aimDirection);
      }
      _targetPoint.reset();
    }

    private function calculateSpotScale(param1:Number) : Number {
      if(param1 < MIN_SPOT_DISTANCE) {
        return MAX_SPOT_SCALE;
      }
      if(param1 > MAX_SPOT_DISTANCE) {
        return MIN_SPOT_SCALE;
      }
      var local2:Number = param1 - MIN_SPOT_DISTANCE;
      return (1 - local2 / SPOT_SCALE_DISTANCE) * SPOT_SCALE + MIN_SPOT_SCALE;
    }

    private function updateDirectionalAiming(param1:Number) : void {
      var local3:Number = NaN;
      if(this.prevElevationDirection != this.elevationDirection) {
        this.prevElevationDirection = this.elevationDirection;
        this.elevationSpeed = 0;
      }
      this.prevElevation = this.elevation;
      var local2:Number = this.elevationSpeed * param1;
      this.elevation = MathUtils.clamp(this.elevation + local2,-this.verticalAngles.getAngleDown(),this.verticalAngles.getAngleUp());
      if(this.elevationDirection > 0 && this.elevation == this.verticalAngles.getAngleUp() || this.elevationDirection < 0 && this.elevation == -this.verticalAngles.getAngleDown()) {
        this.elevationSpeed = 0;
      } else {
        local3 = this.getCurrentMaxElevationSpeed();
        this.elevationSpeed = MathUtils.clamp(this.elevationSpeed + this.elevationDirection * this.shaftData.targetingAcceleration * param1,-local3,local3);
      }
    }

    private function updateMouseAiming(param1:Number) : void {
      var local2:Number = NaN;
      this.prevElevation = this.elevation;
      if(this.isElevationPaused) {
        this.elevationSpeed = 0;
        this.elevationDirection = 0;
      } else {
        local2 = this.targetElevation - this.elevation;
        if(local2 == 0) {
          this.elevationSpeed = 0;
          return;
        }
        this.elevationDirection = MathUtils.sign(local2);
        if(this.elevationDirection != this.prevElevationDirection) {
          this.prevElevationDirection = this.elevationDirection;
          this.elevationSpeed = 0;
        }
        this.elevation = MathUtils.moveValueTowards(this.elevation,this.targetElevation,this.elevationSpeed * param1);
        this.elevationSpeed = MathUtils.moveValueTowards(this.elevationSpeed,this.getCurrentMaxElevationSpeed(),this.shaftData.targetingAcceleration * param1);
      }
    }

    private function getCurrentMaxElevationSpeed() : Number {
      return this.aimingModeSpeedMultiplier * this.speedCharacteristics.getTurretRotationCoefficient() * this.shaftData.verticalTargetingSpeed;
    }

    private function updateAimingModeSpeedMultiplier(param1:Number) : void {
      this.aimingModeSpeedMultiplier = this.calculateAimingModelSpeedMultiplier(param1);
      this.weaponMount.setMaxTurnSpeed(this.aimingModeSpeedMultiplier * this.speedCharacteristics.getTurretRotationCoefficient() * this.shaftData.horizontalTargetingSpeed,false);
    }

    private function calculateAimingModelSpeedMultiplier(param1:Number) : Number {
      var local2:Number = this.shaftData.rotationCoeffT1;
      if(param1 < local2) {
        return 1;
      }
      var local3:Number = this.shaftData.rotationCoeffT2;
      var local4:Number = this.shaftData.rotationCoeffKmin;
      if(param1 < local3) {
        return 1 - (1 - local4) * (param1 - local2) / (local3 - local2);
      }
      return local4;
    }

    public function stopAiming() : void {
      removeDisplayObject(this.titleIndicator);
      this.isElevationPaused = false;
      this.weaponPlatform.lockMovement(false);
      this.weaponPlatform.enableTurretSound(true);
      battleService.activateFollowCamera();
      battleService.getBattleScene3D().disableObjectHiding();
      this.weaponPlatform.showTitle();
      var local1:Number = Number(battleService.getBattleView().getWidth());
      var local2:Number = Number(battleService.getBattleView().getHeight());
      this.deactivationTask.setTargetFov(CameraFovCalculator.getCameraFov(local1,local2));
      this.deactivationTask.start();
      this.effects.playTargetingSound(false);
      this.effects.stopManualTargetingEffects();
      this.getLaser().hideLaser();
      if(this.aimingListener != null) {
        this.aimingListener.onAimingStop();
      }
    }

    public function setAimingType(param1:ShaftAimingType) : void {
      if(this.aimingType != param1) {
        this.aimingType = param1;
        this.prevElevationDirection = 0;
        this.elevationDirection = 0;
        this.elevationSpeed = 0;
        switch(param1) {
          case ShaftAimingType.DIRECTIONAL:
            break;
          case ShaftAimingType.MOUSE:
            this.targetElevation = this.interpolatedElevation;
            this.targetDirection = this.weaponPlatform.getWeaponMount().getTurretInterpolatedDirection();
        }
      }
      this.aimingCameraController.setAimingType(param1);
    }

    public function setElevationDirecton(param1:Number) : void {
      this.elevationDirection = param1;
    }

    public function isBarrelOriginInsideStaticGeometry() : Boolean {
      var local3:Object3D = null;
      this.weaponPlatform.getAllGunParams(gunParams);
      var local1:Vector3 = this.weaponPlatform.getBody().state.position;
      _direction.diff(gunParams.barrelOrigin,local1);
      var local2:RayIntersectionData = battleService.getBattleScene3D().raycast(local1,_direction,battleService.getExcludedObjects3D());
      if(local2 != null && local2.time <= 1) {
        local3 = local2.object;
        return local3.name == Object3DNames.STATIC;
      }
      return false;
    }

    public function getMaxEnergy() : Number {
      return this.shaftData.maxEnergy;
    }

    public function hideObjectsInRange(param1:Number) : void {
      var local2:BattleScene3D = battleService.getBattleScene3D();
      local2.hidableGraphicObjects.setCenterAndRadius(this.weaponPlatform.getBody().state.position,param1);
    }

    public function performAimedShot() : void {
      var local3:Number = NaN;
      var local1:int = int(battleService.getPhysicsTime());
      this.effects.stopManualTargetingEffects();
      this.weaponPlatform.getAllGunParams(gunParams);
      this.getAimDirection(_aimDirection);
      var local2:AimedShotResult = this.getAimedShotTargets(gunParams,_aimDirection);
      this.effects.createHitMark(gunParams.barrelOrigin,local2.staticHitPoint);
      this.createMandatoryShotEffects(gunParams);
      this.effects.createHitPointsGraphicEffects(local2.staticHitPoint,local2.targetHitPoint,gunParams.muzzlePosition,gunParams.direction,_aimDirection);
      if(local2.target != null) {
        local3 = this.aimingActivationEnergy - this.getEnergy();
        this.applyImpactForceToTarget(local2.target,local2.targetHitPoint,this.getAimedShotImpactForce(local3),_aimDirection);
      }
      this.reloadFinishTime = battleService.getPhysicsTime() + this.reloadTimeMS;
      this.callback.onAimedShot(local1,local2.staticHitPoint,local2.target,local2.targetHitPoint);
      this.doSetEnergyMode(ShaftEnergyMode.RECHARGE,Math.min(this.getEnergy(),this.shaftData.maxEnergy - this.shaftData.minAimedShotEnergy),local1);
      if(this.aimingListener != null) {
        this.aimingListener.onAimedShot();
      }
    }

    private function getAimedShotTargets(param1:AllGlobalGunParams, param2:Vector3) : AimedShotResult {
      var local4:RayIntersectionData = null;
      var local5:Object3D = null;
      var local6:Vector3 = null;
      var local7:Tank = null;
      this.addTankSkinToExclusionSet(this.weaponPlatform.getSkin());
      var local3:AimedShotResult = new AimedShotResult();
      _origin.copy(param1.barrelOrigin);
      while(true) {
        local4 = battleService.getBattleScene3D().raycast(_origin,param2,this.exclusionSet);
        if(local4 == null) {
          break;
        }
        local5 = local4.object;
        local6 = _origin.clone().addScaled(local4.time + 0.1,param2);
        if(local5.name == Object3DNames.STATIC) {
          local3.setStaticHitPoint(local6);
          break;
        }
        if(local5.name == Object3DNames.TANK_PART) {
          local7 = this.object3DToTank[local5];
          if(this.isValidHit(local7,local5,local6)) {
            local3.setTarget(local7.getBody(),local6);
            break;
          }
          this.addTankSkinToExclusionSet(local7.getSkin());
        } else {
          this.exclusionSetController.addTemporaryItem(local5);
        }
        _origin.copy(local6);
      }
      this.exclusionSetController.deleteAllTemporaryItems();
      return local3;
    }

    private function isValidHit(param1:Tank, param2:Object3D, param3:Vector3) : Boolean {
      var local4:TankSkin = param1.getSkin();
      if(local4.getTurret3D() == param2) {
        _m.setMatrix(param2.x,param2.y,param2.z,param2.rotationX,param2.rotationY,param2.rotationZ);
        _m.transformVectorInverse(param3,_p);
        getClosestBarrelOrigin(_p,local4.getTurretDescriptor().muzzles,_closestBarrelOrigin);
        _m.transformVector(_closestBarrelOrigin,_p);
        _p.subtract(param3);
        if(getBattleRunner().getCollisionDetector().hasStaticHit(param3,_p,CollisionGroup.STATIC,1)) {
          return false;
        }
      }
      return local4.getHullAlpha() == 1;
    }

    public function performQuickShotDuringAimingActivation() : void {
      this.stopAiming();
      this.performQuickShot(this.aimingActivationEnergy);
      this.onTargetingModeStop();
    }

    public function performQuickShot(param1:Number) : void {
      var local4:TargetingResult = null;
      var local5:Body = null;
      var local6:Vector3 = null;
      var local7:Vector3 = null;
      var local8:Number = NaN;
      var local2:int = int(battleService.getPhysicsTime());
      var local3:Number = param1 < 0 ? this.getEnergy() : param1;
      if(local3 >= this.shaftData.fastShotEnergy) {
        local3 -= this.shaftData.fastShotEnergy;
        this.weaponPlatform.getAllGunParams(gunParams);
        if(!this.isBarrelOriginInsideStaticGeometry()) {
          local8 = this.shaftObject.commonData().getImpactForce();
          local4 = this.targetingSystem.target(gunParams);
          if(local4.hasAnyHit()) {
            local6 = local4.getSingleHit().position.clone();
          }
          if(local4.hasStaticHit()) {
            local7 = local4.getStaticHit().position.clone();
          }
          if(local4.hasTankHit()) {
            local5 = local4.getSingleHit().shape.body;
            local8 *= this.weakening.getImpactCoeff(local4.getSingleHit().t);
          }
          this.effects.createHitPointsGraphicEffects(local7,local6,gunParams.muzzlePosition,gunParams.direction,local4.getDirection());
          this.applyImpactForceToTarget(local5,local6,local8,local4.getDirection());
          this.effects.createHitMark(gunParams.barrelOrigin,local7);
        }
        this.createMandatoryShotEffects(gunParams);
        this.effects.createMuzzleFlashEffect(this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
        this.reloadFinishTime = battleService.getPhysicsTime() + this.reloadTimeMS;
        this.callback.onQuickShot(local2,local7,local5,local6);
      }
      this.doSetEnergyMode(ShaftEnergyMode.RECHARGE,local3,local2);
    }

    public function canShoot() : Boolean {
      return battleService.getPhysicsTime() >= this.reloadFinishTime;
    }

    public function onTargetingModeStop() : void {
      this.callback.onManualTargetingStop();
    }

    private function addTankSkinToExclusionSet(param1:TankSkin) : void {
      this.exclusionSetController.addTemporaryItem(param1.getHullMesh());
      this.exclusionSetController.addTemporaryItem(param1.getTurret3D());
    }

    private function initStateMachine() : void {
      this.states = new Dictionary();
      this.states[ShaftState.IDLE] = new IdleState(this);
      this.states[ShaftState.READY_TO_SHOOT] = new ReadyToShootState(this,SWITCH_INTERVAL);
      this.states[ShaftState.MANUAL_TARGETING_ACTIVATION] = new ManualTargetingActivationState(this,this.shaftData.targetingTransitionTime);
      this.states[ShaftState.MANUAL_TARGETING] = new ManualTargetingState(this,this.shaftData.afterShotPause);
      this.currentState = this.states[ShaftState.IDLE];
      this.transitions = Vector.<Transition>([this.createTransition(ShaftState.IDLE,ShaftEventType.READY_TO_SHOOT,ShaftState.READY_TO_SHOOT,null),this.createTransition(ShaftState.IDLE,ShaftEventType.STOP,ShaftState.IDLE,null),this.createTransition(ShaftState.READY_TO_SHOOT,ShaftEventType.TRIGGER_RELEASE,ShaftState.IDLE,new QuickShotHandler(this)),this.createTransition(ShaftState.READY_TO_SHOOT,ShaftEventType.SWITCH,ShaftState.MANUAL_TARGETING_ACTIVATION,null),this.createTransition(ShaftState.READY_TO_SHOOT,ShaftEventType.STOP,ShaftState.IDLE,null),this.createTransition(ShaftState.MANUAL_TARGETING_ACTIVATION,ShaftEventType.SWITCH,ShaftState.MANUAL_TARGETING,null),this.createTransition(ShaftState.MANUAL_TARGETING_ACTIVATION,ShaftEventType.TRIGGER_RELEASE,ShaftState.IDLE,new ManualTargetingActivationTriggerReleaseHandler(this)),this.createTransition(ShaftState.MANUAL_TARGETING_ACTIVATION,ShaftEventType.STOP,ShaftState.IDLE,new ManualTargetingActivationStopHandler(this)),this.createTransition(ShaftState
      .MANUAL_TARGETING,ShaftEventType.EXIT,ShaftState.IDLE,null),this.createTransition(ShaftState.MANUAL_TARGETING,ShaftEventType.STOP,ShaftState.IDLE,new ManualTargetingStopHandler(this))]);
    }

    private function createTransition(param1:ShaftState, param2:ShaftEventType, param3:ShaftState, param4:ITransitionHandler) : Transition {
      return new Transition(param2,this.states[param1],this.states[param3],param4);
    }

    private function doSetEnergyMode(param1:ShaftEnergyMode, param2:Number, param3:int) : void {
      this.energyMode = param1;
      this.energy.setNumber(param2);
      switch(param1) {
        case ShaftEnergyMode.RECHARGE:
          this.energyChangeRate.setNumber(this.shaftData.chargeRate);
          break;
        case ShaftEnergyMode.DRAIN:
          this.energyChangeRate.setNumber(-this.shaftData.dischargeRate);
          this.callback.onBeginEnergyDrain(param3);
      }
    }

    private function createMandatoryShotEffects(param1:AllGlobalGunParams) : void {
      this.effects.createShotSoundEffect(param1.muzzlePosition);
      this.weaponPlatform.getBody().addWorldForceScaled(param1.muzzlePosition,param1.direction,-this.weaponForces.getRecoilForce());
      this.weaponPlatform.addDust();
    }

    private function applyImpactForceToTarget(param1:Body, param2:Vector3, param3:Number, param4:Vector3) : void {
      if(param1 != null) {
        param1.tank.applyWeaponHit(param2,param4,param3);
      }
    }

    private function getAimedShotImpactForce(param1:Number) : Number {
      var local2:Number = this.shaftObject.commonData().getImpactForce();
      return local2 + (this.weaponForces.getImpactForce() - local2) * param1 / this.shaftData.maxEnergy;
    }

    public function setLaserPointerScale(param1:Number) : void {
      this.reticleDisplay.setLaserPointerScale(param1);
    }

    private function calculateTargetPoint(param1:Vector3, param2:ShaftTargetPoint) : Boolean {
      var local4:RayIntersectionData = null;
      var local5:Object3D = null;
      var local6:Tank = null;
      var local3:GameCamera = battleService.getBattleScene3D().getCamera();
      _origin.copy(local3.position);
      this.addTankSkinToExclusionSet(this.weaponPlatform.getSkin());
      param2.reset();
      while(true) {
        local4 = battleService.getBattleScene3D().raycast(_origin,param1,this.exclusionSet);
        if(local4 == null) {
          break;
        }
        local5 = local4.object;
        if(local5.name == Object3DNames.STATIC) {
          _origin.addScaled(local4.time,param1);
          param2.setTargetPoint(_origin);
          this.exclusionSetController.deleteAllTemporaryItems();
          return true;
        }
        if(local5.name == Object3DNames.TANK_PART) {
          _origin.addScaled(local4.time,param1);
          local6 = this.object3DToTank[local5];
          if(this.isValidHit(local6,local5,_origin)) {
            param2.setTargetPoint(_origin,local6);
            this.exclusionSetController.deleteAllTemporaryItems();
            return true;
          }
        }
        this.exclusionSetController.addTemporaryItem(local4.object);
      }
      this.exclusionSetController.deleteAllTemporaryItems();
      return false;
    }

    private function initTitleIndicator() : void {
      var local1:DisplayObjectContainer = battleService.getBattleView().getParentDisplayContainer();
      var local2:Tank = this.getTank();
      local2.hideTitle();
      var local3:BitmapData = local2.getTitleTexture();
      this.titleIndicator.bitmapData = local3;
      local1.addChild(this.titleIndicator);
      var local4:GameCamera = battleService.getBattleScene3D().getCamera();
      var local5:Vector3D = new Vector3D();
      local2.readTitlePosition(local5);
      local5 = local4.projectGlobal(local5);
      var local6:Point = new Point();
      var local7:Point = new Point();
      local6.x = local5.x + battleService.getBattleView().getX();
      local6.y = local5.y + battleService.getBattleView().getY() - local3.height;
      this.titleIndicator.x = local6.x;
      this.titleIndicator.y = local6.y;
      local7.x = display.stage.stageWidth >> 1;
      local7.y = (display.stage.stageHeight >> 1) + INDICATOR_OFFSET;
      this.indicatorInterpolatorX.setInterval(local6.x,local7.x);
      this.indicatorInterpolatorY.setInterval(local6.y,local7.y);
      this.titleIndicator.alpha = 0;
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.SHAFT_RESISTANCE;
    }

    public function getLaser() : LaserPointer {
      return this.laser;
    }

    public function getTargetDirection() : Number {
      return this.targetDirection;
    }

    public function getTargetElevation() : Number {
      return this.targetElevation;
    }

    public function getInterpolatedElevation() : Number {
      return this.interpolatedElevation;
    }

    public function changeTargetElevation(param1:Number) : void {
      this.targetElevation = MathUtils.clamp(this.targetElevation + param1,-this.verticalAngles.getAngleDown(),this.verticalAngles.getAngleUp());
      var local2:Number = this.targetElevation - this.elevation;
      if(Math.abs(local2) > MAX_DIRECTION_DELTA) {
        this.targetElevation = this.elevation + MathUtils.sign(local2) * MAX_DIRECTION_DELTA;
      }
    }

    public function changeTargetDirection(param1:Number) : void {
      this.targetDirection = MathUtils.clampAngle(this.targetDirection + param1);
      var local2:Number = Number(this.weaponPlatform.getWeaponMount().getTurretPhysicsDirection());
      var local3:Number = MathUtils.clampAngleDelta(this.targetDirection,local2);
      if(Math.abs(local3) > MAX_DIRECTION_DELTA) {
        this.targetDirection = MathUtils.clampAngle(local2 + MathUtils.sign(local3) * MAX_DIRECTION_DELTA);
      }
    }

    public function getReticleDisplay() : ReticleDisplay {
      return this.reticleDisplay;
    }

    public function pauseElevation(param1:Boolean) : void {
      this.isElevationPaused = param1;
    }

    public function reconfigure(param1:Number, param2:Number, param3:Boolean) : void {
      this.shaftData.dischargeRate = param1;
      this.shaftData.fastShotEnergy = param2;
      this.aimedModeLocked = param3;
    }

    public function stun() : void {
      if((this.currentState is ManualTargetingState || this.currentState is ManualTargetingActivationState) && this.canShoot()) {
        this.stunStatus = 1;
        this.energy.setNumber(this.getMaxEnergy());
      } else {
        this.stunStatus = this.getStatus();
      }
      this.stunned = true;
    }

    public function calm(param1:int) : void {
      this.reloadFinishTime += param1;
      this.stunned = false;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.weaponForces.setRecoilForce(param1);
    }

    public function fullyRecharge() : void {
      this.energy.setNumber(this.shaftData.maxEnergy);
      this.reloadFinishTime = battleService.getPhysicsTime();
      this.stunStatus = 1;
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      this.reloadTimeMS = param2;
    }

    public function isAimedModeLocked() : Boolean {
      return this.aimedModeLocked;
    }
  }
}
