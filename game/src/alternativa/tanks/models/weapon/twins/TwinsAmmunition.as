package alternativa.tanks.models.weapon.twins {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;

  public class TwinsAmmunition {
    [Inject]
    public static var battleService:BattleService;

    private var weakening:DistanceWeakening;
    private var impactForce:Number;
    private var twinsInitParams:TwinsCC;
    private var sfxData:TwinsSFXData;
    private var callback:TwinsWeaponCallback;
    private var splash:Splash;

    public function TwinsAmmunition(param1:WeaponObject, param2:TwinsCC, param3:TwinsSFXData, param4:TwinsWeaponCallback = null) {
      super();
      this.weakening = param1.distanceWeakening();
      this.impactForce = param1.commonData().getImpactForce();
      this.twinsInitParams = param2;
      this.sfxData = param3;
      this.splash = Splash(param1.getObject().adapt(Splash));
      this.callback = param4;
    }

    public function getShot() : TwinsShot {
      var local1:TwinsShot = TwinsShot(battleService.getObjectPool().getObject(TwinsShot));
      local1.init(this.impactForce,this.twinsInitParams,this.sfxData,this.weakening,this.callback,this.splash);
      return local1;
    }
  }
}
