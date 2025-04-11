package alternativa.tanks.models.bonus.region {
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.Renderer;

  public class GoldBonusRegion extends BonusRegion implements Renderer {
    public static const SHOW_TIME:int = 1000;
    public static const HIDE_TIME:int = 3000;

    private var showing:Boolean;
    private var hiding:Boolean;
    private var removeAfterHide:Boolean;
    private var _alphaMultiplier:BonusRegionAlphaMultiplier;

    public function GoldBonusRegion(param1:Mesh, param2:Vector3) {
      super(param1,param2,true);
      this._alphaMultiplier = new BonusRegionAlphaMultiplier();
    }

    override public function addToGame() : void {
      super.addToGame();
      battleService.getBattleScene3D().addRenderer(this,0);
    }

    override public function removeFromGame() : void {
      super.removeFromGame();
      battleService.getBattleScene3D().removeRenderer(this,0);
    }

    override public function hide() : void {
      this.hiding = true;
      this._alphaMultiplier.init(battleService.getBattleRunner().getPhysicsTime(),HIDE_TIME,1);
    }

    override public function show() : void {
      this.showing = true;
      this._alphaMultiplier.init(battleService.getBattleRunner().getPhysicsTime(),SHOW_TIME,0);
    }

    override public function hideAndRemoveFromGame() : void {
      this.removeAfterHide = true;
      this.hide();
    }

    public function render(param1:int, param2:int) : void {
      if(this.showing) {
        mesh.alpha = this.calculateShowingAlphaForTime(param1);
        if(mesh.alpha == 1) {
          this.showing = false;
        }
      }
      if(this.hiding) {
        mesh.alpha = this.calculateHidingAlphaForTime(param1);
        if(mesh.alpha == 0) {
          this.hiding = false;
          if(this.removeAfterHide) {
            this.removeFromGame();
          }
        }
      }
    }

    private function calculateHidingAlphaForTime(param1:int) : Number {
      return this._alphaMultiplier.getAlpha(param1,false);
    }

    private function calculateShowingAlphaForTime(param1:int) : Number {
      return this._alphaMultiplier.getAlpha(param1,true);
    }
  }
}
