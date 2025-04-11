package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
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
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapons.targeting.PenetratingTargetingSystem;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.IRailgunModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class RailgunModel extends RailgunModelBase implements IRailgunModelBase, ObjectLoadListener, IWeaponModel, UltimateStunListener, WeaponReloadTimeChangedListener, RailgunCallback, WeaponBuffListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var weapons:Dictionary = new Dictionary();
    private var tanksOnField:Dictionary = new Dictionary();
    private var battleEventSupport:BattleEventSupport;
    private var localWeapon:RailgunWeapon;

    public function RailgunModel() {
      super();
      this.initBattleEventListeners();
    }

    private static function getWeaponCommonData() : WeaponCommonData {
      var local1:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
      return local1.getCommonData();
    }

    private static function getWeaponObject() : WeaponObject {
      return new WeaponObject(object);
    }

    private static function getEffects() : IRailgunEffects {
      var local1:IRailgunSFXModel = IRailgunSFXModel(object.adapt(IRailgunSFXModel));
      return local1.getEffects();
    }

    private static function convertHitPoints(param1:Vector.<Vector3d>) : Vector.<Vector3> {
      var local2:Vector.<Vector3> = null;
      var local3:int = 0;
      var local4:Vector3d = null;
      if(param1 != null) {
        local2 = new Vector.<Vector3>(param1.length);
        local3 = 0;
        while(local3 < param1.length) {
          local4 = param1[local3];
          if(!BattleUtils.isFiniteVector3d(local4)) {
            return null;
          }
          local2[local3] = BattleUtils.getVector3(local4);
          local3++;
        }
        return local2;
      }
      return null;
    }

    private static function convertTargets(param1:Vector.<IGameObject>, param2:Dictionary) : Vector.<Body> {
      var local3:Vector.<Body> = null;
      var local4:int = 0;
      var local5:Tank = null;
      if(param1 != null) {
        local3 = new Vector.<Body>(param1.length);
        local4 = 0;
        while(local4 < param1.length) {
          local5 = param2[param1[local4]];
          if(local5 == null) {
            local3[local4] = null;
          } else {
            local3[local4] = local5.getBody();
          }
          local4++;
        }
        return local3;
      }
      return null;
    }

    private function initBattleEventListeners() : void {
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.activateHandlers();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:RailgunCC = getInitParam();
      putData(RailgunData,new RailgunData(local1.chargingTimeMsec,local1.weakeningCoeff));
    }

    [Obfuscation(rename="false")]
    public function startCharging(param1:IGameObject) : void {
      var local2:RemoteRailgunWeapon = this.weapons[param1];
      if(local2 != null) {
        local2.startCharging();
      }
    }

    [Obfuscation(rename="false")]
    public function fire(param1:IGameObject, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>) : void {
      var local6:Vector.<Vector3> = null;
      var local7:Vector.<Body> = null;
      var local8:int = 0;
      var local9:Body = null;
      var local5:RemoteRailgunWeapon = this.weapons[param1];
      if(local5 != null) {
        local6 = convertHitPoints(param4);
        if(local6 != null) {
          local7 = convertTargets(param3,this.tanksOnField);
          if(param3 != null) {
            if(param3.length == local6.length) {
              local8 = 0;
              while(local8 < param3.length) {
                local9 = local7[local8];
                if(local9 != null && local9.tank != null) {
                  BattleUtils.localToGlobal(local9,local6[local8]);
                }
                local8++;
              }
            } else {
              param3 = null;
              local6 = null;
            }
          }
        }
        local5.fire(BattleUtils.getVector3OrNull(param2),local7,local6);
      }
    }

    [Obfuscation(rename="false")]
    public function fireDummy(param1:IGameObject) : void {
      var local2:RemoteRailgunWeapon = this.weapons[param1];
      if(local2 != null) {
        local2.fireDummy();
      }
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponCommonData = getWeaponCommonData();
      var local3:WeaponObject = getWeaponObject();
      var local4:RailgunData = RailgunData(getData(RailgunData));
      var local5:IRailgunEffects = getEffects();
      var local6:TargetingSystem = new PenetratingTargetingSystem(param1,local3,local4.getWeakeningCoeff());
      var local7:WeaponForces = new WeaponForces(local2.getImpactForce(),local2.getRecoilForce());
      this.localWeapon = new RailgunWeapon(local6,new SimpleWeaponController(),local3,local7,local4.getWeakeningCoeff(),local4.getChargingTime(),local5,RailgunCallback(object.adapt(RailgunCallback)));
      this.weapons[param1] = this.localWeapon;
      return this.localWeapon;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponCommonData = getWeaponCommonData();
      var local3:RailgunData = RailgunData(getData(RailgunData));
      var local4:IRailgunEffects = getEffects();
      var local5:WeaponForces = new WeaponForces(local2.getImpactForce(),local2.getRecoilForce());
      var local6:Weapon = new RemoteRailgunWeapon(local5,local3,local4);
      this.weapons[param1] = local6;
      return local6;
    }

    public function onStartCharging(param1:int) : void {
      server.startChargingCommand(param1);
    }

    public function onShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>) : void {
      var local5:Vector.<IGameObject> = null;
      var local6:Vector.<Vector3d> = null;
      var local7:Vector.<int> = null;
      var local8:Vector.<Vector3d> = null;
      var local10:Vector.<Vector3d> = null;
      var local12:int = 0;
      var local13:Body = null;
      var local14:Vector3 = null;
      var local15:Vector3 = null;
      var local16:Tank = null;
      var local9:int = int(param3.length);
      if(local9 > 0) {
        local5 = new Vector.<IGameObject>(local9);
        local6 = new Vector.<Vector3d>(local9);
        local7 = new Vector.<int>(local9);
        local8 = new Vector.<Vector3d>(local9);
        local10 = new Vector.<Vector3d>(local9);
        local12 = 0;
        while(local12 < local9) {
          local13 = param3[local12];
          local14 = param4[local12];
          local15 = new Vector3();
          local15.copy(local14);
          BattleUtils.globalToLocal(local13,local14);
          local16 = local13.tank;
          local7[local12] = local16.incarnation;
          local5[local12] = local16.getUser();
          local6[local12] = BattleUtils.getVector3d(local14);
          local8[local12] = BattleUtils.getVector3d(local13.state.position);
          local10[local12] = BattleUtils.getVector3d(local15);
          local12++;
        }
      }
      var local11:Vector3d = BattleUtils.getVector3dOrNull(param2);
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.fireCommand(param1,local11,local5,local6,local7,local8,local10);
    }

    public function onShotDummy(param1:int) : void {
      server.fireDummyCommand(param1);
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      this.tanksOnField[param1.tank.getUser()] = param1.tank;
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      delete this.tanksOnField[param1.tank.getUser()];
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      delete this.tanksOnField[param1.tank.getUser()];
    }

    public function immediateReload() : void {
      this.localWeapon.fullyRecharge();
    }

    public function reconfigureWeapon(param1:int) : void {
      if(this.isLocalWeapon()) {
        this.localWeapon.updateChargingTime(param1);
      }
      RailgunData(getData(RailgunData)).setChargingTime(param1);
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        this.localWeapon.stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        this.localWeapon.calm(param3);
      }
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      var local3:Tank = null;
      if(this.isLocalWeapon()) {
        local3 = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
        Weapon(this.weapons[local3.user]).weaponReloadTimeChanged(param1,param2);
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:Weapon = this.weapons[param1];
      if(local4 != null) {
        local4.updateRecoilForce(param3);
        if(local4 == this.localWeapon && !param2) {
          local4.fullyRecharge();
        }
      }
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
    }
  }
}
