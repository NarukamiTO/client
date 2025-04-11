package alternativa.tanks.bonuses {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class SpawnAnimation extends PooledObject implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static const ALPHA_SPEED:Number = 0.001;

    private var object:ISpawnableObject;
    private var alpha:Number = 0;

    public function SpawnAnimation(param1:Pool) {
      super(param1);
    }

    public function start(param1:ISpawnableObject) : void {
      this.object = param1;
      this.alpha = 0;
      param1.addSignal(this.destroy);
      battleService.getBattleScene3D().addRenderer(this,0);
    }

    public function render(param1:int, param2:int) : void {
      this.alpha += ALPHA_SPEED * param2;
      if(this.alpha > 1) {
        this.alpha = 1;
      }
      this.object.setAlpha(this.alpha);
      if(this.alpha >= 1) {
        this.destroy();
      }
    }

    private function destroy() : void {
      if(this.object != null) {
        battleService.getBattleScene3D().removeRenderer(this,0);
        this.object.removeSignal(this.destroy);
        this.object = null;
        recycle();
      }
    }
  }
}
