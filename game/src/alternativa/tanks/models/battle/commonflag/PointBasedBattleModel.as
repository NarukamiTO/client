package alternativa.tanks.models.battle.commonflag {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.physics.Body;
  import alternativa.physics.BodyState;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.CTFTargetEvaluator;
  import alternativa.tanks.battle.TeamDMTargetEvaluator;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.BattleRestartEvent;
  import alternativa.tanks.battle.events.LocalTankActivationEvent;
  import alternativa.tanks.battle.events.LocalTankKilledEvent;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.battle.battlefield.mine.IBattleMinesModel;
  import alternativa.tanks.models.battle.ctf.CTFCommonTargetEvaluator;
  import alternativa.tanks.models.battle.ctf.CTFRailgunTargetEvaluator;
  import alternativa.tanks.models.battle.ctf.FlagPickupTimeoutTask;
  import alternativa.tanks.models.battle.rugby.explosion.BallExplosion;
  import alternativa.tanks.models.battle.tdm.TDMHealingGunTargetEvaluator;
  import alternativa.tanks.models.inventory.IInventoryModel;
  import alternativa.tanks.models.inventory.InventoryItemType;
  import alternativa.tanks.models.inventory.InventoryLock;
  import alternativa.tanks.models.weapon.ricochet.CTFRicochetTargetEvaluator;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.StubBitmapData;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.IPointBasedBattleModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.PointBasedBattleModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagState;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class PointBasedBattleModel extends PointBasedBattleModelBase implements IPointBasedBattleModelBase, ICommonFlagModeModel, ObjectLoadPostListener, ObjectUnloadListener, IFlagBaseTrigerEvents, GameActionListener {
    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var userInfoService:BattleUserInfoService;

    [Inject]
    public static var battleInputLockService:BattleInputService;

    [Inject]
    public static var battleInputService:BattleInputService;

    private static const FLAG_PICKUP_LOCK_DURATION:int = 5000;
    private static const BALL_PICKUP_LOCK_DURATION:int = 200;
    private static const TEAM_POINT_EQUIVALENT_RADIUS:int = 200;

    private var dropCommandSent:Boolean;
    private var battleMinesModel:IBattleMinesModel;
    private var inventoryModel:IInventoryModel;
    private var flags:Dictionary;
    private var basePointDatas:Dictionary;
    private var battleEventSupport:BattleEventSupport;
    private var loadedTanks:Dictionary;
    private var localTank:Tank;
    private var triggers:Vector.<FlagBaseTrigger>;
    private var targetEvaluators:Vector.<TeamDMTargetEvaluator>;
    private var battleObject:IGameObject;
    private var ballTouchedServerFunction:Function;

    public function PointBasedBattleModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.addEventHandler(BattleRestartEvent,this.onBattleRestart);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(LocalTankActivationEvent,this.onLocalTankActivated);
      this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.onLocalTankDie);
    }

    private static function createPedestal(param1:Tanks3DSResource) : Object3D {
      var local2:Mesh = Mesh(param1.objects[0]);
      var local3:BSP = new BSP();
      local3.createTree(local2);
      var local4:BitmapData = param1.getTextureForObject(0);
      if(local4 == null) {
        local4 = new StubBitmapData(16776960);
      }
      var local5:TextureMaterial = materialRegistry.getMaterial(local4);
      local5.resolution = 1;
      local3.setMaterialToAllFaces(local5);
      return local3;
    }

    private function ballTouchedImpl(param1:int) : void {
      server.ballTouched(param1);
    }

    public function objectLoadedPost() : void {
      var local1:ClientTeamPoint = null;
      var local2:CommonFlag = null;
      this.battleObject = object;
      this.loadedTanks = new Dictionary();
      this.triggers = new Vector.<FlagBaseTrigger>();
      this.flags = new Dictionary();
      this.basePointDatas = new Dictionary();
      this.ballTouchedServerFunction = getFunctionWrapper(this.ballTouchedImpl);
      for each(local1 in getInitParam().teamPoints) {
        this.basePointDatas[local1.id] = local1;
      }
      this.inventoryModel = IInventoryModel(object.adapt(IInventoryModel));
      this.battleMinesModel = IBattleMinesModel(object.adapt(IBattleMinesModel));
      battleInputService.addGameActionListener(this);
      this.battleEventSupport.activateHandlers();
      this.initTargetEvaluators();
      IFlagModeInitilizer(object.event(IFlagModeInitilizer)).init(getInitParam().flags,getInitParam().teamPoints);
      if(battleInfoService.running) {
        for each(local2 in this.flags) {
          if(local2.carrier != null) {
            FlagNotification(object.adapt(FlagNotification)).guiShowFlagCarried(local2);
          }
        }
      }
    }

    public function objectUnloaded() : void {
      var local1:CommonFlag = null;
      battleInputService.removeGameActionListener(this);
      for each(local1 in this.flags) {
        local1.dispose();
      }
      this.flags = null;
      this.localTank = null;
      this.loadedTanks = null;
      this.triggers = null;
      this.flags = null;
      this.basePointDatas = null;
      this.battleEventSupport.deactivateHandlers();
      this.targetEvaluators = null;
      battleService.setCommonTargetEvaluator(null);
      battleService.setHealingGunTargetEvaluator(null);
      battleService.setRailgunTargetEvaluator(null);
      this.battleObject = null;
    }

    public function flagTaken(param1:int, param2:Long) : void {
      var local5:CommonFlag = null;
      var local3:CommonFlag = this.getFlag(param1);
      local3.stopFalling();
      var local4:Tank = this.loadedTanks[param2];
      if(local4 == null) {
        return;
      }
      if(this.localTank != null && this.localTank == local4) {
        this.setLocalFlagCarrier(local3,param2,local4);
      } else {
        this.setRemoteFlagCarrier(local3,param2,local4);
      }
      if(this.localTank != null || Boolean(battleInfoService.isSpectatorMode())) {
        this.disableFlagPickup(local3);
        if(this.localTank != null && local4 == this.localTank) {
          for each(local5 in this.flags) {
            if(local3 != local5 && local3.teamType == local5.teamType) {
              this.disableFlagPickup(local5);
            }
          }
        }
        FlagNotification(object.adapt(FlagNotification)).notifyFlagTaken(local3,local4);
      }
      FlagNotification(object.adapt(FlagNotification)).guiShowFlagCarried(local3);
    }

    private function handleDropIfLocal(param1:CommonFlag, param2:int) : void {
      if(this.localTank != null) {
        if(this.localTank.isSameTeam(param1.teamType)) {
          this.setFlagCarrierForEvaluators(param1,null);
        }
        if(param1.carrier == this.localTank) {
          if(this.dropCommandSent) {
            this.dropCommandSent = false;
            battleService.getBattleRunner().addLogicUnit(new FlagPickupTimeoutTask(this,param1,getTimer() + param2));
            this.disableFlagPickup(param1);
          }
        } else {
          this.enableFlagPickupWithoutCheck(param1);
        }
      }
    }

    public function flagDelivered(param1:int, param2:int, param3:Long) : void {
      var local5:Tank = null;
      var local4:CommonFlag = this.getFlag(param1);
      this.returnFlag(local4);
      if(this.localTank != null || Boolean(battleInfoService.isSpectatorMode())) {
        local5 = this.loadedTanks[param3];
        if(local5 != null) {
          FlagNotification(object.adapt(FlagNotification)).notifyFlagDelivered(local4,local5);
        }
      }
    }

    public function onEnterFlagBaseZone() : void {
      this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,true);
    }

    public function onLeaveFlagBaseZone() : void {
      this.inventoryModel.lockItem(InventoryItemType.MINE,InventoryLock.FORCED,false);
    }

    public function onFlagTouch(param1:CommonFlag) : void {
      if(param1.registerTouch()) {
        this.sendFullMoveCommand();
        this.ballTouchedServerFunction.apply(null,[param1.id]);
      }
    }

    public function sendFullMoveCommand() : void {
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
    }

    public function onPickupTimeoutPassed(param1:CommonFlag) : void {
      this.tryToEnableFlagPickup(param1);
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(param1 == GameActionEnum.DROP_FLAG && param2) {
        this.sendDropFlagCommand();
      }
    }

    private function sendDropFlagCommand() : void {
      var flag:CommonFlag = null;
      if(Boolean(battleService.isBattleActive()) && this.localTank != null && !this.dropCommandSent) {
        flag = this.getFlagWithCarrier(this.localTank);
        if(flag != null) {
          object = this.battleObject;
          try {
            this.dropCommandSent = true;
            this.sendFullMoveCommand();
            server.dropFlagCommand();
          }
          finally {
            Model.popObject();
          }
        }
      }
    }

    private function getFlagWithCarrier(param1:Tank) : CommonFlag {
      var local2:CommonFlag = null;
      for each(local2 in this.flags) {
        if(local2.carrier == param1) {
          return local2;
        }
      }
      return null;
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      this.loadedTanks[param1.tank.getUser().id] = param1.tank;
      if(param1.isLocal) {
        this.localTank = param1.tank;
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      var local3:CommonFlag = null;
      var local4:Body = null;
      var local5:BodyState = null;
      var local6:Vector3 = null;
      var local2:Tank = param1.tank;
      for each(local3 in this.flags) {
        if(local3.carrier == local2) {
          local4 = local2.getBody();
          local5 = local4.state;
          local6 = local5.position;
          if(battleInfoService.running) {
            object = this.battleObject;
            FlagNotification(object.adapt(FlagNotification)).notifyFlagDropped(local3);
            popObject();
          }
          local3.dropAt(local6);
          break;
        }
      }
      delete this.loadedTanks[local2.getUser().id];
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      var local2:CommonFlag = null;
      for each(local2 in this.flags) {
        if(local2.state == FlagState.CARRIED && local2.carrierId == param1.tank.getUser().id) {
          this.setRemoteFlagCarrier(local2,local2.carrierId,param1.tank);
          this.disableFlagPickup(local2);
          break;
        }
      }
    }

    private function onLocalTankActivated(param1:Object) : void {
      var local2:TeamDMTargetEvaluator = null;
      this.enableFlagsPickup();
      for each(local2 in this.targetEvaluators) {
        local2.setLocalTeamType(this.localTank.teamType);
      }
    }

    private function onLocalTankDie(param1:Object) : void {
      this.disableFlagsPickup();
    }

    private function onBattleRestart(param1:Object) : void {
      var local2:CommonFlag = null;
      var local3:FlagBaseTrigger = null;
      for each(local2 in this.flags) {
        this.returnFlag(local2);
      }
      for each(local3 in this.triggers) {
        local3.reset();
      }
    }

    private function onBattleFinish(param1:Object) : void {
      this.dropCommandSent = false;
      this.disableFlagsPickup();
    }

    private function enableFlagsPickup() : void {
      var local1:CommonFlag = null;
      for each(local1 in this.flags) {
        this.tryToEnableFlagPickup(local1);
      }
    }

    private function disableFlagsPickup() : void {
      var local1:CommonFlag = null;
      for each(local1 in this.flags) {
        this.disableFlagPickup(local1);
      }
    }

    private function tryToEnableFlagPickup(param1:CommonFlag) : void {
      if(this.localTank != null && this.localTank.state == ClientTankState.ACTIVE && Boolean(battleService.isBattleActive()) && param1.state != FlagState.CARRIED && param1.state != FlagState.EXILED) {
        this.enableFlagPickupWithoutCheck(param1);
      }
    }

    private function enableFlagPickupWithoutCheck(param1:CommonFlag) : void {
      battleService.getBattleRunner().addTrigger(param1);
    }

    private function disableFlagPickup(param1:CommonFlag) : void {
      battleService.getBattleRunner().removeTrigger(param1);
    }

    private function setLocalFlagCarrier(param1:CommonFlag, param2:Long, param3:Tank) : void {
      param1.setLocalCarrier(param2,param3);
      this.setupEvaluators(param1,param3);
    }

    private function setRemoteFlagCarrier(param1:CommonFlag, param2:Long, param3:Tank) : void {
      param1.setRemoteCarrier(param2,param3);
      this.setupEvaluators(param1,param3);
    }

    private function setupEvaluators(param1:CommonFlag, param2:Tank) : void {
      if(param2 != null && this.localTank != null && param2.teamType != this.localTank.teamType) {
        this.setFlagCarrierForEvaluators(param1,param2.getBody());
      }
    }

    private function initTargetEvaluators() : void {
      this.targetEvaluators = new Vector.<TeamDMTargetEvaluator>();
      var local1:CTFCommonTargetEvaluator = new CTFCommonTargetEvaluator();
      battleService.setCommonTargetEvaluator(local1);
      this.targetEvaluators.push(local1);
      var local2:TDMHealingGunTargetEvaluator = new TDMHealingGunTargetEvaluator();
      battleService.setHealingGunTargetEvaluator(local2);
      this.targetEvaluators.push(local2);
      var local3:CTFRailgunTargetEvaluator = new CTFRailgunTargetEvaluator();
      battleService.setRailgunTargetEvaluator(local3);
      this.targetEvaluators.push(local3);
      var local4:CTFRicochetTargetEvaluator = new CTFRicochetTargetEvaluator();
      battleService.setRicochetTargetEvaluator(local4);
      this.targetEvaluators.push(local4);
    }

    private function setFlagCarrierForEvaluators(param1:CommonFlag, param2:Body) : void {
      var local3:TeamDMTargetEvaluator = null;
      for each(local3 in this.targetEvaluators) {
        if(local3 is CTFTargetEvaluator) {
          CTFTargetEvaluator(local3).setFlagCarrier(param1,param2);
        }
      }
    }

    private function getFlag(param1:int) : CommonFlag {
      return this.flags[param1];
    }

    public function initFlag(param1:CommonFlag, param2:ClientFlag) : void {
      var local4:Tank = null;
      param1.setTriggerCallback(this);
      param1.returnToBase();
      this.flags[param2.flagId] = param1;
      var local3:BattleScene3D = battleService.getBattleScene3D();
      param1.addToScene();
      local3.addRenderer(param1,1);
      local3.hidableGraphicObjects.add(param1);
      param1.ballTouchedFunction = this.onFlagTouch;
      if(battleInfoService.running) {
        if(param2.flagCarrierId != null) {
          local4 = this.loadedTanks[param2.flagCarrierId];
          this.setRemoteFlagCarrier(param1,param2.flagCarrierId,local4);
        } else if(param2.flagPosition != null && param2.state != FlagState.EXILED && param2.state != FlagState.AT_BASE) {
          if(param2.fallingData.falling) {
            if(param2.state == FlagState.DROPPED) {
              this.dropFlyingFlag(param2.flagId,0,param2.fallingData);
            } else {
              this.throwFlyingFlag(param2.flagId,param2.fallingData);
            }
          } else {
            param1.dropAt(Vector3.fromVector3d(param2.flagPosition));
            FlagNotification(object.adapt(FlagNotification)).guiShowFlagDropped(param1);
          }
        }
      }
    }

    public function createBasePoint(param1:ClientTeamPoint, param2:Tanks3DSResource) : Object3D {
      var local3:Object3D = createPedestal(param2);
      var local4:Vector3 = BattleUtils.getVector3(param1.flagBasePosition);
      local3.x = local4.x;
      local3.y = local4.y;
      local3.z = local4.z;
      battleService.getBattleScene3D().addObject(local3);
      this.addMineProtectedZone(local4);
      this.addTouchTrigger(local4);
      return local3;
    }

    public function getFlags() : Vector.<ClientFlag> {
      return getInitParam().flags;
    }

    public function getPoints() : Vector.<ClientTeamPoint> {
      return getInitParam().teamPoints;
    }

    public function getLocalTank() : Tank {
      return this.localTank;
    }

    public function exileFlag(param1:int) : void {
      this.dropCommandSent = false;
      var local2:CommonFlag = this.getFlag(param1);
      if(local2.state != FlagState.EXILED) {
        BattleUtils.tmpVector.copy(local2.getIndicatorPosition());
        FlagNotification(object.adapt(FlagNotification)).notifyFlagDropped(local2);
        local2.returnToBase();
        this.disableFlagPickup(local2);
        if(battleInfoService.running) {
          BallExplosion(object.adapt(BallExplosion)).createExplosionEffects(BattleUtils.tmpVector);
          FlagNotification(object.adapt(FlagNotification)).notifyReadyToFaceOff();
        }
      }
    }

    public function addMineProtectedZone(param1:Vector3) : void {
      this.addTrigger(param1,this.battleMinesModel.getMinDistanceFromBase(),this);
    }

    public function addTouchTrigger(param1:Vector3) : void {
      this.addTrigger(param1,TEAM_POINT_EQUIVALENT_RADIUS,new FlagBaseTriggerHandler(getFunctionWrapper(this.sendFullMoveCommand)));
    }

    private function addTrigger(param1:Vector3, param2:Number, param3:IFlagBaseTrigerEvents) : void {
      var local4:FlagBaseTrigger = new FlagBaseTrigger(param1,param2,param3,battleService.getBattleRunner().getCollisionDetector());
      this.triggers.push(local4);
      battleService.getBattleRunner().addTrigger(local4);
    }

    public function dropFlyingFlag(param1:int, param2:int, param3:ClientFlagFlyingData) : void {
      var local4:CommonFlag = this.getFlag(param1);
      local4.dropFlying(param3,FlagState.DROPPED);
      this.tryToEnableFlagPickup(local4);
      FlagNotification(object.adapt(FlagNotification)).notifyFlagFacedOff(local4);
    }

    public function throwFlyingFlag(param1:int, param2:ClientFlagFlyingData) : void {
      var local3:CommonFlag = this.getFlag(param1);
      this.handleDropIfLocal(local3,BALL_PICKUP_LOCK_DURATION);
      FlagNotification(object.adapt(FlagNotification)).notifyFlagThrown(local3);
      local3.dropFlying(param2,FlagState.FLYING);
    }

    private function returnFlag(param1:CommonFlag) : void {
      this.dropCommandSent = false;
      param1.returnToBase();
      if(Boolean(this.localTank) && Boolean(this.localTank.teamType)) {
        this.setFlagCarrierForEvaluators(param1,null);
      }
      FlagNotification(object.adapt(FlagNotification)).guiShowFlagAtBase(param1);
    }

    public function returnFlagToBase(param1:int, param2:IGameObject) : void {
      var local3:CommonFlag = this.getFlag(param1);
      this.returnFlag(local3);
      FlagNotification(object.adapt(FlagNotification)).notifyFlagReturned(local3,param2);
    }

    public function dropFlag(param1:int, param2:Vector3d) : void {
      var local3:CommonFlag = this.getFlag(param1);
      if(local3.carrierId != null) {
        this.handleDropIfLocal(local3,FLAG_PICKUP_LOCK_DURATION);
        FlagNotification(object.adapt(FlagNotification)).notifyFlagDropped(local3);
        local3.dropAt(Vector3.fromVector3d(param2));
      }
    }
  }
}
