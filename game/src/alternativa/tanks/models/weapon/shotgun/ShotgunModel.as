package alternativa.tanks.models.weapon.shotgun {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.models.tank.DummyWeapon;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.WeaponUtils;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapon.shotgun.aiming.ShotgunAiming;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunEffects;
  import alternativa.tanks.models.weapon.shotgun.sfx.ShotgunSFX;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.discrete.DiscreteWeaponListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.IShotgunShotModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot.ShotgunShotModelBase;

  [ModelInfo]
  public class ShotgunModel extends ShotgunShotModelBase implements IShotgunShotModelBase, IWeaponModel, DiscreteWeaponListener, WeaponBuffListener, WeaponReloadTimeChangedListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    private var shooter:IGameObject;
    private var gunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private var weapon:ShotgunWeapon;

    public function ShotgunModel() {
      super();
    }

    private static function getEffects() : ShotgunEffects {
      var local1:ShotgunSFX = ShotgunSFX(object.adapt(ShotgunSFX));
      return local1.getEffects();
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      this.shooter = param1;
      this.weapon = new ShotgunWeapon(getInitParam(),new ShotgunObject(object),this.aiming().createTargetingSystem(),getEffects());
      return this.weapon;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      return new DummyWeapon();
    }

    public function onShot(param1:IGameObject, param2:Vector3, param3:Vector.<TargetHit>) : void {
      this.calculateGunParams(param1);
      this.applyImpact(param3);
    }

    private function aiming() : ShotgunAiming {
      return ShotgunAiming(object.adapt(ShotgunAiming));
    }

    private function calculateGunParams(param1:IGameObject) : void {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      var local3:Tank = local2.getTank();
      WeaponUtils.calculateMainGunParams(local3.getTurret3D(),local3.getLocalMuzzlePosition(),this.gunParams);
    }

    private function applyImpact(param1:Vector.<TargetHit>) : void {
      var local5:TargetHit = null;
      var local6:ITankModel = null;
      var local7:Tank = null;
      var local8:Vector3 = null;
      var local9:Number = NaN;
      var local2:WeaponObject = new WeaponObject(object);
      var local3:Number = local2.commonData().getImpactForce();
      var local4:DistanceWeakening = local2.distanceWeakening();
      for each(local5 in param1) {
        local6 = ITankModel(local5.target.adapt(ITankModel));
        local7 = local6.getTank();
        local8 = BattleUtils.getVector3(local5.localHitPoint);
        BattleUtils.localToGlobal(local7.getBody(),local8);
        local9 = local4.getImpactCoeff(local8.distanceTo(this.gunParams.barrelOrigin));
        local7.applyWeaponHit(local8,BattleUtils.getVector3(local5.direction),local3 * local9 * local5.numberHits);
      }
    }

    public function setRemainingShots(param1:int) : void {
      this.weapon.setRemainingShots(param1);
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      if(this.isLocalWeapon()) {
        this.weapon.weaponReloadTimeChanged(param1,param2);
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      getEffects().setBuffed(param2);
      if(param1 == this.shooter) {
        this.weapon.setBuffedMode(param2);
        if(!param2) {
          this.weapon.fullyRecharge();
        }
      }
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        this.weapon.stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        this.weapon.calm(param3);
      }
    }
  }
}
