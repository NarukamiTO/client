package alternativa.tanks.models.weapon.shared {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;
  import flash.utils.Dictionary;

  public class ConicAreaTargetingSystem {
    private static const COLLISION_GROUP:int = CollisionGroup.WEAPON;
    private static const origin:Vector3 = new Vector3();

    private var range:EncryptedNumber;
    private var halfConeAngle:EncryptedNumber;
    private var numRays:int;
    private var numSteps:int;
    private var collisionDetector:TanksCollisionDetector;
    private var targetValidator:ConicAreaTargetValidator;

    private const _xAxis:Vector3 = new Vector3();
    private const matrix:Matrix3 = new Matrix3();
    private const rotationMatrix:Matrix3 = new Matrix3();
    private const rayHit:RayHit = new RayHit();
    private const collisionFilter:ConicTargetingCollisionFilter = new ConicTargetingCollisionFilter();
    private const rayDirection:Vector3 = new Vector3();
    private const muzzlePosition:Vector3 = new Vector3();

    private var distanceByTarget:Dictionary;
    private var hitPointByTarget:Dictionary;

    public function ConicAreaTargetingSystem(param1:Number, param2:Number, param3:int, param4:int, param5:TanksCollisionDetector, param6:ConicAreaTargetValidator) {
      super();
      this.range = new EncryptedNumberImpl(param1);
      this.halfConeAngle = new EncryptedNumberImpl(0.5 * param2);
      this.numRays = param3;
      this.numSteps = param4;
      this.collisionDetector = param5;
      this.targetValidator = param6;
    }

    public function getTargets(param1:Body, param2:Number, param3:Number, param4:Vector3, param5:Vector3, param6:Vector3, param7:Vector.<Body>, param8:Vector.<Number>, param9:Vector.<Vector3>) : void {
      var local16:* = undefined;
      var local17:Number = NaN;
      this.collisionFilter.shooter = param1;
      this.distanceByTarget = new Dictionary();
      this.hitPointByTarget = new Dictionary();
      var local10:Number = param3 * param2;
      var local11:Number = param2 - local10;
      if(this.collisionDetector.raycast(param4,param5,COLLISION_GROUP,param2,this.collisionFilter,this.rayHit) && this.rayHit.shape.body.tank == null) {
        return;
      }
      this._xAxis.copy(param6);
      this.muzzlePosition.copy(param4).addScaled(local10,param5);
      var local12:Number = this.range.getNumber() + local11;
      this.processRay(this.muzzlePosition,param5,local12);
      this.rotationMatrix.fromAxisAngle(param5,Math.PI / this.numSteps);
      var local13:Number = this.halfConeAngle.getNumber() / this.numRays;
      var local14:int = 0;
      while(local14 < this.numSteps) {
        this.processSector(this.muzzlePosition,param5,this._xAxis,local12,this.numRays,local13);
        this.processSector(this.muzzlePosition,param5,this._xAxis,local12,this.numRays,-local13);
        this._xAxis.transform3(this.rotationMatrix);
        local14++;
      }
      var local15:int = 0;
      for(local16 in this.distanceByTarget) {
        param7[local15] = local16;
        local17 = this.distanceByTarget[local16] - local11;
        if(local17 < 0) {
          local17 = 0;
        }
        param8[local15] = local17;
        param9[local15] = this.hitPointByTarget[local16];
        local15++;
      }
      param7.length = local15;
      param8.length = local15;
      this.collisionFilter.shooter = null;
      this.collisionFilter.clearInvalidTargets();
      this.distanceByTarget = null;
    }

    private function processSector(param1:Vector3, param2:Vector3, param3:Vector3, param4:Number, param5:int, param6:Number) : void {
      var local7:Number = 0;
      var local8:int = 0;
      while(local8 < param5) {
        local7 += param6;
        this.matrix.fromAxisAngle(param3,local7);
        this.matrix.transformVector(param2,this.rayDirection);
        this.processRay(param1,this.rayDirection,param4);
        local8++;
      }
    }

    private function processRay(param1:Vector3, param2:Vector3, param3:Number) : void {
      var local5:Body = null;
      var local6:Number = NaN;
      origin.copy(param1);
      var local4:Number = 0;
      if(this.collisionDetector.raycast(origin,param2,COLLISION_GROUP,param3,this.collisionFilter,this.rayHit)) {
        local5 = this.rayHit.shape.body;
        if(local5.tank != null && !MarginalCollider.segmentWithStaticIntersection(origin,this.rayHit.position)) {
          origin.addScaled(this.rayHit.t,param2);
          local4 += this.rayHit.t;
          if(this.targetValidator.isValidTarget(local5)) {
            this.collisionFilter.addTarget(local5);
            local6 = Number(this.distanceByTarget[local5]);
            if(isNaN(local6) || local6 > local4) {
              this.distanceByTarget[local5] = local4;
              this.hitPointByTarget[local5] = this.rayHit.position.clone();
            }
          } else {
            this.collisionFilter.addInvalidTarget(local5);
          }
        }
      }
      this.collisionFilter.clearTargets();
    }

    public function updateRange(param1:Number) : void {
      this.range.setNumber(param1);
    }
  }
}
