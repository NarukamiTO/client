package alternativa.tanks.models.weapon.shotgun {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.IRayCollisionFilter;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.RayCollisionFilter;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.aiming.ShotGunAimingCC;

  public class ShotgunRicochetTargetingSystem implements IRayCollisionFilter {
    [Inject]
    public static var battleService:BattleService;

    private static const rayHit:RayHit = new RayHit();
    private static const currOrigin:Vector3 = new Vector3();
    private static const currDirection:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();
    private static const matrix:Matrix3 = new Matrix3();

    private var maxDistance:Number;
    private var targetEvaluator:CommonTargetEvaluator;
    private var ricochetCount:int;
    private var shooterBody:Body;
    private var collisionDetector:TanksCollisionDetector;
    private var maxRicochetCount:int;
    private var directions:Vector.<ShotgunTargetingDirection>;
    private var pelletDirectionGenerator:PelletDirectionCalculator;
    private var collisionFilter:RayCollisionFilter = new RayCollisionFilter();
    private var autoAiming:VerticalAutoAiming;
    private var bestDirectionIndexs:Vector.<int>;
    private var angleStep:Number;
    private var countSectors:int;
    private var lengthDirections:int;

    public function ShotgunRicochetTargetingSystem(param1:WeaponObject, param2:PelletDirectionCalculator, param3:ShotGunAimingCC) {
      super();
      this.collisionFilter.exclusion = this.shooterBody;
      this.autoAiming = param1.verticalAutoAiming();
      this.maxDistance = param1.distanceWeakening().getDistance();
      this.targetEvaluator = battleService.getCommonTargetEvaluator();
      this.collisionDetector = battleService.getBattleRunner().getCollisionDetector();
      this.pelletDirectionGenerator = param2;
      this.maxRicochetCount = 1;
      this.lengthDirections = this.autoAiming.getNumRaysUp() + this.autoAiming.getNumRaysDown() + 1;
      this.directions = new Vector.<ShotgunTargetingDirection>(this.lengthDirections);
      this.angleStep = (this.autoAiming.getElevationAngleDown() + this.autoAiming.getElevationAngleUp()) / (this.autoAiming.getNumRaysDown() + this.autoAiming.getNumRaysUp());
      this.countSectors = param3.coneVerticalAngle / this.angleStep;
      this.bestDirectionIndexs = new Vector.<int>(this.countSectors);
    }

    public function considerBody(param1:Body) : Boolean {
      return this.shooterBody != param1 || this.ricochetCount > 0;
    }

    public function getShotDirection(param1:AllGlobalGunParams, param2:Body, param3:Vector3) : Vector.<Tank> {
      var local7:Number = NaN;
      var local8:ShotgunTargetingDirection = null;
      param3.copy(param1.direction);
      this.shooterBody = param2;
      var local4:int = 0;
      var local5:Number = -this.autoAiming.getElevationAngleDown();
      direction.copy(param1.direction);
      matrix.fromAxisAngle(param1.elevationAxis,-this.autoAiming.getElevationAngleDown());
      direction.transform3(matrix);
      matrix.fromAxisAngle(param1.elevationAxis,this.angleStep);
      while(local5 < this.autoAiming.getElevationAngleUp() + this.angleStep && local4 < this.lengthDirections) {
        local7 = this.procesingHitAndGetTargetPriority(param1.barrelOrigin,direction,local5);
        local8 = this.directions[local4];
        if(local8 == null) {
          local8 = new ShotgunTargetingDirection(direction,local7);
        } else {
          local8.init(direction,local7);
        }
        this.directions[local4] = local8;
        local4++;
        local5 += this.angleStep;
        direction.transform3(matrix);
      }
      this.finishTargetSearch(param3);
      var local6:Vector.<Tank> = new Vector.<Tank>();
      this.processDirection(param3,param1,local6);
      return local6;
    }

    private function procesingHitAndGetTargetPriority(param1:Vector3, param2:Vector3, param3:Number) : Number {
      var local5:Body = null;
      this.ricochetCount = 0;
      currOrigin.copy(param1);
      currDirection.copy(param2);
      var local4:Number = this.maxDistance;
      while(local4 > 0) {
        if(!this.collisionDetector.raycast(currOrigin,currDirection,CollisionGroup.WEAPON,local4,this,rayHit)) {
          return 0;
        }
        local4 -= rayHit.t;
        if(local4 < 0) {
          local4 = 0;
        }
        local5 = rayHit.shape.body;
        if(local5.tank != null && local5 != this.shooterBody) {
          return this.calculateTargetPriority(local5,local4,param3);
        }
        if(local5.tank != null) {
          return 0;
        }
        if(!this.processRicochet()) {
          return 0;
        }
      }
      return 0;
    }

    private function calculateTargetPriority(param1:Body, param2:Number, param3:Number) : Number {
      var local4:Number = this.maxDistance - param2;
      return this.targetEvaluator.getTargetPriority(param1,local4,param3,this.maxDistance,Math.max(this.autoAiming.getElevationAngleUp(),this.autoAiming.getElevationAngleDown()));
    }

    private function processRicochet() : Boolean {
      var local1:Vector3 = null;
      if(this.ricochetCount < this.maxRicochetCount) {
        ++this.ricochetCount;
        local1 = rayHit.normal;
        currDirection.addScaled(-2 * currDirection.dot(local1),local1);
        currOrigin.copy(rayHit.position).addScaled(0.5,local1);
        return true;
      }
      return false;
    }

    private function finishTargetSearch(param1:Vector3) : void {
      var local6:Number = NaN;
      var local7:int = 0;
      var local8:int = 0;
      var local9:int = 0;
      this.shooterBody = null;
      var local2:Number = 0;
      var local3:int = 0;
      var local4:int = 0;
      while(local4 < this.directions.length) {
        local6 = 0;
        local7 = this.countSectors / 2;
        local8 = -local7;
        while(local8 <= local7) {
          local9 = local4 + local8;
          if(local9 >= 0 && local9 < this.directions.length) {
            local6 += this.directions[local9].getMaxPriority();
          }
          local8++;
        }
        if(local2 < local6) {
          local2 = local6;
          local3 = 0;
          this.bestDirectionIndexs[local3] = local4;
        } else if(local6 == local2 && local6 > 0) {
          local3++;
          this.bestDirectionIndexs[local3] = local4;
        }
        local4++;
      }
      var local5:ShotgunTargetingDirection = this.directions[this.bestDirectionIndexs[local3 >> 1]];
      if(local5.getMaxPriority() > 0) {
        param1.copy(local5.getDirection());
      }
    }

    private function processDirection(param1:Vector3, param2:AllGlobalGunParams, param3:Vector.<Tank>) : void {
      var local5:Vector3 = null;
      var local4:Vector.<Vector3> = this.pelletDirectionGenerator.getDirectionsFor(param2.elevationAxis,param1.clone());
      param3.length = 0;
      for each(param1 in local4) {
        if(!this.addTargetIfCollision(param2.barrelOrigin,param1,this.maxDistance,param3)) {
          local5 = rayHit.normal;
          currDirection.addScaled(-2 * currDirection.dot(local5),local5);
          currOrigin.copy(rayHit.position).addScaled(0.5,local5);
          this.addTargetIfCollision(currOrigin,currDirection,this.maxDistance,param3);
        }
      }
    }

    private function addTargetIfCollision(param1:Vector3, param2:Vector3, param3:Number, param4:Vector.<Tank>) : Boolean {
      var local5:Tank = null;
      if(this.collisionDetector.raycast(param1,param2,CollisionGroup.WEAPON,param3,this.collisionFilter,rayHit)) {
        local5 = rayHit.shape.body.tank;
        if(local5 != null) {
          param4.push(local5);
          return true;
        }
      }
      return false;
    }
  }
}
