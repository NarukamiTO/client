package alternativa.physics {
  import alternativa.math.Matrix3;
  import alternativa.math.Matrix4;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.BodyCollisionFilter;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.types.AABB;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class Body {
    public static var linearDamping:Number = 0.997;
    public static var rotationalDamping:Number = 0.997;

    private static const MAX_SPEED_Z:Number = 1500;
    private static const _r:Vector3 = new Vector3();
    private static const _f:Vector3 = new Vector3();

    public var id:int;
    public var tank:Tank;
    public var scene:PhysicsScene;
    public var movable:Boolean = true;
    public var canFreeze:Boolean = false;
    public var freezeCounter:int;
    public var frozen:Boolean = false;
    public var slipperyMode:Boolean = false;
    public var aabb:AABB = new AABB();
    public var postCollisionFilter:BodyCollisionFilter;
    public var acceleration:Vector3 = new Vector3();
    public var angularAcceleration:Vector3 = new Vector3();
    public var prevState:BodyState = new BodyState();
    public var mass:Number = 1;
    public var invMass:Number = 1;
    public var invInertia:Matrix3 = new Matrix3();
    public var invInertiaWorld:Matrix3 = new Matrix3();
    public var baseMatrix:Matrix3 = new Matrix3();
    public var previousVelocity:Vector3 = new Vector3();
    public var state:BodyState = new BodyState();

    private var maxSpeedXY:EncryptedNumber = new EncryptedNumberImpl(0);
    private var maxZSpeedDelta:Number = 600;
    private var minZAcceleration:Number = -1100;

    public var collisionShapes:Vector.<CollisionShape>;
    public var numCollisionShapes:int;
    public var forceAccum:Vector3 = new Vector3();
    public var torqueAccum:Vector3 = new Vector3();
    public var pseudoVelocity:Vector3 = new Vector3();
    public var pseudoAngularVelocity:Vector3 = new Vector3();

    public function Body(param1:Number, param2:Matrix3, param3:Number) {
      super();
      this.mass = param1;
      this.invMass = 1 / param1;
      this.invInertia.copy(param2);
      this.maxSpeedXY.setNumber(param3);
    }

    public function addCollisionShape(param1:CollisionShape, param2:Matrix4 = null) : void {
      if(param1 == null) {
        throw new ArgumentError("Parameter is null");
      }
      if(this.collisionShapes == null) {
        this.collisionShapes = new Vector.<CollisionShape>();
        this.numCollisionShapes = 0;
      }
      this.collisionShapes.push(param1);
      this.numCollisionShapes = this.collisionShapes.length;
      param1.setBody(this,param2);
    }

    public function removeCollisionShape(param1:CollisionShape) : void {
      var local2:int = 0;
      if(this.collisionShapes != null) {
        if(this.numCollisionShapes > 0) {
          local2 = int(this.collisionShapes.indexOf(param1));
          if(local2 >= 0) {
            param1.setBody(null);
            this.collisionShapes[local2] = this.collisionShapes[--this.numCollisionShapes];
            if(this.numCollisionShapes == 0) {
              this.collisionShapes = null;
            } else {
              this.collisionShapes.length = this.numCollisionShapes;
            }
          }
        }
      }
    }

    public function interpolate(param1:Number, param2:Vector3, param3:Quaternion) : void {
      var local4:Number = NaN;
      local4 = 1 - param1;
      param2.x = this.prevState.position.x * local4 + this.state.position.x * param1;
      param2.y = this.prevState.position.y * local4 + this.state.position.y * param1;
      param2.z = this.prevState.position.z * local4 + this.state.position.z * param1;
      param3.w = this.prevState.orientation.w * local4 + this.state.orientation.w * param1;
      param3.x = this.prevState.orientation.x * local4 + this.state.orientation.x * param1;
      param3.y = this.prevState.orientation.y * local4 + this.state.orientation.y * param1;
      param3.z = this.prevState.orientation.z * local4 + this.state.orientation.z * param1;
    }

    public function setPosition(param1:Vector3) : void {
      this.state.position.copy(param1);
    }

    public function setPositionXYZ(param1:Number, param2:Number, param3:Number) : void {
      this.state.position.reset(param1,param2,param3);
    }

    public function setVelocity(param1:Vector3) : void {
      this.state.velocity.copy(param1);
    }

    public function setVelocityXYZ(param1:Number, param2:Number, param3:Number) : void {
      this.state.velocity.reset(param1,param2,param3);
    }

    public function setRotation(param1:Vector3) : void {
      this.state.angularVelocity.copy(param1);
    }

    public function setRotationXYZ(param1:Number, param2:Number, param3:Number) : void {
      this.state.angularVelocity.reset(param1,param2,param3);
    }

    public function setOrientation(param1:Quaternion) : void {
      this.state.orientation.copy(param1);
    }

    public function setMaxSpeedXY(param1:Number) : void {
      this.maxSpeedXY.setNumber(param1);
    }

    public function applyWorldImpulseAtLocalPoint(param1:Vector3, param2:Vector3, param3:Number) : void {
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local4:Number = param3 * this.invMass;
      this.state.velocity.x += local4 * param2.x;
      this.state.velocity.y += local4 * param2.y;
      this.state.velocity.z += local4 * param2.z;
      local5 = (param1.y * param2.z - param1.z * param2.y) * param3;
      local6 = (param1.z * param2.x - param1.x * param2.z) * param3;
      var local7:Number = (param1.x * param2.y - param1.y * param2.x) * param3;
      this.state.angularVelocity.x += this.invInertiaWorld.m00 * local5 + this.invInertiaWorld.m01 * local6 + this.invInertiaWorld.m02 * local7;
      this.state.angularVelocity.y += this.invInertiaWorld.m10 * local5 + this.invInertiaWorld.m11 * local6 + this.invInertiaWorld.m12 * local7;
      this.state.angularVelocity.z += this.invInertiaWorld.m20 * local5 + this.invInertiaWorld.m21 * local6 + this.invInertiaWorld.m22 * local7;
    }

    public function applyWorldPseudoImpulseAtLocalPoint(param1:Vector3, param2:Vector3, param3:Number) : void {
      var local5:Number = NaN;
      var local7:Number = NaN;
      var local4:Number = param3 * this.invMass;
      this.pseudoVelocity.x += local4 * param2.x;
      this.pseudoVelocity.y += local4 * param2.y;
      this.pseudoVelocity.z += local4 * param2.z;
      local5 = (param1.y * param2.z - param1.z * param2.y) * param3;
      var local6:Number = (param1.z * param2.x - param1.x * param2.z) * param3;
      local7 = (param1.x * param2.y - param1.y * param2.x) * param3;
      this.pseudoAngularVelocity.x += this.invInertiaWorld.m00 * local5 + this.invInertiaWorld.m01 * local6 + this.invInertiaWorld.m02 * local7;
      this.pseudoAngularVelocity.y += this.invInertiaWorld.m10 * local5 + this.invInertiaWorld.m11 * local6 + this.invInertiaWorld.m12 * local7;
      this.pseudoAngularVelocity.z += this.invInertiaWorld.m20 * local5 + this.invInertiaWorld.m21 * local6 + this.invInertiaWorld.m22 * local7;
    }

    public function applyImpulse(param1:Vector3, param2:Number) : void {
      var local3:Number = param2 * this.invMass;
      this.state.velocity.x += local3 * param1.x;
      this.state.velocity.y += local3 * param1.y;
      this.state.velocity.z += local3 * param1.z;
    }

    public function addForce(param1:Vector3) : void {
      this.forceAccum.add(param1);
    }

    public function addScaledForce(param1:Vector3, param2:Number) : void {
      this.forceAccum.addScaled(param2,param1);
    }

    public function addForceXYZ(param1:Number, param2:Number, param3:Number) : void {
      this.forceAccum.x += param1;
      this.forceAccum.y += param2;
      this.forceAccum.z += param3;
    }

    public function addWorldForceXYZ(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
      this.forceAccum.x += param4;
      this.forceAccum.y += param5;
      this.forceAccum.z += param6;
      var local7:Vector3 = this.state.position;
      var local8:Number = param1 - local7.x;
      var local9:Number = param2 - local7.y;
      var local10:Number = param3 - local7.z;
      this.torqueAccum.x += local9 * param6 - local10 * param5;
      this.torqueAccum.y += local10 * param4 - local8 * param6;
      this.torqueAccum.z += local8 * param5 - local9 * param4;
    }

    public function addWorldForce(param1:Vector3, param2:Vector3) : void {
      this.forceAccum.add(param2);
      this.torqueAccum.add(_r.diff(param1,this.state.position).cross(param2));
    }

    public function addWorldForceScaled(param1:Vector3, param2:Vector3, param3:Number) : void {
      var local10:Number = NaN;
      var local4:Number = param3 * param2.x;
      var local5:Number = param3 * param2.y;
      var local6:Number = param3 * param2.z;
      this.forceAccum.x += local4;
      this.forceAccum.y += local5;
      this.forceAccum.z += local6;
      var local7:Vector3 = this.state.position;
      var local8:Number = param1.x - local7.x;
      var local9:Number = param1.y - local7.y;
      local10 = param1.z - local7.z;
      this.torqueAccum.x += local9 * local6 - local10 * local5;
      this.torqueAccum.y += local10 * local4 - local8 * local6;
      this.torqueAccum.z += local8 * local5 - local9 * local4;
    }

    public function addLocalForce(param1:Vector3, param2:Vector3) : void {
      this.baseMatrix.transformVector(param1,_r);
      this.baseMatrix.transformVector(param2,_f);
      this.forceAccum.add(_f);
      this.torqueAccum.add(_r.cross(_f));
    }

    public function addWorldForceAtLocalPoint(param1:Vector3, param2:Vector3) : void {
      this.baseMatrix.transformVector(param1,_r);
      this.forceAccum.add(param2);
      this.torqueAccum.add(_r.cross(param2));
    }

    public function addScaledWorldForceAtLocalPoint(param1:Vector3, param2:Vector3, param3:Number) : void {
      this.baseMatrix.transformVector(param1,_r);
      this.forceAccum.addScaled(param3,param2);
      this.torqueAccum.addScaled(param3,_r.cross(param2));
    }

    public function addTorque(param1:Vector3) : void {
      this.torqueAccum.add(param1);
    }

    public function clearAccumulators() : void {
      this.forceAccum.x = this.forceAccum.y = this.forceAccum.z = 0;
      this.torqueAccum.x = this.torqueAccum.y = this.torqueAccum.z = 0;
    }

    public function calcAccelerations() : void {
      this.acceleration.x = this.forceAccum.x * this.invMass;
      this.acceleration.y = this.forceAccum.y * this.invMass;
      this.acceleration.z = this.forceAccum.z * this.invMass;
      this.angularAcceleration.x = this.invInertiaWorld.m00 * this.torqueAccum.x + this.invInertiaWorld.m01 * this.torqueAccum.y + this.invInertiaWorld.m02 * this.torqueAccum.z;
      this.angularAcceleration.y = this.invInertiaWorld.m10 * this.torqueAccum.x + this.invInertiaWorld.m11 * this.torqueAccum.y + this.invInertiaWorld.m12 * this.torqueAccum.z;
      this.angularAcceleration.z = this.invInertiaWorld.m20 * this.torqueAccum.x + this.invInertiaWorld.m21 * this.torqueAccum.y + this.invInertiaWorld.m22 * this.torqueAccum.z;
    }

    public function calcDerivedData() : void {
      var local1:int = 0;
      var local2:CollisionShape = null;
      this.state.orientation.toMatrix3(this.baseMatrix);
      this.invInertiaWorld.copy(this.invInertia).append(this.baseMatrix).prependTransposed(this.baseMatrix);
      if(this.collisionShapes != null) {
        this.aabb.infinity();
        local1 = 0;
        while(local1 < this.numCollisionShapes) {
          local2 = this.collisionShapes[local1];
          local2.transform.setFromMatrix3(this.baseMatrix,this.state.position);
          if(local2.localTransform != null) {
            local2.transform.prepend(local2.localTransform);
          }
          local2.calculateAABB();
          this.aabb.addBoundBox(local2.aabb);
          local1++;
        }
      }
    }

    public function saveState() : void {
      this.prevState.copy(this.state);
    }

    public function restoreState() : void {
      this.state.copy(this.prevState);
    }

    public function integrateVelocity(param1:Number) : void {
      this.integrateLinearVelocity(param1);
      this.integrateAngularVelocity(param1);
    }

    private function integrateLinearVelocity(param1:Number) : void {
      var local7:Number = NaN;
      this.previousVelocity.copy(this.state.velocity);
      if(this.acceleration.z < this.minZAcceleration) {
        this.acceleration.z = this.minZAcceleration;
      }
      this.state.velocity = this.state.velocity.clone();
      this.state.velocity.x += this.acceleration.x * param1;
      this.state.velocity.y += this.acceleration.y * param1;
      this.state.velocity.z += this.acceleration.z * param1;
      this.state.velocity.x *= linearDamping;
      this.state.velocity.y *= linearDamping;
      this.state.velocity.z *= linearDamping;
      var local2:Number = Math.abs(this.state.velocity.z);
      if(local2 > MAX_SPEED_Z) {
        this.state.velocity.z *= MAX_SPEED_Z / local2;
      }
      if(this.state.velocity.z - this.previousVelocity.z > this.maxZSpeedDelta) {
        this.state.velocity.z = this.previousVelocity.z + this.maxZSpeedDelta;
      }
      var local3:Number = this.state.velocity.x;
      var local4:Number = this.state.velocity.y;
      var local5:Number = Math.sqrt(local3 * local3 + local4 * local4);
      var local6:Number = Number(this.maxSpeedXY.getNumber());
      if(local5 > local6) {
        local7 = local6 / local5;
        this.state.velocity.x *= local7;
        this.state.velocity.y *= local7;
      }
    }

    private function integrateAngularVelocity(param1:Number) : void {
      this.state.angularVelocity.x += this.angularAcceleration.x * param1;
      this.state.angularVelocity.y += this.angularAcceleration.y * param1;
      this.state.angularVelocity.z += this.angularAcceleration.z * param1;
      this.state.angularVelocity.x *= rotationalDamping;
      this.state.angularVelocity.y *= rotationalDamping;
      this.state.angularVelocity.z *= rotationalDamping;
      if(this.state.angularVelocity.length() > 10) {
        this.state.angularVelocity.setLength(10);
      }
    }

    public function integratePosition(param1:Number) : void {
      var local2:Vector3 = null;
      local2 = new Vector3();
      var local3:Vector3 = this.state.position;
      var local4:Vector3 = this.state.velocity;
      local2.x = local3.x + local4.x * param1;
      local2.y = local3.y + local4.y * param1;
      local2.z = local3.z + local4.z * param1;
      this.state.position = local2;
      this.state.orientation.addScaledVector(this.state.angularVelocity,param1);
    }

    public function integratePseudoVelocity(param1:Number) : void {
      this.state.position.x += this.pseudoVelocity.x * param1;
      this.state.position.y += this.pseudoVelocity.y * param1;
      this.state.position.z += this.pseudoVelocity.z * param1;
      this.state.orientation.addScaledVector(this.pseudoAngularVelocity,param1);
      this.pseudoVelocity.reset();
      this.pseudoAngularVelocity.reset();
    }

    public function toString() : String {
      return "Body{state=" + String(this.state) + "}";
    }
  }
}
