package alternativa.tanks.camera {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;

  public class CameraBookmark {
    [Inject]
    public static var battleService:BattleService;

    public var position:Vector3 = new Vector3();
    public var eulerAnlges:Vector3 = new Vector3();

    public function CameraBookmark() {
      super();
    }

    public function saveCurrentPossitionCamera() : void {
      var local1:GameCamera = battleService.getBattleScene3D().getCamera();
      this.position.x = local1.x;
      this.position.y = local1.y;
      this.position.z = local1.z;
      this.eulerAnlges.x = local1.rotationX;
      this.eulerAnlges.y = local1.rotationY;
      this.eulerAnlges.z = local1.rotationZ;
    }
  }
}
