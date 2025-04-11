package alternativa.tanks.battle.objects.tank.cheatsemulation {
  import alternativa.math.Quaternion;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.PostPhysicsController;

  public class ZCoordinateFreezer implements PostPhysicsController {
    private var body:Body;
    private var z:Number;
    private var orientation:Quaternion = new Quaternion();

    public function ZCoordinateFreezer(param1:Body) {
      super();
    }

    public function runAfterPhysicsUpdate(param1:Number) : void {
    }
  }
}
