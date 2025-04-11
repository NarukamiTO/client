package alternativa.tanks.models.weapon.shaft {
  import alternativa.math.Vector3;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.controllers.LocalShaftController;
  import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.models.tank.DestroyTankPart;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.InitTankPart;
  import alternativa.tanks.models.tank.speedcharacteristics.SpeedCharacteristics;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAngles;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapon.turret.IRotatingTurretModel;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
  import alternativa.tanks.models.weapons.targeting.ShaftTargetingSystem;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.IShaftModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.shaft.ShaftModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class ShaftModel extends ShaftModelBase implements IShaftModelBase, IWeaponModel, IShaftWeaponCallback, ObjectLoadListener, InitTankPart, DestroyTankPart, WeaponBuffListener, WeaponReloadTimeChangedListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const MAX_DISTANCE:Number = 10000000000;

    private var battleEventSupport:BattleEventSupport;
    private var object3DToTank:Dictionary = new Dictionary();
    private var weapons:Dictionary = new Dictionary();
    private var localUser:IGameObject;
    private var tanksOnField:Dictionary = new Dictionary();

    public function ShaftModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattleEvent);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.activateHandlers();
    }

    private static function getWeakening() : DistanceWeakening {
      var local1:IWeaponWeakeningModel = IWeaponWeakeningModel(object.adapt(IWeaponWeakeningModel));
      return local1.getDistanceWeakening();
    }

    private static function getEffects() : ShaftEffects {
      var local1:IShaftSFXModel = IShaftSFXModel(object.adapt(IShaftSFXModel));
      return local1.getEffects();
    }

    private static function createServerShotData(param1:Vector3, param2:Body, param3:Vector3) : ServerShotData {
      var local4:Vector3d = null;
      var local5:Vector3d = null;
      var local6:Vector3d = null;
      var local7:IGameObject = null;
      var local8:int = 0;
      var local9:Vector3 = null;
      if(param2 != null) {
        local7 = param2.tank.getUser();
        local8 = param2.tank.incarnation;
        local9 = param3;
        local6 = BattleUtils.getVector3d(local9);
        BattleUtils.globalToLocal(param2,local9);
        local4 = BattleUtils.getVector3d(local9);
        local5 = BattleUtils.getVector3d(param2.state.position);
      }
      return new ServerShotData(BattleUtils.getVector3dOrNull(param1),local4,local7,local8,local5,local6);
    }

    public function objectLoaded() : void {
      var local1:ShaftCC = getInitParam();
      local1.shrubsHidingRadiusMin = BattleUtils.toClientScale(local1.shrubsHidingRadiusMin);
      local1.shrubsHidingRadiusMax = BattleUtils.toClientScale(local1.shrubsHidingRadiusMax);
    }

    public function initTankPart(param1:Tank) : void {
      var local2:LocalTurretController = null;
      var local3:ShaftWeapon = null;
      var local4:LocalShaftController = null;
      if(BattleUtils.isLocalTank(param1.user)) {
        local2 = this.asRotatingTurretModel().getLocalTurretController();
        local3 = this.weapons[param1.user];
        local4 = new LocalShaftController(param1,local3,local2);
        local3.setAimingListener(local4);
        putData(LocalShaftController,local4);
      }
    }

    public function destroyTankPart() : void {
      var local1:SimpleWeaponController = SimpleWeaponController(getData(SimpleWeaponController));
      if(local1 != null) {
        local1.destroy();
      }
      var local2:LocalShaftController = LocalShaftController(getData(LocalShaftController));
      if(local2 != null) {
        local2.destroy();
      }
    }

    private function asRotatingTurretModel() : IRotatingTurretModel {
      return IRotatingTurretModel(object.adapt(IRotatingTurretModel));
    }

    [Obfuscation(rename="false")]
    public function stopManulaTargeting(param1:IGameObject) : void {
      var local2:RemoteShaftWeapon = this.weapons[param1];
      if(local2 != null) {
        local2.stopManualTargeting();
      }
    }

    [Obfuscation(rename="false")]
    public function fire(param1:IGameObject, param2:Vector3d, param3:IGameObject, param4:Vector3d, param5:Number) : void {
      var local7:Vector3 = null;
      var local8:Body = null;
      var local9:Tank = null;
      var local6:RemoteShaftWeapon = this.weapons[param1];
      if(local6 != null) {
        local6.stopManualTargeting();
        if(param3 != null) {
          local9 = this.tanksOnField[param3];
          if(local9 == null) {
            local8 = null;
          } else {
            local8 = local9.getBody();
            local7 = BattleUtils.getVector3(param4);
            BattleUtils.localToGlobal(local9.getBody(),local7);
          }
        }
        local6.showShotEffects(BattleUtils.getVector3OrNull(param2),local8,local7,param5);
      }
    }

    [Obfuscation(rename="false")]
    public function activateManualTargeting(param1:IGameObject) : void {
      var local2:RemoteShaftWeapon = this.weapons[param1];
      if(local2 != null) {
        local2.startManualTargeting();
      }
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      this.localUser = param1;
      var local2:SimpleWeaponController = new SimpleWeaponController();
      putData(SimpleWeaponController,local2);
      var local3:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
      var local4:WeaponCommonData = local3.getCommonData();
      var local5:ShaftObject = new ShaftObject(object);
      var local6:TargetingSystem = new ShaftTargetingSystem(param1,local5,MAX_DISTANCE);
      var local7:WeaponForces = new WeaponForces(getInitParam().aimingImpact * WeaponConst.BASE_IMPACT_FORCE.getNumber(),local4.getRecoilForce());
      var local8:VerticalAngles = VerticalAngles(object.adapt(VerticalAngles));
      var local9:ShaftWeapon = new ShaftWeapon(local5,IShaftWeaponCallback(object.adapt(IShaftWeaponCallback)),getInitParam(),local8,local7,this.object3DToTank,param1,local6,getWeakening());
      local2.setWeapon(local9);
      local2.init();
      this.weapons[param1] = local9;
      return local9;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
      var local3:WeaponCommonData = local2.getCommonData();
      var local4:ShaftEffects = getEffects();
      var local5:SpeedCharacteristics = SpeedCharacteristics(param1.adapt(SpeedCharacteristics));
      var local6:IRotatingTurretModel = IRotatingTurretModel(object.adapt(IRotatingTurretModel));
      var local7:Weapon = new RemoteShaftWeapon(local3.getRecoilForce(),getInitParam(),local4,local6.getTurret(),local5,LaserPointer(object.adapt(LaserPointer)));
      this.weapons[param1] = local7;
      return local7;
    }

    public function onAimedShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void {
      var local5:ServerShotData = createServerShotData(param2,param3,param4);
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.aimedShotCommand(param1,local5.staticHitPoint,local5.tank,local5.hitPoint,local5.incarnation,local5.tankPosition,local5.targetPositionGlobal);
    }

    public function onQuickShot(param1:int, param2:Vector3, param3:Body, param4:Vector3) : void {
      var local5:ServerShotData = createServerShotData(param2,param3,param4);
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.quickShotCommand(param1,local5.staticHitPoint,local5.tank,local5.hitPoint,local5.incarnation,local5.tankPosition,local5.targetPositionGlobal);
    }

    public function onBeginEnergyDrain(param1:int) : void {
      server.beginEnergyDrainCommand(param1);
    }

    public function onManualTargetingStart() : void {
      server.activateManualTargetingCommand();
    }

    public function onManualTargetingStop() : void {
      server.stopManualTargetingCommand();
    }

    private function onTankAddedToBattleEvent(param1:TankAddedToBattleEvent) : void {
      this.addTankSkinAssociation(param1.tank);
      this.tanksOnField[param1.tank.getUser()] = param1.tank;
    }

    private function addTankSkinAssociation(param1:Tank) : void {
      var local2:TankSkin = param1.getSkin();
      this.object3DToTank[local2.getHullMesh()] = param1;
      this.object3DToTank[local2.getTurret3D()] = param1;
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      var local2:IGameObject = param1.tank.getUser();
      if(local2 == this.localUser) {
        this.localUser = null;
      }
      delete this.weapons[local2];
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      delete this.tanksOnField[param1.tank.getUser()];
      this.removeTankSkinAssociation(param1.tank.getSkin());
    }

    private function removeTankSkinAssociation(param1:TankSkin) : void {
      delete this.object3DToTank[param1.getHullMesh()];
      delete this.object3DToTank[param1.getTurret3D()];
    }

    public function enteredInManualMode() : void {
      server.activateManualTargetingCommand();
    }

    public function reconfigureWeapon(param1:Number, param2:Number, param3:Boolean) : void {
      var local4:ShaftWeapon = null;
      if(this.isLocalWeapon()) {
        local4 = this.weapons[this.localUser];
        if(local4 != null) {
          local4.reconfigure(param1,param2,param3);
          server.stopManualTargetingCommand();
        }
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:Weapon = this.weapons[param1];
      if(local4 != null) {
        local4.updateRecoilForce(param3);
        local4.fullyRecharge();
      }
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      var local3:ShaftWeapon = null;
      if(this.isLocalWeapon()) {
        local3 = this.weapons[this.localUser];
        if(local3 != null) {
          local3.weaponReloadTimeChanged(param1,param2);
        }
      }
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      var local3:Weapon = null;
      if(param2 && this.localUser != null) {
        local3 = this.weapons[this.localUser];
        if(local3 != null) {
          local3.stun();
        }
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      var local4:Weapon = null;
      if(param2 && this.localUser != null) {
        local4 = this.weapons[this.localUser];
        if(local4 != null) {
          local4.calm(param3);
        }
      }
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
    }
  }
}
