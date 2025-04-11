package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  public class DirectionShotResult {
    public static const DEFAULT_EFFICIENCY:Number = -100;

    public var shotEfficiency:Number = -100;
    public var targets:Vector.<Body> = new Vector.<Body>();
    public var hitPoints:Vector.<Vector3> = new Vector.<Vector3>();
    public var staticHitPoint:Vector3 = new Vector3();
    public var staticHitNormal:Vector3 = new Vector3();
    public var hasStaticHit:Boolean;
    public var numFriendlyTargets:int;

    public function DirectionShotResult() {
      super();
    }

    public function clear() : void {
      this.targets.length = 0;
      this.hitPoints.length = 0;
      this.shotEfficiency = DEFAULT_EFFICIENCY;
      this.hasStaticHit = false;
      this.numFriendlyTargets = 0;
    }

    public function setStaticHitPoint(param1:Vector3, param2:Vector3) : void {
      this.staticHitPoint.copy(param1);
      this.staticHitNormal.copy(param2);
      this.hasStaticHit = true;
    }

    public function addTarget(param1:Body, param2:Vector3) : void {
      this.targets.push(param1);
      this.hitPoints.push(param2);
    }

    public function addFriendlyTarget(param1:Body, param2:Vector3) : void {
      this.addTarget(param1,param2);
      ++this.numFriendlyTargets;
    }

    public function containsEnemyTargets() : Boolean {
      return this.targets.length > this.numFriendlyTargets;
    }
  }
}
