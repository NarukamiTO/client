package alternativa.tanks.models.weapons.targeting.processor {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.IRayCollisionFilter;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.shared.MarginalCollider;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TanksCollisionDetector;

  public class CommonDirectionProcessor implements TargetingDirectionProcessor {
    [Inject]
    public static var battleService:BattleService;

    private const COS_ALMOST_ZERO_ANGLE:Number = 0.9999;

    private var collisionDetector:TanksCollisionDetector;
    private var maxDistance:Number;
    private var filter:IRayCollisionFilter;
    private var shotFromMuzzle:Boolean = false;

    public function CommonDirectionProcessor(param1:Number, param2:IRayCollisionFilter) {
      super();
      this.maxDistance = param1;
      this.filter = param2;
      this.collisionDetector = battleService.getBattleRunner().getCollisionDetector();
    }

    public function setShotFromMuzzle() : void {
      this.shotFromMuzzle = true;
    }

    protected function raycast(param1:Vector3, param2:Vector3, param3:RayHit) : Boolean {
      if(this.collisionDetector.raycast(param1,param2,CollisionGroup.WEAPON,this.maxDistance,this.filter,param3)) {
        param3.staticHit = !BattleUtils.isTankBody(param3.shape.body) || MarginalCollider.segmentWithStaticIntersection(param1,param3.position);
        return true;
      }
      return false;
    }

    protected function getOrigin(param1:AllGlobalGunParams, param2:Vector3) : Vector3 {
      if(!this.shotFromMuzzle || param2.dot(param1.direction) > this.COS_ALMOST_ZERO_ANGLE) {
        return param1.barrelOrigin;
      }
      return param1.muzzlePosition;
    }

    public function updateMaxDistance(param1:Number) : void {
      this.maxDistance = param1;
    }

    public function process(param1:AllGlobalGunParams, param2:Vector3) : Vector.<RayHit> {
      return undefined;
    }
  }
}
