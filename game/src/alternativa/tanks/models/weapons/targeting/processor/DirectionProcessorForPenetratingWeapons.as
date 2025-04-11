package alternativa.tanks.models.weapons.targeting.processor {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.railgun.MultibodyCollisionFilter;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import platform.client.fp10.core.type.IGameObject;

  public class DirectionProcessorForPenetratingWeapons extends CommonDirectionProcessor implements TargetingDirectionProcessor {
    [Inject]
    public static var battleService:BattleService;

    private var self:IGameObject;
    private var maxDistance:Number;
    private var collisionDetector:TanksCollisionDetector;
    private var multibodyFilter:MultibodyCollisionFilter = new MultibodyCollisionFilter();
    private var rayHitResult:RayHit = new RayHit();
    private var hits:Vector.<RayHit> = new Vector.<RayHit>();

    public function DirectionProcessorForPenetratingWeapons(param1:IGameObject, param2:Number) {
      super(param2,this.multibodyFilter);
      this.self = param1;
      this.maxDistance = param2;
      this.collisionDetector = battleService.getBattleRunner().getCollisionDetector();
    }

    override public function process(param1:AllGlobalGunParams, param2:Vector3) : Vector.<RayHit> {
      this.multibodyFilter.addBody(this.getTank(this.self).getBody());
      this.hits.length = 0;
      while(raycast(getOrigin(param1,param2),param2,this.rayHitResult)) {
        this.hits.push(this.rayHitResult.clone());
        if(this.rayHitResult.staticHit) {
          break;
        }
        this.multibodyFilter.addBody(this.rayHitResult.shape.body);
      }
      this.multibodyFilter.clear();
      return this.hits;
    }

    private function getTank(param1:IGameObject) : Tank {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      return local2.getTank();
    }
  }
}
