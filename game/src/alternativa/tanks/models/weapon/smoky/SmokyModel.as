package alternativa.tanks.models.weapon.smoky {
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
  import alternativa.tanks.models.weapon.smoky.sfx.ISmokySFXModel;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
  import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.smoky.ISmokyModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.smoky.SmokyModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class SmokyModel extends SmokyModelBase implements ISmokyModelBase, IWeaponModel, SmokyCallback, WeaponBuffListener, WeaponReloadTimeChangedListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const MAX_TARGETING_DISTANCE:Number = 1000000;

    private var battleEventSupport:BattleEventSupport;
    private var weapons:Dictionary = new Dictionary();
    private var tanksInBattle:Dictionary = new Dictionary();
    private var localWeapon:SmokyWeapon;

    public function SmokyModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.activateHandlers();
    }

    private static function getWeaponCommonData() : WeaponCommonData {
      var local1:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
      return local1.getCommonData();
    }

    private static function getWeakening() : DistanceWeakening {
      var local1:IWeaponWeakeningModel = IWeaponWeakeningModel(object.adapt(IWeaponWeakeningModel));
      return local1.getDistanceWeakening();
    }

    private static function getEffects() : ISmokyEffects {
      var local1:ISmokySFXModel = ISmokySFXModel(object.adapt(ISmokySFXModel));
      return local1.getEffects();
    }

    [Obfuscation(rename="false")]
    public function shoot(param1:IGameObject) : void {
      var local2:RemoteSmokyWeapon = this.weapons[param1];
      if(local2 != null) {
        local2.simulateShot();
      }
    }

    [Obfuscation(rename="false")]
    public function shootStatic(param1:IGameObject, param2:Vector3d) : void {
      var local3:RemoteSmokyWeapon = this.weapons[param1];
      if(local3 != null) {
        local3.simulateStaticShot(BattleUtils.getVector3(param2));
      }
    }

    [Obfuscation(rename="false")]
    public function shootTarget(param1:IGameObject, param2:IGameObject, param3:Vector3d, param4:Number, param5:Boolean) : void {
      var local7:Tank = null;
      var local8:Vector3 = null;
      var local6:RemoteSmokyWeapon = this.weapons[param1];
      if(local6 != null) {
        local7 = this.tanksInBattle[param2];
        if(local7 != null) {
          local8 = BattleUtils.getVector3(param3);
          BattleUtils.localToGlobal(local7.getBody(),local8);
          local6.simulateTargetShot(local7,local8,param4,param5);
        }
      }
    }

    [Obfuscation(rename="false")]
    public function localCriticalHit(param1:IGameObject) : void {
      var local2:Tank = this.tanksInBattle[param1];
      this.localWeapon.createCriticalHitEffect(local2.getBody().state.position);
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponObject = new WeaponObject(object);
      var local3:TargetingSystem = new CommonTargetingSystem(param1,local2,MAX_TARGETING_DISTANCE);
      var local4:WeaponCommonData = getWeaponCommonData();
      var local5:WeaponForces = new WeaponForces(local4.getImpactForce(),local4.getRecoilForce());
      this.localWeapon = new SmokyWeapon(local2,local5,local3,getWeakening(),getEffects(),SmokyCallback(object.adapt(SmokyCallback)),new SimpleWeaponController());
      this.weapons[param1] = this.localWeapon;
      return this.localWeapon;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponCommonData = getWeaponCommonData();
      var local3:WeaponForces = new WeaponForces(local2.getImpactForce(),local2.getRecoilForce());
      var local4:Weapon = new RemoteSmokyWeapon(local3,getEffects());
      this.weapons[param1] = local4;
      return local4;
    }

    public function onShot(param1:int) : void {
      server.fireCommand(param1);
    }

    public function onShotStatic(param1:int, param2:Vector3) : void {
      server.fireStaticCommand(param1,BattleUtils.getVector3d(param2));
    }

    public function onShotTarget(param1:int, param2:Vector3, param3:Body) : void {
      var local4:Tank = param3.tank;
      var local5:Vector3 = param2.clone();
      BattleUtils.globalToLocal(param3,local5);
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.fireTargetCommand(param1,local4.getUser(),local4.incarnation,BattleUtils.getVector3d(param3.state.position),BattleUtils.getVector3d(local5),BattleUtils.getVector3d(param2));
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      this.tanksInBattle[param1.tank.getUser()] = param1.tank;
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      delete this.tanksInBattle[param1.tank.getUser()];
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      var local2:Weapon = this.weapons[param1.tank.getUser()];
      if(local2 == this.localWeapon) {
        this.localWeapon = null;
      }
      delete this.weapons[param1.tank.getUser()];
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
          this.localWeapon.fullyRecharge();
        }
      }
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
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
  }
}
