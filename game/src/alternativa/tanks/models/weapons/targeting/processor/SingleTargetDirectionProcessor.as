package alternativa.tanks.models.weapons.targeting.processor {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.RayCollisionFilter;
  import platform.client.fp10.core.type.IGameObject;

  public class SingleTargetDirectionProcessor extends CommonDirectionProcessor implements TargetingDirectionProcessor {
    [Inject]
    public static var battleService:BattleService;

    private var collisionFilter:RayCollisionFilter = new RayCollisionFilter();
    private var rayHitResult:RayHit = new RayHit();
    private var rayHits:Vector.<RayHit> = new Vector.<RayHit>();
    private var self:IGameObject;

    public function SingleTargetDirectionProcessor(param1:IGameObject, param2:Number) {
      super(param2,this.collisionFilter);
      this.self = param1;
    }

    override public function process(param1:AllGlobalGunParams, param2:Vector3) : Vector.<RayHit> {
      this.collisionFilter.exclusion = this.getTank(this.self).getBody();
      this.rayHitResult.clear();
      this.rayHits.length = 0;
      if(raycast(getOrigin(param1,param2),param2,this.rayHitResult)) {
        this.rayHits.push(this.rayHitResult.clone());
      }
      return this.rayHits;
    }

    private function getTank(param1:IGameObject) : Tank {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      return local2.getTank();
    }
  }
}
