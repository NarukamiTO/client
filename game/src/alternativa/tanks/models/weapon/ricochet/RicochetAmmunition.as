package alternativa.tanks.models.weapon.ricochet {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;

  public class RicochetAmmunition {
    [Inject]
    public static var battleService:BattleService;

    private var impactForce:Number;
    private var sfxData:RicochetSFXData;
    private var weakening:DistanceWeakening;
    private var callback:RicochetWeaponCallback;
    private var splash:Splash;
    private var initData:RicochetCC;

    public function RicochetAmmunition(param1:WeaponObject, param2:RicochetCC, param3:RicochetSFXData, param4:RicochetWeaponCallback = null) {
      super();
      this.initData = param2;
      this.impactForce = param1.commonData().getImpactForce();
      this.sfxData = param3;
      this.weakening = param1.distanceWeakening();
      this.splash = Splash(param1.getObject().adapt(Splash));
      this.callback = param4;
    }

    public function getShot() : RicochetShot {
      var local1:RicochetShot = RicochetShot(battleService.getObjectPool().getObject(RicochetShot));
      local1.init(this.impactForce,this.initData,this.sfxData,this.weakening,this.callback,this.splash);
      return local1;
    }
  }
}
