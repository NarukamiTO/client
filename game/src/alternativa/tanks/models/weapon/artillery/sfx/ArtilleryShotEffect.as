package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;

  public class ArtilleryShotEffect {
    [Inject]
    public static var battleService:BattleService;

    private var flameLeft:ArtilleryFlame;
    private var flameCenter:ArtilleryFlame;
    private var flameRight:ArtilleryFlame;
    private var sfxData:ArtillerySfxData;

    public function ArtilleryShotEffect(param1:ArtillerySfxData) {
      super();
      this.sfxData = param1;
    }

    public function run(param1:AllGlobalGunParams) : void {
      this.flameLeft = ArtilleryFlame(battleService.getObjectPool().getObject(ArtilleryFlame));
      this.flameCenter = ArtilleryFlame(battleService.getObjectPool().getObject(ArtilleryFlame));
      this.flameRight = ArtilleryFlame(battleService.getObjectPool().getObject(ArtilleryFlame));
      var local2:Vector3 = param1.elevationAxis.clone().scale(-1);
      this.flameLeft.init(param1.muzzlePosition,local2,this.sfxData);
      this.flameCenter.init(param1.muzzlePosition,param1.direction,this.sfxData,true);
      this.flameRight.init(param1.muzzlePosition,param1.elevationAxis,this.sfxData);
    }
  }
}
