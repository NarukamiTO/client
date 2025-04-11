package alternativa.tanks.models.weapon.gauss {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussEffects;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussSFXData;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussShell;
  import alternativa.tanks.models.weapon.gauss.sfx.IGaussSFXModel;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.splash.SplashParams;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.GaussCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.splash.SplashCC;

  public class CommonGaussWeapon {
    [Inject]
    public static var battleService:BattleService;

    protected var gunParams:AllGlobalGunParams = new AllGlobalGunParams();
    protected var weaponPlatform:WeaponPlatform;
    protected var primaryWeaponForces:WeaponForces;
    protected var secondaryWeaponForces:WeaponForces;
    protected var weaponObject:WeaponObject;
    protected var effects:GaussEffects;
    protected var sfxData:GaussSFXData;

    private var gaussData:GaussCC;
    private var weakening:DistanceWeakening;
    private var callback:GaussWeaponCallback;
    private var splash:Splash;

    protected var enabled:Boolean;

    private var secondarySplashParams:SplashParams;

    public function CommonGaussWeapon(param1:WeaponObject, param2:GaussCC, param3:GaussWeaponCallback = null) {
      super();
      this.weaponObject = param1;
      this.gaussData = param2;
      this.weakening = param1.distanceWeakening();
      var local4:IGaussSFXModel = IGaussSFXModel(param1.getObject().adapt(IGaussSFXModel));
      this.sfxData = local4.getSFXData();
      this.splash = Splash(param1.getObject().adapt(Splash));
      this.callback = param3;
      this.secondaryWeaponForces = new WeaponForces(param2.aimedShotImpact,param2.aimedShotKickback);
      var local5:SplashCC = param2.secondarySplashParams;
      this.secondarySplashParams = new SplashParams(BattleUtils.toClientScale(local5.radiusOfMaxSplashDamage),BattleUtils.toClientScale(local5.splashDamageRadius),local5.minSplashDamagePercent,local5.impactForce * WeaponConst.BASE_IMPACT_FORCE.getNumber());
    }

    public function init(param1:WeaponPlatform) : void {
      this.effects = new GaussEffects(this.weaponObject,this.getSkin(),param1,this.sfxData);
    }

    protected function getSkin() : GaussTurretSkin {
      return GaussSkin(this.weaponObject.getObject().adapt(GaussSkin)).getSkin();
    }

    public function enable() : void {
      this.enabled = true;
    }

    public function disable(param1:Boolean) : void {
      this.enabled = false;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.primaryWeaponForces.setRecoilForce(param1);
    }

    public function applySecondarySplashImpact(param1:Vector3, param2:Body) : void {
      this.splash.applySplashForce(param1,1,param2,this.secondarySplashParams);
    }

    public function getShell() : GaussShell {
      var local1:GaussShell = GaussShell(battleService.getObjectPool().getObject(GaussShell));
      local1.init(this.primaryWeaponForces.getImpactForce(),this.gaussData,this.sfxData,this.weakening,this.callback,this.splash);
      return local1;
    }
  }
}
