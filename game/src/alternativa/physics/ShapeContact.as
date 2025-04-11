package alternativa.physics {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.CollisionShape;

  public class ShapeContact {
    private static var poolSize:int;

    private static const pool:Vector.<ShapeContact> = new Vector.<ShapeContact>();

    public var position:Vector3 = new Vector3();
    public var penetration:Number;
    public var normal:Vector3 = new Vector3();
    public var tangent1:Vector3 = new Vector3();
    public var tangent2:Vector3 = new Vector3();
    public var collisionSpeed:Number;
    public var contactSeparationSpeed:Number;
    public var normalSpeedDelta:Number;
    public var tangentSpeedDelta1:Number;
    public var tangentSpeedDelta2:Number;
    public var normalAngularInertiaTerm1:Number;
    public var normalAngularInertiaTerm2:Number;
    public var tangentAngularInertiaTerm11:Number;
    public var tangentAngularInertiaTerm12:Number;
    public var tangentAngularInertiaTerm21:Number;
    public var tangentAngularInertiaTerm22:Number;
    public var r1:Vector3 = new Vector3();
    public var r2:Vector3 = new Vector3();
    public var normalImpulse:Number;
    public var tangentImpulse1:Number;
    public var tangentImpulse2:Number;
    public var satisfied:Boolean;
    public var restitution:Number;
    public var friction:Number;
    public var shape1:CollisionShape;
    public var shape2:CollisionShape;

    public function ShapeContact() {
      super();
    }

    public static function create() : ShapeContact {
      if(poolSize == 0) {
        return new ShapeContact();
      }
      --poolSize;
      var local1:ShapeContact = pool[poolSize];
      pool[poolSize] = null;
      return local1;
    }

    public function dispose() : void {
      this.shape1 = null;
      this.shape2 = null;
      pool[poolSize] = this;
      ++poolSize;
    }

    public function calculatePersistentFrameData() : void {
      var local1:Body = this.shape1.body;
      var local2:Body = this.shape2.body;
      this.restitution = this.shape1.material.restitution;
      var local3:Number = this.shape2.material.restitution;
      if(local3 < this.restitution) {
        this.restitution = local3;
      }
      this.friction = this.shape1.material.friction;
      var local4:Number = this.shape2.material.friction;
      if(local4 < this.friction) {
        this.friction = local4;
      }
      if(local1.slipperyMode && !local2.movable || local2.slipperyMode && !local1.movable) {
        this.friction = 0;
      }
      var local5:Vector3 = this.shape1.body.state.position;
      this.r1.x = this.position.x - local5.x;
      this.r1.y = this.position.y - local5.y;
      this.r1.z = this.position.z - local5.z;
      local5 = this.shape2.body.state.position;
      this.r2.x = this.position.x - local5.x;
      this.r2.y = this.position.y - local5.y;
      this.r2.z = this.position.z - local5.z;
      if(Math.abs(this.normal.x) < Math.abs(this.normal.y)) {
        this.tangent1.cross2(this.normal,Vector3.X_AXIS).normalize();
      } else {
        this.tangent1.cross2(this.normal,Vector3.Y_AXIS).normalize();
      }
      this.tangent2.cross2(this.normal,this.tangent1);
      this.normalImpulse = 0;
      this.tangentImpulse1 = 0;
      this.tangentImpulse2 = 0;
      this.normalSpeedDelta = 0;
      this.tangentSpeedDelta1 = 0;
      this.tangentSpeedDelta2 = 0;
      if(local1.movable) {
        this.normalAngularInertiaTerm1 = this.calculateAngularInertiaTerm(this.normal,this.r1,local1.invInertiaWorld);
        this.tangentAngularInertiaTerm11 = this.calculateAngularInertiaTerm(this.tangent1,this.r1,local1.invInertiaWorld);
        this.tangentAngularInertiaTerm12 = this.calculateAngularInertiaTerm(this.tangent2,this.r1,local1.invInertiaWorld);
        this.normalSpeedDelta += local1.invMass + this.normalAngularInertiaTerm1;
        this.tangentSpeedDelta1 += local1.invMass + this.tangentAngularInertiaTerm11;
        this.tangentSpeedDelta2 += local1.invMass + this.tangentAngularInertiaTerm12;
      }
      if(local2.movable) {
        this.normalAngularInertiaTerm2 = this.calculateAngularInertiaTerm(this.normal,this.r2,local2.invInertiaWorld);
        this.tangentAngularInertiaTerm21 = this.calculateAngularInertiaTerm(this.tangent1,this.r2,local2.invInertiaWorld);
        this.tangentAngularInertiaTerm22 = this.calculateAngularInertiaTerm(this.tangent2,this.r2,local2.invInertiaWorld);
        this.normalSpeedDelta += local2.invMass + this.normalAngularInertiaTerm2;
        this.tangentSpeedDelta1 += local2.invMass + this.tangentAngularInertiaTerm21;
        this.tangentSpeedDelta2 += local2.invMass + this.tangentAngularInertiaTerm22;
      }
      this.collisionSpeed = this.getSeparationVelocity();
      if(this.collisionSpeed < 0) {
        this.collisionSpeed = -this.restitution * this.collisionSpeed;
      } else {
        this.collisionSpeed = 0;
      }
    }

    private function calculateAngularInertiaTerm(param1:Vector3, param2:Vector3, param3:Matrix3) : Number {
      var local4:Number = param2.y * param1.z - param2.z * param1.y;
      var local5:Number = param2.z * param1.x - param2.x * param1.z;
      var local6:Number = param2.x * param1.y - param2.y * param1.x;
      var local7:Number = param3.m00 * local4 + param3.m01 * local5 + param3.m02 * local6;
      var local8:Number = param3.m10 * local4 + param3.m11 * local5 + param3.m12 * local6;
      var local9:Number = param3.m20 * local4 + param3.m21 * local5 + param3.m22 * local6;
      local4 = local8 * param2.z - local9 * param2.y;
      local5 = local9 * param2.x - local7 * param2.z;
      local6 = local7 * param2.y - local8 * param2.x;
      return local4 * param1.x + local5 * param1.y + local6 * param1.z;
    }

    public function getSeparationVelocity() : Number {
      var local1:Vector3 = this.shape1.body.state.angularVelocity;
      var local2:Number = local1.y * this.r1.z - local1.z * this.r1.y;
      var local3:Number = local1.z * this.r1.x - local1.x * this.r1.z;
      var local4:Number = local1.x * this.r1.y - local1.y * this.r1.x;
      var local5:Vector3 = this.shape1.body.state.velocity;
      var local6:Number = local5.x + local2;
      var local7:Number = local5.y + local3;
      var local8:Number = local5.z + local4;
      local1 = this.shape2.body.state.angularVelocity;
      local2 = local1.y * this.r2.z - local1.z * this.r2.y;
      local3 = local1.z * this.r2.x - local1.x * this.r2.z;
      local4 = local1.x * this.r2.y - local1.y * this.r2.x;
      local5 = this.shape2.body.state.velocity;
      local6 -= local5.x + local2;
      local7 -= local5.y + local3;
      local8 -= local5.z + local4;
      return local6 * this.normal.x + local7 * this.normal.y + local8 * this.normal.z;
    }

    public function calcualteDynamicFrameData(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      var local7:Number = NaN;
      var local5:Body = this.shape1.body;
      var local6:Body = this.shape2.body;
      this.normalSpeedDelta = 0;
      this.tangentSpeedDelta1 = 0;
      this.tangentSpeedDelta2 = 0;
      if(local5.movable) {
        this.normalSpeedDelta += local5.invMass + this.normalAngularInertiaTerm1;
        this.tangentSpeedDelta1 += local5.invMass + this.tangentAngularInertiaTerm11;
        this.tangentSpeedDelta2 += local5.invMass + this.tangentAngularInertiaTerm12;
      }
      if(local6.movable) {
        this.normalSpeedDelta += local6.invMass + this.normalAngularInertiaTerm2;
        this.tangentSpeedDelta1 += local6.invMass + this.tangentAngularInertiaTerm21;
        this.tangentSpeedDelta2 += local6.invMass + this.tangentAngularInertiaTerm22;
      }
      if(this.penetration > param1) {
        local7 = this.penetration - param1;
        if(local7 > param3) {
          local7 = param3;
        }
        this.contactSeparationSpeed = param2 * local7 / param4;
      } else {
        this.contactSeparationSpeed = 0;
      }
    }
  }
}
