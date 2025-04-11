package alternativa.tanks.models.tank {
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.BattleRestartEvent;
  import alternativa.tanks.battle.events.EffectActivatedEvent;
  import alternativa.tanks.battle.events.EffectStoppedEvent;
  import alternativa.tanks.battle.events.InventoryItemActivationEvent;
  import alternativa.tanks.battle.events.LocalTankActivationEvent;
  import alternativa.tanks.battle.events.TankActivationEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.events.death.TankKilledEvent;
  import alternativa.tanks.battle.objects.tank.LocalHullTransformUpdater;
  import alternativa.tanks.battle.objects.tank.RemoteHullTransformUpdater;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.TankControlLockBits;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.controllers.ChassisControlListener;
  import alternativa.tanks.battle.objects.tank.controllers.ChassisController;
  import alternativa.tanks.battle.objects.tank.controllers.LocalChassisController;
  import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.display.usertitle.TitleConfigFlags;
  import alternativa.tanks.display.usertitle.UserTitle;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesChecker;
  import alternativa.tanks.models.battle.gui.drone.IDroneModel;
  import alternativa.tanks.models.battle.gui.inventory.IInventoryPanel;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.inventory.IInventoryModel;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.inventory.InventoryLock;
  import alternativa.tanks.models.sfx.smoke.HullSmoke;
  import alternativa.tanks.models.statistics.IClientUserInfo;
  import alternativa.tanks.models.statistics.IStatisticsModel;
  import alternativa.tanks.models.tank.armor.Armor;
  import alternativa.tanks.models.tank.armor.chassis.tracked.ITrackedChassis;
  import alternativa.tanks.models.tank.configuration.TankConfiguration;
  import alternativa.tanks.models.tank.engine.Engine;
  import alternativa.tanks.models.tank.event.LocalTankLoadListener;
  import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
  import alternativa.tanks.models.tank.event.TankEntityCreationListener;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.models.tank.killhandlers.LocalTankDieHandler;
  import alternativa.tanks.models.tank.killhandlers.RemoteTankDieHandler;
  import alternativa.tanks.models.tank.killhandlers.TankDeathConfirmationHandler;
  import alternativa.tanks.models.tank.killhandlers.TankDieHandler;
  import alternativa.tanks.models.tank.pause.ITankPause;
  import alternativa.tanks.models.tank.resistance.TankResistances;
  import alternativa.tanks.models.tank.spawn.ITankSpawner;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
  import alternativa.tanks.models.tank.support.ClientDeactivationSupport;
  import alternativa.tanks.models.tank.support.StateCorrectionSupport;
  import alternativa.tanks.models.tank.support.TankSettingsSupport;
  import alternativa.tanks.models.tank.ultimate.IUltimateModel;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponSound;
  import alternativa.tanks.models.weapon.turret.TurretStateSender;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.services.initialeffects.ClientBattleEffect;
  import alternativa.tanks.services.initialeffects.IInitialEffectsService;
  import alternativa.tanks.services.memoryleakguard.MemoryLeakTrackerService;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import alternativa.tanks.sfx.TankSoundEffects;
  import alternativa.tanks.utils.DataUnitValidator;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.media.Sound;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.tank.ITankModelBase;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;
  import projects.tanks.client.battlefield.models.user.tank.TankModelBase;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.client.battlefield.types.TankState;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class TankModel extends TankModelBase implements ITankModelBase, ObjectLoadListener, ObjectUnloadListener, ITankModel, LocalTankInfoService, ChassisControlListener {
    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var settings:ISettingsService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleUserInfoService:BattleUserInfoService;

    [Inject]
    public static var modelRegistry:ModelRegistry;

    [Inject]
    public static var memoryLeakTrackerService:MemoryLeakTrackerService;

    [Inject]
    public static var tankUsersRegistry:TankUsersRegistry;

    [Inject]
    public static var inventoryPanel:IInventoryPanel;

    [Inject]
    public static var initialEffectsService:IInitialEffectsService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private static const LOCAL_TITLE_OFFSET_Z:Number = 0;
    private static const REMOTE_TITLE_OFFSET_Z:Number = 135;
    private static const ZERO_VECTOR_3D:Vector3d = new Vector3d(0,0,0);

    private var logger:Logger;

    private const _orientation:Quaternion = new Quaternion();
    private const _orientation2:Quaternion = new Quaternion();
    private const _eulerAngles:Vector3 = new Vector3();

    private var tankUserInfoUpdater:TankUserInfoUpdater;

    private const tanksInBattle:Dictionary = new Dictionary();

    private var localObject:IGameObject;
    private var battleEventSupport:BattleEventSupport;
    private var chassisStateCorrectionTask:ChassisStateCorrectionTask;

    private const _moveCommand:MoveCommand = new MoveCommand(new Vector3d(0,0,0),0,new Vector3d(0,0,0),new Vector3d(0,0,0),new Vector3d(0,0,0));

    private var positionBookmarks:PositionBookmarks;
    private var overridenTankPositions:OverridenTankPositions;
    private var lastChassisInput:int;
    private var lastSentMoveCommand:MoveCommand = new MoveCommand(new Vector3d(0,0,0),0,new Vector3d(0,0,0),new Vector3d(0,0,0),new Vector3d(0,0,0));
    private var lastFullSentTime:int;
    private var lastSentTime:int;
    private var lastControlSentTime:int;
    private var smokeEffect:HullSmoke;

    public function TankModel() {
      super();
      this.logger = logService.getLogger("tank");
      OSGi.getInstance().registerService(LocalTankInfoService,this);
      this.tankUserInfoUpdater = new TankUserInfoUpdater();
      this.initMainBattleEventListeners();
    }

    private static function getDefaultMaxHealth() : int {
      var local1:TankConfiguration = TankConfiguration(object.adapt(TankConfiguration));
      var local2:IGameObject = local1.getHullObject();
      var local3:Armor = Armor(local2.adapt(Armor));
      return local3.getMaxHealth();
    }

    private static function createTankSoundEffects(param1:IGameObject, param2:IGameObject) : TankSoundEffects {
      var local3:Engine = Engine(param1.adapt(Engine));
      var local4:Sound = local3.getCC().engineIdleSound.sound;
      var local5:Sound = local3.getCC().engineStartMovingSound.sound;
      var local6:Sound = local3.getCC().engineMovingSound.sound;
      var local7:WeaponSound = WeaponSound(param2.adapt(WeaponSound));
      var local8:Sound = local7.getTurretRotationSound().sound;
      return new TankSoundEffects(local4,local5,local6,local8);
    }

    private static function setInitialSpeedCharacteristics() : void {
      var local1:SpeedCharacteristics = SpeedCharacteristics(object.adapt(SpeedCharacteristics));
      local1.setInitialTankState();
    }

    private static function setBackTurnMode(param1:LocalChassisController) : void {
      param1.setReversedBackTurn(settings.inverseBackDriving);
    }

    private static function showInitialEffects(param1:IGameObject) : void {
      var local3:int = 0;
      var local4:ITankModel = null;
      var local5:UserTitle = null;
      var local6:ClientBattleEffect = null;
      var local7:int = 0;
      var local8:int = 0;
      var local2:Vector.<ClientBattleEffect> = initialEffectsService.takeInitialEffects(param1.id);
      if(local2 != null) {
        local3 = getTimer();
        local4 = ITankModel(param1.adapt(ITankModel));
        local5 = local4.getTitle();
        for each(local6 in local2) {
          local7 = local3 - local6.receiveTime;
          local8 = local6.duration - local7;
          if(local8 > 0) {
            local5.showIndicator(local6.effectId,local8,false,local6.effectLevel);
          }
        }
      }
    }

    private static function configureTankTitle(param1:UserTitle, param2:int, param3:String, param4:int, param5:BattleTeam, param6:int, param7:Boolean) : void {
      param1.setHealth(param2);
      param1.setLabelText(param3);
      param1.setRank(param4);
      param1.setTeamType(param5);
      param1.setConfigurationFlags(param6,true);
      param1.setPremium(param7);
    }

    private function initMainBattleEventListeners() : void {
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
      this.battleEventSupport.addEventHandler(EffectActivatedEvent,this.onEffectActivated);
      this.battleEventSupport.addEventHandler(EffectStoppedEvent,this.onEffectStopped);
      this.battleEventSupport.addEventHandler(InventoryItemActivationEvent,this.onInventoryItemActivation);
      this.battleEventSupport.activateHandlers();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      this.registerUser();
      putData(UserInfo,new UserInfo(battleUserInfoService.getUserName(object.id),battleUserInfoService.getUserRank(object.id),getInitParam().local,battleUserInfoService.getChatModeratorLevel(object.id),battleUserInfoService.hasUserPremium(object.id)));
      var local1:TankConfiguration = TankConfiguration(object.adapt(TankConfiguration));
      var local2:int = getDefaultMaxHealth();
      var local3:IGameObject = !!local1.hasDrone() ? local1.getDrone() : null;
      this.initTank(local1.getHullObject(),local1.getWeaponObject(),local3,local2,false);
      this.showLoginMessage();
      this.battleEventSupport.dispatchEvent(new TankLoadedEvent(this.getTank(),this.isLocal()));
      var local4:TankEntityCreationListener = TankEntityCreationListener(object.event(TankEntityCreationListener));
      var local5:TankEntityCreationListener = TankEntityCreationListener(this.getTankSet().hull.event(TankEntityCreationListener));
      local4.onTankEntityCreated(this.getTank(),this.isLocal(),getInitParam().logicState);
      local5.onTankEntityCreated(this.getTank(),this.isLocal(),getInitParam().logicState);
      var local6:TankEntityCreationListener = TankEntityCreationListener(battleService.getBattle().event(TankEntityCreationListener));
      local6.onTankEntityCreated(this.getTank(),this.isLocal(),getInitParam().logicState);
      if(this.tankShouldBeAddedToBattle()) {
        this.addExistingTankToBattle();
      }
    }

    private function initUltimate() : void {
      var local1:IUltimateModel = IUltimateModel(object.adapt(IUltimateModel));
      if(local1.isUltimateEnabled()) {
        IUltimateModel(object.adapt(IUltimateModel)).initIndicator();
      }
    }

    private function registerUser() : void {
      tankUsersRegistry.addUser(object);
      if(tankUsersRegistry.getUserCount() == 1) {
        battleUserInfoService.addBattleUserInfoListener(this.tankUserInfoUpdater);
      }
    }

    private function initTank(param1:IGameObject, param2:IGameObject, param3:IGameObject, param4:int, param5:Boolean) : Tank {
      var local6:TankConfiguration = TankConfiguration(object.adapt(TankConfiguration));
      var local7:WeaponMount = this.createWeaponMount(param2);
      var local8:int = 0;
      var local9:UserTitle = getData(UserTitle) as UserTitle;
      if(local9 != null) {
        local8 = local9.getResistance();
        local9.removeFromContainer();
      }
      local9 = this.createUserTitle(param4);
      local9.setResistance(local8);
      putData(UserTitle,local9);
      var local10:Weapon = this.createWeapon(param2);
      this.registerWeaponController(local10);
      HullCommon(param1.adapt(HullCommon)).setTankObject(object);
      var local11:Tank = this.createTank(param1,param2,local6.getColoringObject(),local7,local10,local9);
      this.storeTank(local11,param1,param2,param3,param4);
      this.initTankPart(param2,local11);
      if(param5) {
        TankPartReset(param2.event(TankPartReset)).resetTankPart(local11);
      }
      this.createTankDataValidator(local11);
      this.createSmokeEffect(param1);
      this.createChassisController(local11);
      this.createTankKillHandler();
      if(this.isLocal()) {
        this.initLocalObjectBattleEventListeners();
        this.initLocalTank(local11,param5);
        local11.setHullTransformUpdater(new LocalHullTransformUpdater(local11));
      } else {
        local11.setHullTransformUpdater(new RemoteHullTransformUpdater(local11));
        this.createMovementAnticheatTask();
      }
      setInitialSpeedCharacteristics();
      this.initUltimate();
      return local11;
    }

    private function initTankPart(param1:IGameObject, param2:Tank) : void {
      InitTankPart(param1.event(InitTankPart)).initTankPart(param2);
    }

    private function storeTank(param1:Tank, param2:IGameObject, param3:IGameObject, param4:IGameObject, param5:int) : void {
      putData(Tank,param1);
      this.getWeaponCommon(param3).storeTank(param1);
      putData(TankSet,new TankSet(param2,param3,param4,param5));
    }

    public function getTankSet() : TankSet {
      return TankSet(getData(TankSet));
    }

    private function showLoginMessage() : void {
      var local3:ShortUserInfo = null;
      var local4:IStatisticsModel = null;
      var local1:IGameObject = object.space.rootObject;
      var local2:IClientUserInfo = IClientUserInfo(local1.adapt(IClientUserInfo));
      if(!local2.isLoaded(object.id)) {
        local3 = local2.getShortUserInfo(object.id);
        local4 = IStatisticsModel(local1.adapt(IStatisticsModel));
        local4.userConnect(local3);
      }
    }

    private function createMovementAnticheatTask() : void {
      var local1:MovementTimeoutAndDistanceAnticheatTask = new MovementTimeoutAndDistanceAnticheatTask(this.getTank(),getFunctionWrapper(this.placeTankToServerPosition),getInitParam().movementTimeoutUntilTankCorrection,getInitParam().movementDistanceBorderUntilTankCorrection);
      putData(MovementTimeoutAndDistanceAnticheatTask,local1);
      battleService.getBattleRunner().addLogicUnit(local1);
    }

    private function registerWeaponController(param1:Weapon) : void {
      if(getInitParam().local) {
        putData(IWeaponController,new LocalWeaponController(param1));
      } else {
        putData(IWeaponController,new RemoteWeaponController(param1));
      }
    }

    private function createWeaponMount(param1:IGameObject) : WeaponMount {
      var local2:WeaponMountProvider = WeaponMountProvider(param1.adapt(WeaponMountProvider));
      var local3:WeaponMount = local2.createWeaponMount(object);
      putData(WeaponMount,local3);
      return local3;
    }

    private function getWeaponCommon(param1:IGameObject) : IWeaponCommonModel {
      return IWeaponCommonModel(param1.adapt(IWeaponCommonModel));
    }

    private function createSmokeEffect(param1:IGameObject) : void {
      this.smokeEffect = HullSmoke(param1.adapt(HullSmoke));
    }

    private function createChassisController(param1:Tank) : void {
      var local2:ChassisController = null;
      var local3:LocalChassisController = null;
      if(getInitParam().local) {
        local3 = new LocalChassisController(param1,this);
        local3.lock(TankControlLockBits.DEAD);
        setBackTurnMode(local3);
        local2 = local3;
        putData(TankSettingsSupport,new TankSettingsSupport(local3));
        putData(LocalChassisController,local2);
      } else {
        local2 = new ChassisController(param1,this);
        local2.lock(TankControlLockBits.DEAD);
      }
      putData(ChassisController,local2);
    }

    private function createTankKillHandler() : void {
      var local1:RemoteTankDieHandler = null;
      if(getInitParam().local) {
        putData(TankDieHandler,new LocalTankDieHandler());
      } else {
        local1 = new RemoteTankDieHandler();
        putData(TankDieHandler,local1);
        putData(TankDeathConfirmationHandler,local1);
      }
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      this.unregisterUser();
      this.destroyTank(false);
      if(!battleInfoService.isSpectatorMode()) {
        IUltimateModel(object.adapt(IUltimateModel)).resetCharge();
      }
    }

    private function unregisterUser() : void {
      tankUsersRegistry.removeUser(object);
      if(tankUsersRegistry.getUserCount() == 0) {
        battleUserInfoService.removeBattleUserInfoListener(this.tankUserInfoUpdater);
      }
    }

    private function destroyTank(param1:Boolean) : void {
      var local2:Tank = this.getTank();
      this.removeMovementAnticheatTask();
      this.removeTankFromBattle();
      this.removeTankFromExclusionSet(local2);
      this.dispatchTankUnloadedEvent();
      this.unloadLocalTank(param1);
      this.sendDestroyPartEvent(this.getTankSet().turret);
      local2.destroy();
    }

    private function sendDestroyPartEvent(param1:IGameObject) : void {
      DestroyTankPart(param1.event(DestroyTankPart)).destroyTankPart();
    }

    private function removeMovementAnticheatTask() : void {
      var local1:MovementTimeoutAndDistanceAnticheatTask = this.getMovementAnticheatTask();
      if(Boolean(local1)) {
        battleService.getBattleRunner().removeLogicUnit(local1);
        clearData(MovementTimeoutAndDistanceAnticheatTask);
      }
    }

    public function getMovementAnticheatTask() : MovementTimeoutAndDistanceAnticheatTask {
      return MovementTimeoutAndDistanceAnticheatTask(getData(MovementTimeoutAndDistanceAnticheatTask));
    }

    [Obfuscation(rename="false")]
    public function kill(param1:Long, param2:int, param3:DamageType) : void {
      this.die(param2);
      battleEventDispatcher.dispatchEvent(new TankKilledEvent(param1,object.id,param3));
    }

    public function die(param1:int) : void {
      var local2:TankDieHandler = TankDieHandler(getData(TankDieHandler));
      local2.handleTankDie(object,param1);
    }

    [Obfuscation(rename="false")]
    public function deathConfirmed() : void {
      var local1:TankDeathConfirmationHandler = TankDeathConfirmationHandler(getData(TankDeathConfirmationHandler));
      local1.handleDeathConfirmation(object);
    }

    [Obfuscation(rename="false")]
    public function setHealth(param1:Number) : void {
      if(this.getTank() != null) {
        this.doSetHealth(param1);
      }
    }

    [Obfuscation(rename="false")]
    public function activateTank() : void {
      var local1:Tank = this.getTank();
      if(local1 != null) {
        local1.setActivatedState();
        this.getWeaponController().activateWeapon();
        this.getWeaponController().unlockWeapon(TankControlLockBits.DEAD | TankControlLockBits.DISABLED);
        if(object == this.localObject) {
          local1.setBodyCollisionGroup(local1.getBodyCollisionGroup() | CollisionGroup.BONUS_WITH_TANK);
          this.battleEventSupport.dispatchEvent(new LocalTankActivationEvent(local1));
        }
        this.battleEventSupport.dispatchEvent(new TankActivationEvent(local1));
        this.removeTankFromExclusionSet(local1);
      }
    }

    [Obfuscation(rename="false")]
    public function move(param1:MoveCommand) : void {
      var local3:Vector3 = null;
      var local4:BattleFacilitiesChecker = null;
      var local2:Tank = this.getTank();
      if(local2 != null) {
        local3 = new Vector3();
        local3.copy(local2.getBody().state.position);
        this.adjustIncomingCommandAndUpdateAnticheatTask(param1);
        this.evaluateMove(param1);
        local4 = BattleFacilitiesChecker(battleService.getBattle().event(BattleFacilitiesChecker));
        local4.onMoveCommand(local2,local3,Vector3.fromVector3d(param1.position));
      }
    }

    private function evaluateMove(param1:MoveCommand) : void {
      this.setChassisState(param1.position,param1.orientation,param1.linearVelocity,param1.angularVelocity,param1.control,param1.turnSpeedNumber);
    }

    private function adjustIncomingCommandAndUpdateAnticheatTask(param1:MoveCommand) : void {
      var local2:MovementTimeoutAndDistanceAnticheatTask = this.getMovementAnticheatTask();
      local2.updateLatestServerTankPosition(param1.position,param1.orientation);
      this.adjustIncomingMovementCommand(param1);
    }

    private function placeTankToServerPosition(param1:Vector3d, param2:Vector3d) : void {
      this.setChassisState(param1,param2,ZERO_VECTOR_3D,ZERO_VECTOR_3D,0,0);
      this.getTank().getBody().saveState();
    }

    private function adjustIncomingMovementCommand(param1:MoveCommand) : void {
      var local3:Body = null;
      var local4:Number = NaN;
      var local2:Tank = this.getTank();
      if(local2 != null) {
        local3 = local2.getBody();
        local4 = 0.5;
        this.interpolateVector3d(local4,local3.state.position,param1.position,param1.position);
        this.interpolateVector3d(local4,local3.state.velocity,param1.linearVelocity,param1.linearVelocity);
        this.interpolateVector3d(local4,local3.state.angularVelocity,param1.angularVelocity,param1.angularVelocity);
        this.interpolateOrientation(local4,local3.state.orientation,param1.orientation,param1.orientation);
      }
    }

    private function interpolateVector3d(param1:Number, param2:Vector3, param3:Vector3d, param4:Vector3d) : void {
      param4.x = param2.x + (param3.x - param2.x) * param1;
      param4.y = param2.y + (param3.y - param2.y) * param1;
      param4.z = param2.z + (param3.z - param2.z) * param1;
    }

    private function interpolateOrientation(param1:Number, param2:Quaternion, param3:Vector3d, param4:Vector3d) : void {
      this._orientation.setFromEulerAnglesXYZ(param3.x,param3.y,param3.z);
      this._orientation2.slerp(param2,this._orientation,param1);
      this._orientation2.getEulerAngles(this._eulerAngles);
      param4.x = this._eulerAngles.x;
      param4.y = this._eulerAngles.y;
      param4.z = this._eulerAngles.z;
    }

    [Obfuscation(rename="false")]
    public function movementControl(param1:int, param2:int) : void {
      this.getChassisController().setControlState(param1,param2);
    }

    public function enableStateCorrection() : void {
      battleService.getBattleRunner().addPostPhysicsController(this.chassisStateCorrectionTask);
      this.chassisStateCorrectionTask.reset();
    }

    public function disableStateCorrection() : void {
      battleService.getBattleRunner().removePostPhysicsController(this.chassisStateCorrectionTask);
    }

    private function sendTurretStateToServer() : void {
      var local1:ITankModel = null;
      var local2:IGameObject = null;
      if(this.localObject != null) {
        local1 = ITankModel(this.localObject.adapt(ITankModel));
        local2 = local1.getTankSet().turret;
        TurretStateSender(local2.event(TurretStateSender)).sendTurretState();
      }
    }

    public function sendStateCorrection(param1:Boolean) : void {
      var local2:ChassisController = this.getChassisController();
      this.sendMoveCommandWithCurrentState(local2.getControlState(),param1);
      this.chassisStateCorrectionTask.reset();
    }

    public function onPrevStateCorrection(param1:Boolean) : void {
      var local2:ITankModel = ITankModel(this.localObject.adapt(ITankModel));
      var local3:ChassisController = local2.getChassisController();
      this.sendMoveCommandWithPreviousState(local3.getControlState(),true);
    }

    public function handleCollisionWithOtherTank(param1:Tank) : void {
      server.handleCollisionWithOtherTank(param1.getBody().state.velocity.z);
    }

    public function lockMovementControl(param1:int) : void {
      this.getChassisController().lock(param1);
      this.getWeaponMount().lock(param1);
    }

    public function unlockMovementControl(param1:int) : void {
      this.getChassisController().unlock(param1);
      this.getWeaponMount().unlock(param1);
    }

    public function getWeaponController() : IWeaponController {
      return IWeaponController(getData(IWeaponController));
    }

    public function getChassisController() : ChassisController {
      return ChassisController(getData(ChassisController));
    }

    public function getWeaponMount() : WeaponMount {
      return WeaponMount(getData(WeaponMount));
    }

    public function getTitle() : UserTitle {
      return UserTitle(getData(UserTitle));
    }

    public function getUserInfo() : UserInfo {
      return UserInfo(getData(UserInfo));
    }

    public function getTank() : Tank {
      return Tank(getData(Tank));
    }

    public function onChassisControlChanged(param1:int, param2:Boolean) : void {
      if(param2) {
        this.chassisStateCorrectionTask.controlChanged();
      }
      this.smokeEffect.controlChanged(object != null ? object : this.localObject,param1);
    }

    private function sendMoveCommandWithCurrentState(param1:int, param2:Boolean) : void {
      var local3:ITankModel = null;
      var local4:Tank = null;
      if(this.tanksInBattle[this.localObject.id] != null) {
        local3 = ITankModel(this.localObject.adapt(ITankModel));
        local4 = local3.getTank();
        this.updateLastChassisInput(param1);
        local4.getPhysicsState(this._moveCommand.position,this._moveCommand.orientation,this._moveCommand.linearVelocity,this._moveCommand.angularVelocity);
        this._moveCommand.control = param1;
        this._moveCommand.turnSpeedNumber = TrackedChassis.TURN_SPEED_COUNT;
        this.sendMoveCommandFunc(battleService.getBattleRunner().getPhysicsTime(),param2);
      }
    }

    private function sendMoveCommandWithPreviousState(param1:int, param2:Boolean) : void {
      var local3:ITankModel = null;
      var local4:Tank = null;
      var local5:int = 0;
      if(this.tanksInBattle[this.localObject.id] != null) {
        local3 = ITankModel(this.localObject.adapt(ITankModel));
        local4 = local3.getTank();
        this.updateLastChassisInput(param1);
        local4.getPreviousPhysicsState(this._moveCommand.position,this._moveCommand.orientation,this._moveCommand.linearVelocity,this._moveCommand.angularVelocity);
        this._moveCommand.control = param1;
        this._moveCommand.turnSpeedNumber = TrackedChassis.TURN_SPEED_COUNT;
        local5 = battleService.getBattleRunner().getPhysicsTime() - BattleRunner.PHYSICS_STEP_IN_MS;
        this.sendMoveCommandFunc(local5,param2);
      }
    }

    private function sendMoveCommandFunc(param1:int, param2:Boolean) : void {
      if(param1 <= this.lastFullSentTime) {
        return;
      }
      if(param2) {
        Model.object = this.localObject;
        server.moveCommand(param1,LocalTankParams.getSpecificationId(),this._moveCommand);
        Model.popObject();
        MoveCommandUtils.copyMoveCommand(this._moveCommand,this.lastSentMoveCommand);
        this.sendTurretStateToServer();
        this.lastFullSentTime = param1;
      } else if(MoveCommandUtils.isMoveCommandsAlmostEquals(this._moveCommand,this.lastSentMoveCommand)) {
        if(this._moveCommand.control != this.lastSentMoveCommand.control) {
          this.sendMovementControlCommand(param1,this._moveCommand.control,this._moveCommand.turnSpeedNumber);
        }
      } else {
        this.sendMoveCommandImpl(param1,this._moveCommand);
      }
    }

    private function sendMoveCommandImpl(param1:int, param2:MoveCommand) : void {
      if(param1 <= this.lastSentTime) {
        return;
      }
      Model.object = this.localObject;
      server.moveCommand(param1,LocalTankParams.getSpecificationId(),param2);
      Model.popObject();
      MoveCommandUtils.copyMoveCommand(param2,this.lastSentMoveCommand);
      this.lastSentTime = param1;
    }

    private function sendMovementControlCommand(param1:int, param2:int, param3:int) : void {
      if(param1 <= this.lastSentTime || param1 <= this.lastControlSentTime) {
        return;
      }
      Model.object = this.localObject;
      server.movementControlCommand(param1,LocalTankParams.getSpecificationId(),param2,param3);
      Model.popObject();
      this.lastSentMoveCommand.control = param2;
      this.lastSentMoveCommand.turnSpeedNumber = param3;
      this.lastControlSentTime = param1;
    }

    private function updateLastChassisInput(param1:int) : void {
      if(this.lastChassisInput != param1) {
        this.lastChassisInput = param1;
        this.resetIdleKickTime();
      }
    }

    private function resetIdleKickTime() : void {
      var local1:ITankPause = ITankPause(this.localObject.adapt(ITankPause));
      local1.resetIdleKickTime();
    }

    private function logError(param1:String, param2:Error) : void {
    }

    private function showTankLogs(param1:FormattedOutput) : void {
    }

    private function addConsoleCommands() : void {
    }

    private function initLocalObjectBattleEventListeners() : void {
      this.battleEventSupport.deactivateHandlers();
      this.battleEventSupport.activateHandlers();
    }

    private function handleCameraTarget(param1:FormattedOutput, param2:String) : void {
    }

    private function listCameraTargets(param1:FormattedOutput) : void {
    }

    private function getTanksList() : Vector.<String> {
      return new Vector.<String>();
    }

    private function createTankDataValidator(param1:Tank) : void {
      var local2:DataUnitValidator = param1.getValidator();
      putData(TankDataValidatorWrapper,new TankDataValidatorWrapper(local2));
    }

    private function dispatchTankUnloadedEvent() : void {
      try {
        this.battleEventSupport.dispatchEvent(new TankUnloadedEvent(this.getTank(),this.isLocal()));
      }
      catch(e:Error) {
      }
    }

    private function unloadLocalTank(param1:Boolean) : void {
      var local2:TankConfiguration = null;
      if(this.isLocal()) {
        LocalTankUnloadListener(object.event(LocalTankUnloadListener)).localTankUnloaded(param1);
        local2 = TankConfiguration(object.adapt(TankConfiguration));
        LocalTankUnloadListener(local2.getWeaponObject().event(LocalTankUnloadListener)).localTankUnloaded(param1);
        battleService.setFollowCameraTarget(null);
        this.localObject = null;
        this.chassisStateCorrectionTask = null;
        RegularUserTitleRenderer(getData(RegularUserTitleRenderer)).close();
        StateCorrectionSupport(getData(StateCorrectionSupport)).close();
        MainLoopExecutionErrorHandler(getData(MainLoopExecutionErrorHandler)).close();
        ClientDeactivationSupport(getData(ClientDeactivationSupport)).close();
        clearData(RegularUserTitleRenderer);
        clearData(StateCorrectionSupport);
        clearData(MainLoopExecutionErrorHandler);
        clearData(ClientDeactivationSupport);
      }
    }

    private function createWeapon(param1:IGameObject) : Weapon {
      var local2:IWeaponModel = IWeaponModel(param1.adapt(IWeaponModel));
      if(this.isLocal()) {
        return local2.createLocalWeapon(object);
      }
      return local2.createRemoteWeapon(object);
    }

    public function setChassisState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d, param5:int, param6:int) : void {
      var local7:Tank = this.getTank();
      if(local7 != null) {
        if(BattleUtils.isFiniteVector3d(param1) && BattleUtils.isFiniteVector3d(param2) && BattleUtils.isFiniteVector3d(param3) && BattleUtils.isFiniteVector3d(param4)) {
          local7.setPhysicsState(param1,param2,param3,param4);
        }
        this.getChassisController().setControlState(param5,param6);
      }
    }

    private function initLocalTank(param1:Tank, param2:Boolean) : void {
      this.localObject = object;
      this.chassisStateCorrectionTask = new ChassisStateCorrectionTask(param1,this.tanksInBattle);
      var local3:RegularUserTitleRenderer = new RegularUserTitleRenderer(param1,this.tanksInBattle);
      putData(RegularUserTitleRenderer,local3);
      battleService.getBattleScene3D().setUserTitleRenderer(local3);
      battleService.setFollowCameraTarget(param1);
      putData(StateCorrectionSupport,new StateCorrectionSupport(object));
      putData(ClientDeactivationSupport,new ClientDeactivationSupport(object));
      putData(MainLoopExecutionErrorHandler,new MainLoopExecutionErrorHandler(object));
      var local4:LocalTankLoadListener = LocalTankLoadListener(object.event(LocalTankLoadListener));
      local4.localTankLoaded(param2);
    }

    private function tankShouldBeAddedToBattle() : Boolean {
      return getInitParam().tankState != null && getInitParam().health > 0;
    }

    private function addExistingTankToBattle() : void {
      var local1:Tank = this.getTank();
      var local2:ITankSpawner = ITankSpawner(object.adapt(ITankSpawner));
      local1.spawn(getInitParam().team,local2.getIncarnationId());
      this.doSetHealth(getInitParam().health);
      if(getInitParam().health <= 0) {
        local1.getSkin().setDeadState();
        this.getTitle().hide();
        this.lockMovementControl(TankControlLockBits.DEAD);
      } else {
        this.unlockMovementControl(TankControlLockBits.ALL);
        this.getTitle().show();
        this.configureTankTitleAsRemote(object);
        this.getWeaponController().activateWeapon();
        this.getWeaponController().unlockWeapon(TankControlLockBits.ALL);
      }
      var local3:TankState = getInitParam().tankState;
      this.setChassisState(local3.position,local3.orientation,ZERO_VECTOR_3D,ZERO_VECTOR_3D,local3.chassisControl,local3.chassisTurnSpeedNumber);
      switch(getInitParam().logicState) {
        case TankLogicState.ACTIVATING:
          local1.setSemiActivatedState();
          break;
        case TankLogicState.ACTIVE:
          local1.setActivatedState();
      }
      this.addTankToBattle();
    }

    public function doSetHealth(param1:Number) : void {
      var local2:IGameObject = null;
      var local3:Boolean = false;
      this.getTank().health = param1;
      this.getTitle().setHealth(param1);
      if(this.isLocal()) {
        local2 = battleService.getBattle();
        local3 = param1 >= this.getTankSet().maxHealth && !IDroneModel(object.adapt(IDroneModel)).canOverheal();
        IInventoryModel(local2.adapt(IInventoryModel)).lockItem(InventoryItemType.FIRST_AID,InventoryLock.FORCED,local3);
      }
    }

    private function createTank(param1:IGameObject, param2:IGameObject, param3:IGameObject, param4:WeaponMount, param5:Weapon, param6:UserTitle) : Tank {
      var local7:HullCommon = HullCommon(param1.adapt(HullCommon));
      var local8:ITrackedChassis = ITrackedChassis(param1.adapt(ITrackedChassis));
      var local9:Armor = Armor(param1.adapt(Armor));
      var local10:TankSkin = new TankSkin(param1,param2,param3);
      var local11:TankSoundEffects = createTankSoundEffects(param1,param2);
      return new Tank(object,local7.getMass(),local8.getDamping(),local11,local10,param4,param5,param6,battleEventDispatcher,local9.getMaxHealth());
    }

    public function configureRemoteTankTitles() : void {
      var local1:IGameObject = null;
      var local2:ITankModel = null;
      var local3:Tank = null;
      for each(local1 in tankUsersRegistry.getUsers()) {
        if(local1 != this.localObject) {
          local2 = ITankModel(local1.adapt(ITankModel));
          local3 = local2.getTank();
          if(local3 != null) {
            this.configureTankTitleAsRemote(local1);
            showInitialEffects(local1);
          }
        }
      }
    }

    public function configureTankTitleAsRemote(param1:IGameObject) : void {
      var local2:int = 0;
      var local3:ITankModel = null;
      var local4:UserInfo = null;
      var local5:Tank = null;
      var local6:ITankModel = null;
      var local7:Tank = null;
      if(this.localObject != null) {
        local6 = ITankModel(this.localObject.adapt(ITankModel));
        local7 = local6.getTank();
        if(local7.teamType != null) {
          local2 = TitleConfigFlags.LABEL | TitleConfigFlags.EFFECTS;
          local3 = ITankModel(param1.adapt(ITankModel));
          local4 = local3.getUserInfo();
          local5 = local3.getTank();
          if(this.localObject != null && local5.isSameTeam(local7.teamType)) {
            local2 |= TitleConfigFlags.HEALTH;
          } else {
            local3.getTitle().setConfigurationFlags(TitleConfigFlags.HEALTH,false);
          }
          configureTankTitle(local3.getTitle(),local5.health,local4.name,local4.rank,local5.teamType,local2,local4.hasPremium);
        }
      }
      if(battleInfoService.isSpectatorMode()) {
        local2 = TitleConfigFlags.LABEL | TitleConfigFlags.EFFECTS | TitleConfigFlags.HEALTH;
        local3 = ITankModel(param1.adapt(ITankModel));
        local4 = local3.getUserInfo();
        local5 = local3.getTank();
        configureTankTitle(local3.getTitle(),local5.health,local4.name,local4.rank,local5.teamType,local2,local4.hasPremium);
      }
    }

    private function createUserTitle(param1:int) : UserTitle {
      var local2:UserTitle = null;
      var local3:BattleScene3D = battleService.getBattleScene3D();
      var local4:UserInfo = this.getUserInfo();
      if(this.isLocal()) {
        local2 = new UserTitle(LOCAL_TITLE_OFFSET_Z,local3.getFrontContainer(),param1,true);
        local2.setRank(local4.rank);
        local2.setLabelText(local4.name);
        local2.setConfigurationFlags(TitleConfigFlags.HEALTH | TitleConfigFlags.WEAPON | TitleConfigFlags.EFFECTS,true);
      } else {
        local2 = new UserTitle(REMOTE_TITLE_OFFSET_Z,local3.getMapContainer(),param1,false,Model.object);
        local2.setSuspicious(battleUserInfoService.isUserSuspected(object.id));
      }
      return local2;
    }

    private function onBattleFinish(param1:BattleFinishEvent) : void {
      this.disableAllTanks();
    }

    private function disableAllTanks() : void {
      var local1:IGameObject = null;
      var local2:ITankModel = null;
      var local3:Tank = null;
      for each(local1 in tankUsersRegistry.getUsers()) {
        local2 = ITankModel(local1.adapt(ITankModel));
        local3 = local2.getTank();
        if(local3 != null) {
          local3.disable();
          local2.lockMovementControl(TankControlLockBits.DISABLED);
          local2.getWeaponController().lockWeapon(TankControlLockBits.DISABLED,false);
        }
      }
    }

    private function onBattleRestart(param1:BattleRestartEvent) : void {
      var local2:IGameObject = null;
      var local3:ITankModel = null;
      for each(local2 in tankUsersRegistry.getUsers()) {
        local3 = ITankModel(local2.adapt(ITankModel));
        local3.removeTankFromBattle();
      }
    }

    private function onInventoryItemActivation(param1:InventoryItemActivationEvent) : void {
      var local2:ITankModel = null;
      var local3:Tank = null;
      if(this.localObject != null) {
        local2 = ITankModel(this.localObject.adapt(ITankModel));
        local3 = local2.getTank();
        param1.item.doActivate(local3.getBody().state.position);
      }
    }

    private function onEffectActivated(param1:EffectActivatedEvent) : void {
      var local4:ITankModel = null;
      var local5:UserTitle = null;
      var local6:int = 0;
      var local2:IGameObject = tankUsersRegistry.getUser(param1.userId);
      var local3:Boolean = true;
      if(local2 != null) {
        local4 = ITankModel(local2.adapt(ITankModel));
        local5 = local4.getTitle();
        if(local5 != null) {
          if(local5.hasAnyFlag(TitleConfigFlags.EFFECTS)) {
            local3 = false;
            local6 = this.getEffectDuration(param1);
            local5.showIndicator(param1.effectId,local6,param1.activeAfterDeath,param1.effectLevel);
          }
        }
        if(Boolean(local4.isLocal()) && !this.isUltimate(param1.effectId)) {
          inventoryPanel.changeEffectTime(param1.effectId,param1.duration,param1.inventory,param1.infinite);
        }
      }
      if(local3) {
        initialEffectsService.addInitialEffect(param1.userId,param1.effectId,param1.duration,param1.effectLevel);
      }
    }

    private function getEffectDuration(param1:EffectActivatedEvent) : int {
      return param1.effectId == InventoryItemType.FIRST_AID ? 1000 : param1.duration;
    }

    private function isUltimate(param1:int) : Boolean {
      return param1 == InventoryItemType.ULTIMATE;
    }

    private function onEffectStopped(param1:EffectStoppedEvent) : void {
      var local3:ITankModel = null;
      var local4:UserTitle = null;
      if(this.isClientDurationEffect(param1)) {
        return;
      }
      initialEffectsService.removeInitialEffect(param1.userId,param1.effectId);
      var local2:IGameObject = tankUsersRegistry.getUser(param1.userId);
      if(local2 != null) {
        local3 = ITankModel(local2.adapt(ITankModel));
        local4 = local3.getTitle();
        if(local4 != null) {
          local4.hideIndicator(param1.effectId,param1.activeAfterDeath);
        }
        if(Boolean(local3.isLocal()) && !this.isUltimate(param1.effectId)) {
          inventoryPanel.stopEffect(param1.effectId);
        }
      }
    }

    private function isClientDurationEffect(param1:EffectStoppedEvent) : Boolean {
      return param1.effectId == InventoryItemType.FIRST_AID;
    }

    public function addTankToExclusionSet(param1:Tank) : void {
      var local2:Dictionary = battleService.getExcludedObjects3D();
      local2[param1.getSkin().getTurret3D()] = true;
      local2[param1.getSkin().getHullMesh()] = true;
    }

    private function removeTankFromExclusionSet(param1:Tank) : void {
      var local2:Dictionary = battleService.getExcludedObjects3D();
      delete local2[param1.getSkin().getTurret3D()];
      delete local2[param1.getSkin().getHullMesh()];
    }

    public function addTankToBattle() : void {
      var local1:Tank = this.getTank();
      this.tanksInBattle[object.id] = local1;
      local1.addToBattle(battleService);
      this.asAddToBattleListener(object).onAddToBattle();
      this.asAddToBattleListener(this.getTankSet().turret).onAddToBattle();
      this.battleEventSupport.dispatchEvent(new TankAddedToBattleEvent(local1,this.isLocal()));
      if(this.isLocal()) {
        this.getLocalChassisController().enable();
      }
    }

    private function asAddToBattleListener(param1:IGameObject) : AddToBattleListener {
      return AddToBattleListener(param1.event(AddToBattleListener));
    }

    public function removeTankFromBattle() : void {
      var local1:Tank = this.getTank();
      if(Boolean(this.tanksInBattle[object.id])) {
        delete this.tanksInBattle[object.id];
        this.asRemoveFromBattleListener(this.getTankSet().turret).onRemoveFromBattle();
        this.asRemoveFromBattleListener(object).onRemoveFromBattle();
        local1.removeFromBattle();
        battleEventDispatcher.dispatchEvent(new TankRemovedFromBattleEvent(local1));
        if(this.isLocal()) {
          this.getLocalChassisController().disable();
        }
      }
    }

    private function getLocalChassisController() : LocalChassisController {
      return LocalChassisController(getData(LocalChassisController));
    }

    private function asRemoveFromBattleListener(param1:IGameObject) : RemoveFromBattleListener {
      return RemoveFromBattleListener(param1.event(RemoveFromBattleListener));
    }

    public function sendDeathConfirmationCommand() : void {
      server.deathConfirmationCommand();
    }

    public function isLocal() : Boolean {
      return getInitParam().local;
    }

    public function isLocalTankLoaded() : Boolean {
      return this.localObject != null;
    }

    public function getLocalTankObject() : IGameObject {
      if(!this.isLocalTankLoaded()) {
        throw new Error("Incorrect call method \'getLocalTank\' because local tank was not loaded");
      }
      return this.localObject;
    }

    public function getLocalTankObjectOrNull() : IGameObject {
      return this.localObject;
    }

    public function getLocalTank() : Tank {
      return ITankModel(this.getLocalTankObject().adapt(ITankModel)).getTank();
    }

    public function resetConfiguration(param1:Long, param2:Long, param3:Long, param4:int) : void {
      var local5:TankSet = TankSet(getData(TankSet));
      var local6:IGameObject = object.space.getObject(param1);
      var local7:IGameObject = object.space.getObject(param2);
      var local8:IGameObject = param3 == Long.ZERO ? null : object.space.getObject(param3);
      if(local5.eqParts(local6,local7,local8)) {
        return;
      }
      var local9:Boolean = this.tanksInBattle[object.id] != null;
      this.destroyTank(true);
      var local10:Tank = this.initTank(local6,local7,local8,param4,true);
      IDroneModel(object.adapt(IDroneModel)).initDrones(local10,this.isLocal(),TankLogicState.NEW);
      this.battleEventSupport.dispatchEvent(new TankLoadedEvent(this.getTank(),this.isLocal()));
      if(local9) {
        this.addExistingTankToBattle();
        this.unlockMovementControl(TankControlLockBits.ALL);
      }
      if(object == this.localObject) {
        TankResistances(object.adapt(TankResistances)).updateOthersResistances();
      }
    }

    public function push(param1:Vector3d, param2:Vector3d) : void {
      var local3:Vector3 = new Vector3(param2.x,param2.y,param2.z);
      var local4:Vector3 = local3.clone().normalize();
      var local5:Tank = object.adapt(ITankModel).getTank();
      var local6:Vector3 = new Vector3(param1.x,param1.y,param1.z);
      local5.applyWeaponHit(local6,local4,local3.length() * WeaponConst.BASE_IMPACT_FORCE.getNumber());
    }
  }
}
