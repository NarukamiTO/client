package alternativa.tanks.models.weapon.thunder {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
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
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
  import alternativa.tanks.models.weapons.targeting.CommonTargetingSystem;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.thunder.IThunderModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.thunder.ThunderModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class ThunderModel extends ThunderModelBase implements IThunderModelBase, IWeaponModel, ThunderCallback, WeaponBuffListener, WeaponReloadTimeChangedListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const MAX_DISTANCE:Number = 1000000;

    private var weapons:Dictionary = new Dictionary();
    private var battleEventSupport:BattleEventSupport;

    public function ThunderModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.activateHandlers();
    }

    private static function getCommonData() : WeaponCommonData {
      var local1:IWeaponCommonModel = IWeaponCommonModel(object.adapt(IWeaponCommonModel));
      return local1.getCommonData();
    }

    private static function getWeakening() : DistanceWeakening {
      var local1:IWeaponWeakeningModel = IWeaponWeakeningModel(object.adapt(IWeaponWeakeningModel));
      return local1.getDistanceWeakening();
    }

    private static function getEffects() : IThunderEffects {
      var local1:IThunderSFXModel = IThunderSFXModel(object.adapt(IThunderSFXModel));
      return local1.getEffects();
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponObject = new WeaponObject(object);
      var local3:WeaponCommonData = local2.commonData();
      var local4:DistanceWeakening = getWeakening();
      var local5:Splash = Splash(object.adapt(Splash));
      var local6:IThunderEffects = getEffects();
      var local7:TargetingSystem = new CommonTargetingSystem(param1,local2,MAX_DISTANCE);
      var local8:WeaponForces = new WeaponForces(local3.getImpactForce(),local3.getRecoilForce());
      var local9:Weapon = new ThunderWeapon(local2,local8,local4,local7,local5,local6,ThunderCallback(object.adapt(ThunderCallback)));
      this.weapons[param1] = local9;
      return local9;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponCommonData = getCommonData();
      var local3:DistanceWeakening = getWeakening();
      var local4:IThunderEffects = getEffects();
      var local5:Splash = Splash(object.adapt(Splash));
      var local6:WeaponForces = new WeaponForces(local2.getImpactForce(),local2.getRecoilForce());
      var local7:Weapon = new RemoteThunderWeapon(local6,local3,local5,local4);
      this.weapons[param1] = local7;
      return local7;
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      delete this.weapons[param1.tank.getUser()];
    }

    [Obfuscation(rename="false")]
    public function shoot(param1:IGameObject) : void {
      var local2:RemoteThunderWeapon = this.weapons[param1];
      if(local2 != null) {
        local2.shoot();
      }
    }

    [Obfuscation(rename="false")]
    public function shootStatic(param1:IGameObject, param2:Vector3d) : void {
      var local3:RemoteThunderWeapon = this.weapons[param1];
      if(local3 != null) {
        local3.shootStatic(BattleUtils.getVector3(param2));
      }
    }

    [Obfuscation(rename="false")]
    public function shootTarget(param1:IGameObject, param2:IGameObject, param3:Vector3d) : void {
      var local5:ITankModel = null;
      var local6:Tank = null;
      var local7:Vector3 = null;
      var local4:RemoteThunderWeapon = this.weapons[param1];
      if(local4 != null) {
        local5 = ITankModel(param2.adapt(ITankModel));
        local6 = local5.getTank();
        if(local6.getBody() != null) {
          local7 = BattleUtils.getVector3(param3);
          BattleUtils.localToGlobal(local6.getBody(),local7);
          local4.shootTarget(local6,local7);
        }
      }
    }

    public function onShot(param1:int) : void {
      server.shootCommand(param1);
    }

    public function onShotStatic(param1:int, param2:Vector3) : void {
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.shootStaticCommand(param1,BattleUtils.getVector3d(param2));
    }

    public function onShotTarget(param1:int, param2:Vector3, param3:Body) : void {
      var local4:Vector3 = param2.clone();
      BattleUtils.globalToLocal(param3,local4);
      var local5:Vector3d = BattleUtils.getVector3d(local4);
      var local6:Tank = param3.tank;
      var local7:int = local6.incarnation;
      var local8:Vector3d = BattleUtils.getVector3d(param3.state.position);
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.shootTargetCommand(param1,local5,local6.getUser(),local7,local8,BattleUtils.getVector3d(param2));
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
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
      local4.updateRecoilForce(param3);
      if(!param2) {
        local4.fullyRecharge();
      }
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        Weapon(this.weapons[param1.user]).stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        Weapon(this.weapons[param1.user]).calm(param3);
      }
    }
  }
}
