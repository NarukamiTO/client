package alternativa.tanks.bonuses {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class GroundSpawnRenderer extends PooledObject implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static const SCALE_SPEED:Number = 0.005;

    private var bonus:BattleBonus;
    private var param:Number;

    public function GroundSpawnRenderer(param1:Pool) {
      super(param1);
    }

    public function start(param1:BattleBonus) : void {
      this.bonus = param1;
      this.param = 0;
      param1.onRemove.add(this.destroy);
      param1.onPickup.add(this.destroy);
      param1.onDestroy.add(this.destroy);
      battleService.getBattleScene3D().addRenderer(this,0);
    }

    public function render(param1:int, param2:int) : void {
      this.param += SCALE_SPEED * param2;
      if(this.param > 1) {
        this.param = 1;
      }
      var local3:BonusMesh = this.bonus.getBonusMesh();
      local3.setScale(this.param);
      local3.setAlpha(this.param);
      if(this.param == 1) {
        this.startFlashAnimation();
        this.destroy();
      }
    }

    private function startFlashAnimation() : void {
      var local1:SpawnFlashRenderer = SpawnFlashRenderer(battleService.getObjectPool().getObject(SpawnFlashRenderer));
      local1.start(this.bonus);
    }

    private function destroy() : void {
      battleService.getBattleScene3D().removeRenderer(this,0);
      this.bonus.onRemove.remove(this.destroy);
      this.bonus.onPickup.remove(this.destroy);
      this.bonus.onDestroy.remove(this.destroy);
      this.bonus = null;
      recycle();
    }
  }
}
