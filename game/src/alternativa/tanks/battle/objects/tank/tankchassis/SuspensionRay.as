package alternativa.tanks.battle.objects.tank.tankchassis {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.objects.tank.TankConst;

  public class SuspensionRay {
    public var collisionGroup:int;
    public var hasCollision:Boolean = false;
    public var rayHit:RayHit = new RayHit();
    public var springForce:Number = 0;

    public const contactVelocity:Vector3 = new Vector3();

    public var speed:Number = 0;

    private var body:Body;
    private var origin:Vector3 = new Vector3();
    private var direction:Vector3 = new Vector3();
    private var suspensionParams:SuspensionParams;
    private var globalOrigin:Vector3 = new Vector3();
    private var globalDirection:Vector3 = new Vector3();
    private var prevCompression:Number = 0;
    private var collisionFilter:RayCollisionFilter;

    public function SuspensionRay(param1:Body, param2:Vector3, param3:Vector3, param4:SuspensionParams) {
      super();
      this.body = param1;
      this.origin.copy(param2);
      this.direction.copy(param3);
      this.suspensionParams = param4;
      this.collisionFilter = new RayCollisionFilter(param1);
    }

    public function update(param1:Number) : void {
      this.raycast();
      if(this.hasCollision) {
        this.calculateSpringForce(param1);
        this.calculateContactVelocity();
      }
    }

    private function raycast() : void {
      var local1:Matrix3 = this.body.baseMatrix;
      this.globalDirection.x = local1.m00 * this.direction.x + local1.m01 * this.direction.y + local1.m02 * this.direction.z;
      this.globalDirection.y = local1.m10 * this.direction.x + local1.m11 * this.direction.y + local1.m12 * this.direction.z;
      this.globalDirection.z = local1.m20 * this.direction.x + local1.m21 * this.direction.y + local1.m22 * this.direction.z;
      var local2:Vector3 = this.body.state.position;
      this.globalOrigin.x = local1.m00 * this.origin.x + local1.m01 * this.origin.y + local1.m02 * this.origin.z;
      this.globalOrigin.y = local1.m10 * this.origin.x + local1.m11 * this.origin.y + local1.m12 * this.origin.z;
      this.globalOrigin.z = local1.m20 * this.origin.x + local1.m21 * this.origin.y + local1.m22 * this.origin.z;
      this.globalOrigin.x += local2.x;
      this.globalOrigin.y += local2.y;
      this.globalOrigin.z += local2.z;
      if(this.hasCollision) {
        this.prevCompression = this.suspensionParams.maxRayLength - this.rayHit.t;
      }
      this.hasCollision = this.body.scene.collisionDetector.raycast(this.globalOrigin,this.globalDirection,this.collisionGroup,this.suspensionParams.maxRayLength,this.collisionFilter,this.rayHit);
      if(this.hasCollision) {
        this.hasCollision = this.rayHit.normal.z > TankConst.MAX_SLOPE_ANGLE_COS;
      }
    }

    public function calculateSpringForce(param1:Number) : void {
      var local2:Number = this.suspensionParams.maxRayLength - this.rayHit.t;
      this.springForce = this.suspensionParams.springCoeff * local2;
      var local3:Number = (local2 - this.prevCompression) / param1;
      this.springForce += local3 * this.suspensionParams.dampingCoeff;
      if(this.springForce < 0) {
        this.springForce = 0;
      }
    }

    private function calculateContactVelocity() : void {
      var local2:Vector3 = null;
      var local3:Vector3 = null;
      var local4:Vector3 = null;
      var local5:Vector3 = null;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local1:Body = this.rayHit.shape.body;
      if(local1.tank != null) {
        local2 = local1.state.position;
        local3 = local1.state.velocity;
        local4 = local1.state.angularVelocity;
        local5 = this.rayHit.position;
        local6 = local5.x - local2.x;
        local7 = local5.y - local2.y;
        local8 = local5.z - local2.z;
        this.contactVelocity.x = local4.y * local8 - local4.z * local7;
        this.contactVelocity.y = local4.z * local6 - local4.x * local8;
        this.contactVelocity.z = local4.x * local7 - local4.y * local6;
        this.contactVelocity.x += local3.x;
        this.contactVelocity.y += local3.y;
        this.contactVelocity.z += local3.z;
      } else {
        this.contactVelocity.x = 0;
        this.contactVelocity.y = 0;
        this.contactVelocity.z = 0;
      }
    }

    public function getGlobalOrigin() : Vector3 {
      return this.globalOrigin;
    }

    public function getGlobalDirection() : Vector3 {
      return this.globalDirection;
    }

    public function getOrigin() : Vector3 {
      return this.origin;
    }
  }
}
