package alternativa.tanks.models.bonus.region {
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;

  public class BonusRegion {
    [Inject]
    public static var battleService:BattleService;

    protected var mesh:Mesh;
    protected var position:Vector3;

    public function BonusRegion(param1:Mesh, param2:Vector3, param3:Boolean) {
      super();
      this.mesh = param1;
      this.position = param2;
      param1.visible = param3;
    }

    public function addToGame() : void {
      battleService.getBattleScene3D().addObject(this.mesh);
    }

    public function removeFromGame() : void {
      battleService.getBattleScene3D().removeObject(this.mesh);
      this.mesh = null;
    }

    public function showForce() : void {
      this.mesh.visible = true;
    }

    public function hideForce() : void {
      this.mesh.visible = false;
    }

    public function show() : void {
      this.mesh.visible = true;
    }

    public function hide() : void {
      this.mesh.visible = false;
    }

    public function hideAndRemoveFromGame() : void {
      this.hide();
      this.removeFromGame();
    }

    public function getPosition() : Vector3 {
      return this.position;
    }
  }
}
