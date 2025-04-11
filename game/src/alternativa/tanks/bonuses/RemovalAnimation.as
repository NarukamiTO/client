package alternativa.tanks.bonuses {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class RemovalAnimation extends PooledObject implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static const REMOVAL_ALPHA_SPEED:Number = 0.001;

    private var bonusMesh:BonusMesh;
    private var canRemove:Boolean;

    public function RemovalAnimation(param1:Pool) {
      super(param1);
    }

    public function init(param1:BattleBonus) : void {
      this.bonusMesh = param1.getBonusMesh();
      this.canRemove = false;
      battleService.getBattleScene3D().addRenderer(this,0);
      param1.onPickup.addOnce(this.onBonusPickup);
      param1.onRemove.addOnce(this.onBonusRemove);
    }

    private function onBonusPickup() : void {
      this.bonusMesh = null;
      this.destroy();
    }

    private function onBonusRemove() : void {
      this.canRemove = true;
    }

    public function render(param1:int, param2:int) : void {
      if(this.canRemove) {
        this.fadeOut(param2);
      }
    }

    private function fadeOut(param1:int) : void {
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local2:Number = this.bonusMesh.getAlpha();
      local2 -= REMOVAL_ALPHA_SPEED * param1;
      if(local2 > 0) {
        this.bonusMesh.setAlpha(local2);
        local3 = this.bonusMesh.getScale();
        if(local3 > 0) {
          local4 = local3 - 0.002 * param1;
          if(local4 < 0) {
            local4 = 0;
          }
          this.bonusMesh.setScale(local4);
        }
      } else {
        this.destroy();
      }
    }

    private function destroy() : void {
      battleService.getBattleScene3D().removeRenderer(this,0);
      if(this.bonusMesh != null) {
        this.bonusMesh.removeFromScene();
        this.bonusMesh.recycle();
        this.bonusMesh = null;
      }
      recycle();
    }
  }
}
