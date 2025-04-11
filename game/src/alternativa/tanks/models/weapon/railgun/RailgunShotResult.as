package alternativa.tanks.models.weapon.railgun {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.models.weapons.targeting.TargetingResult;

  public class RailgunShotResult {
    public var staticHitPoint:Vector3 = new Vector3();
    public var staticHitNormal:Vector3 = new Vector3();
    public var hasStaticHit:Boolean;
    public var targets:Vector.<Body> = new Vector.<Body>();
    public var hitPoints:Vector.<Vector3> = new Vector.<Vector3>();
    public var shotDirection:Vector3 = new Vector3();

    public function RailgunShotResult() {
      super();
    }

    public function setFromTargetingResult(param1:TargetingResult) : void {
      var local2:RayHit = null;
      var local3:RayHit = null;
      if(this.hasStaticHit = param1.hasStaticHit()) {
        local3 = param1.getStaticHit();
        this.staticHitPoint.copy(local3.position);
        this.staticHitNormal.copy(local3.normal);
      }
      this.shotDirection.copy(param1.getDirection());
      this.targets.length = 0;
      this.hitPoints.length = 0;
      for each(local2 in param1.getHits()) {
        this.targets.push(local2.shape.body);
        this.hitPoints.push(local2.position);
      }
    }

    public function copyDirectionShotResult(param1:DirectionShotResult) : void {
      var local2:int = int(param1.targets.length);
      var local3:int = 0;
      while(local3 < local2) {
        this.targets[local3] = param1.targets[local3];
        this.hitPoints[local3] = param1.hitPoints[local3];
        local3++;
      }
      this.targets.length = local2;
      this.hitPoints.length = local2;
      this.hasStaticHit = param1.hasStaticHit;
      if(this.hasStaticHit) {
        this.staticHitPoint.copy(param1.staticHitPoint);
        this.staticHitNormal.copy(param1.staticHitNormal);
      }
    }

    public function setStaticHitPoint(param1:Vector3, param2:Vector3) : void {
      this.hasStaticHit = true;
      this.staticHitPoint.copy(param1);
      this.staticHitNormal.copy(param2);
    }

    public function getStaticHitPoint() : Vector3 {
      return this.hasStaticHit ? this.staticHitPoint : null;
    }
  }
}
