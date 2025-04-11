package alternativa.tanks.models.weapon.shaft {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  public class AimedShotResult {
    public var staticHitPoint:Vector3;
    public var target:Body;
    public var targetHitPoint:Vector3;

    public function AimedShotResult() {
      super();
    }

    public function setTarget(param1:Body, param2:Vector3) : void {
      this.target = param1;
      this.targetHitPoint = param2;
    }

    public function setStaticHitPoint(param1:Vector3) : void {
      this.staticHitPoint = param1.clone();
    }
  }
}
