package alternativa.tanks.models.weapons.targeting.processor {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.RayCollisionFilter;
  import platform.client.fp10.core.type.IGameObject;

  public class SingleTargetPrecisionDirectionProcessor extends CommonDirectionProcessor implements TargetingDirectionProcessor {
    [Inject]
    public static var battleService:BattleService;

    private var collisionFilter:RayCollisionFilter = new RayCollisionFilter();
    private var rayHitResult:RayHit = new RayHit();
    private var rayHits:Vector.<RayHit> = new Vector.<RayHit>();
    private var self:IGameObject;
    private var additionalPoints:Vector.<Vector3>;
    private var unusedRayHit:RayHit = new RayHit();
    private var _radialVector:Vector3 = new Vector3();
    private var _rotationMatrix:Matrix3 = new Matrix3();
    private var precisionTargetingParams:PrecisionTargetingParams;

    public function SingleTargetPrecisionDirectionProcessor(param1:IGameObject, param2:Number, param3:PrecisionTargetingParams) {
      super(param2,this.collisionFilter);
      this.self = param1;
      this.precisionTargetingParams = param3;
      this.additionalPoints = new Vector.<Vector3>(param3.numRays);
      var local4:int = 0;
      while(local4 < param3.numRays) {
        this.additionalPoints[local4] = new Vector3();
        local4++;
      }
    }

    override public function process(param1:AllGlobalGunParams, param2:Vector3) : Vector.<RayHit> {
      var local4:int = 0;
      var local5:Vector3 = null;
      this.collisionFilter.exclusion = this.getTank(this.self).getBody();
      this.rayHitResult.clear();
      this.rayHits.length = 0;
      var local3:* = getOrigin(param1,param2);
      if(raycast(local3,param2,this.rayHitResult)) {
        this.calculateAdditionalPoints(local3,param2);
        local4 = 0;
        while(local4 < this.additionalPoints.length) {
          local5 = this.additionalPoints[local4];
          if(!raycast(local5,param2,this.unusedRayHit)) {
            return this.rayHits;
          }
          local4++;
        }
        this.rayHits.push(this.rayHitResult.clone());
      }
      return this.rayHits;
    }

    private function calculateAdditionalPoints(param1:Vector3, param2:Vector3) : void {
      this.getRadialVector(param2,this._radialVector);
      this._radialVector.normalize().scale(this.precisionTargetingParams.radius);
      this._rotationMatrix.fromAxisAngle(param2,2 * Math.PI / this.precisionTargetingParams.numRays);
      Vector3(this.additionalPoints[0]).sum(param1,this._radialVector);
      var local3:int = 1;
      while(local3 < this.precisionTargetingParams.numRays) {
        this._radialVector.transform3(this._rotationMatrix);
        Vector3(this.additionalPoints[local3]).sum(param1,this._radialVector);
        local3++;
      }
    }

    private function getRadialVector(param1:Vector3, param2:Vector3) : * {
      var local3:int = 0;
      var local4:Number = 10000000000;
      var local5:Number = param1.x < 0 ? -param1.x : param1.x;
      if(local5 < local4) {
        local4 = local5;
        local3 = 0;
      }
      local5 = param1.y < 0 ? -param1.y : param1.y;
      if(local5 < local4) {
        local4 = local5;
        local3 = 1;
      }
      local5 = param1.z < 0 ? -param1.z : param1.z;
      if(local5 < local4) {
        local3 = 2;
      }
      if(local3 == 0) {
        param2.reset(0,param1.z,-param1.y);
      } else if(local3 == 1) {
        param2.reset(-param1.z,0,param1.x);
      } else if(local3 == 2) {
        param2.reset(param1.y,-param1.x,0);
      }
    }

    private function getTank(param1:IGameObject) : Tank {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      return local2.getTank();
    }
  }
}
