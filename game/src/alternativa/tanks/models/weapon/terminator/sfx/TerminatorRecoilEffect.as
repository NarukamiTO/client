package alternativa.tanks.models.weapon.terminator.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.Renderer;

  public class TerminatorRecoilEffect implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static const RECOIL_LENGTH:Number = 100;
    private static const RECOIL_TIME:Number = 35;
    private static const EFFECT_TIME:Number = 450;

    private var barrel3D:Object3D;
    private var elapsedTime:int;
    private var initialBarrelY:Number;

    public function TerminatorRecoilEffect(param1:Object3D) {
      super();
      this.barrel3D = param1;
      this.initialBarrelY = param1.y;
    }

    public function run(param1:int) : void {
      battleService.getBattleScene3D().addRenderer(this);
      this.elapsedTime = 0;
    }

    public function reset() : void {
      this.barrel3D.y = this.initialBarrelY;
      battleService.getBattleScene3D().removeRenderer(this);
    }

    public function render(param1:int, param2:int) : void {
      this.elapsedTime += param2;
      if(this.elapsedTime >= EFFECT_TIME) {
        this.reset();
        return;
      }
      if(this.elapsedTime < RECOIL_TIME) {
        this.barrel3D.y = this.initialBarrelY - this.elapsedTime / RECOIL_TIME * RECOIL_LENGTH;
        return;
      }
      this.barrel3D.y = this.initialBarrelY + (this.elapsedTime - RECOIL_TIME) / (EFFECT_TIME - RECOIL_TIME) * RECOIL_LENGTH - RECOIL_LENGTH;
    }
  }
}
