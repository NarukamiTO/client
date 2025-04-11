package alternativa.tanks.models.weapon.artillery {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
  import alternativa.tanks.battle.scene3d.Renderer;

  public class ArtilleryCannonEffect implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static const RECOIL_LENGTH:Number = 75;
    private static const RECOIL_TIME:Number = 35;
    private static const EFFECT_TIME:Number = 450;

    private var cannon:Object3D;
    private var elapsedTime:int;
    private var initialCannonY:Number;

    public function ArtilleryCannonEffect(param1:ArtilleryTurretSkin) {
      super();
      this.cannon = param1.getCannon3D();
      this.initialCannonY = this.cannon.y;
    }

    public function run() : void {
      battleService.getBattleScene3D().addRenderer(this);
      this.elapsedTime = 0;
    }

    public function reset() : void {
      this.cannon.y = this.initialCannonY;
      battleService.getBattleScene3D().removeRenderer(this);
    }

    public function render(param1:int, param2:int) : void {
      this.elapsedTime += param2;
      if(this.elapsedTime >= EFFECT_TIME) {
        this.reset();
        return;
      }
      if(this.elapsedTime < RECOIL_TIME) {
        this.cannon.y = this.initialCannonY - this.elapsedTime / RECOIL_TIME * RECOIL_LENGTH;
        return;
      }
      this.cannon.y = this.initialCannonY + (this.elapsedTime - RECOIL_TIME) / (EFFECT_TIME - RECOIL_TIME) * RECOIL_LENGTH - RECOIL_LENGTH;
    }
  }
}
