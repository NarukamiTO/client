package alternativa.physics.collision.primitives {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.types.AABB;

  public class CollisionTriangle extends CollisionShape {
    public var v0:Vector3 = new Vector3();
    public var v1:Vector3 = new Vector3();
    public var v2:Vector3 = new Vector3();
    public var e0:Vector3 = new Vector3();
    public var e1:Vector3 = new Vector3();
    public var e2:Vector3 = new Vector3();

    public function CollisionTriangle(param1:Vector3, param2:Vector3, param3:Vector3, param4:int, param5:PhysicsMaterial) {
      super(TRIANGLE,param4,param5);
      this.initVertices(param1,param2,param3);
    }

    override public function calculateAABB() : AABB {
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local1:AABB = this.aabb;
      var local2:Matrix4 = this.transform;
      var local3:Number = 0.005;
      var local6:Number = local3 * local2.m02;
      var local7:Number = local3 * local2.m12;
      var local8:Number = local3 * local2.m22;
      local4 = this.v0.x * local2.m00 + this.v0.y * local2.m01;
      local1.minX = local1.maxX = local4 + local6;
      local5 = local4 - local6;
      if(local5 > local1.maxX) {
        local1.maxX = local5;
      } else if(local5 < local1.minX) {
        local1.minX = local5;
      }
      local4 = this.v0.x * local2.m10 + this.v0.y * local2.m11;
      local1.minY = local1.maxY = local4 + local7;
      local5 = local4 - local7;
      if(local5 > local1.maxY) {
        local1.maxY = local5;
      } else if(local5 < local1.minY) {
        local1.minY = local5;
      }
      local4 = this.v0.x * local2.m20 + this.v0.y * local2.m21;
      local1.minZ = local1.maxZ = local4 + local8;
      local5 = local4 - local8;
      if(local5 > local1.maxZ) {
        local1.maxZ = local5;
      } else if(local5 < local1.minZ) {
        local1.minZ = local5;
      }
      local4 = this.v1.x * local2.m00 + this.v1.y * local2.m01;
      local5 = local4 + local6;
      if(local5 > local1.maxX) {
        local1.maxX = local5;
      } else if(local5 < local1.minX) {
        local1.minX = local5;
      }
      local5 = local4 - local6;
      if(local5 > local1.maxX) {
        local1.maxX = local5;
      } else if(local5 < local1.minX) {
        local1.minX = local5;
      }
      local4 = this.v1.x * local2.m10 + this.v1.y * local2.m11;
      local5 = local4 + local7;
      if(local5 > local1.maxY) {
        local1.maxY = local5;
      } else if(local5 < local1.minY) {
        local1.minY = local5;
      }
      local5 = local4 - local7;
      if(local5 > local1.maxY) {
        local1.maxY = local5;
      } else if(local5 < local1.minY) {
        local1.minY = local5;
      }
      local4 = this.v1.x * local2.m20 + this.v1.y * local2.m21;
      local5 = local4 + local8;
      if(local5 > local1.maxZ) {
        local1.maxZ = local5;
      } else if(local5 < local1.minZ) {
        local1.minZ = local5;
      }
      local5 = local4 - local8;
      if(local5 > local1.maxZ) {
        local1.maxZ = local5;
      } else if(local5 < local1.minZ) {
        local1.minZ = local5;
      }
      local4 = this.v2.x * local2.m00 + this.v2.y * local2.m01;
      local5 = local4 + local6;
      if(local5 > local1.maxX) {
        local1.maxX = local5;
      } else if(local5 < local1.minX) {
        local1.minX = local5;
      }
      local5 = local4 - local6;
      if(local5 > local1.maxX) {
        local1.maxX = local5;
      } else if(local5 < local1.minX) {
        local1.minX = local5;
      }
      local4 = this.v2.x * local2.m10 + this.v2.y * local2.m11;
      local5 = local4 + local7;
      if(local5 > local1.maxY) {
        local1.maxY = local5;
      } else if(local5 < local1.minY) {
        local1.minY = local5;
      }
      local5 = local4 - local7;
      if(local5 > local1.maxY) {
        local1.maxY = local5;
      } else if(local5 < local1.minY) {
        local1.minY = local5;
      }
      local4 = this.v2.x * local2.m20 + this.v2.y * local2.m21;
      local5 = local4 + local8;
      if(local5 > local1.maxZ) {
        local1.maxZ = local5;
      } else if(local5 < local1.minZ) {
        local1.minZ = local5;
      }
      local5 = local4 - local8;
      if(local5 > local1.maxZ) {
        local1.maxZ = local5;
      } else if(local5 < local1.minZ) {
        local1.minZ = local5;
      }
      local1.minX += local2.m03;
      local1.maxX += local2.m03;
      local1.minY += local2.m13;
      local1.maxY += local2.m13;
      local1.minZ += local2.m23;
      local1.maxZ += local2.m23;
      return local1;
    }

    override public function raycast(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : Number {
      var local5:Matrix4 = null;
      local5 = this.transform;
      var local6:Number = param2.x * local5.m02 + param2.y * local5.m12 + param2.z * local5.m22;
      if(local6 < param3 && local6 > -param3) {
        return -1;
      }
      var local7:Number = param1.x - local5.m03;
      var local8:Number = param1.y - local5.m13;
      var local9:Number = param1.z - local5.m23;
      var local10:Number = local7 * local5.m02 + local8 * local5.m12 + local9 * local5.m22;
      var local11:Number = -local10 / local6;
      if(local11 < 0) {
        return -1;
      }
      var local12:Number = local7 * local5.m00 + local8 * local5.m10 + local9 * local5.m20;
      var local13:Number = local7 * local5.m01 + local8 * local5.m11 + local9 * local5.m21;
      local7 = local12 + local11 * (param2.x * local5.m00 + param2.y * local5.m10 + param2.z * local5.m20);
      local8 = local13 + local11 * (param2.x * local5.m01 + param2.y * local5.m11 + param2.z * local5.m21);
      if(this.e0.x * (local8 - this.v0.y) - this.e0.y * (local7 - this.v0.x) < 0 || this.e1.x * (local8 - this.v1.y) - this.e1.y * (local7 - this.v1.x) < 0 || this.e2.x * (local8 - this.v2.y) - this.e2.y * (local7 - this.v2.x) < 0) {
        return -1;
      }
      if(param2.x * local5.m02 + param2.y * local5.m12 + param2.z * local5.m22 > 0) {
        param4.x = -local5.m02;
        param4.y = -local5.m12;
        param4.z = -local5.m22;
      } else {
        param4.x = local5.m02;
        param4.y = local5.m12;
        param4.z = local5.m22;
      }
      return local11;
    }

    override public function copyFrom(param1:CollisionShape) : CollisionShape {
      super.copyFrom(param1);
      var local2:CollisionTriangle = param1 as CollisionTriangle;
      if(local2 != null) {
        this.v0.copy(local2.v0);
        this.v1.copy(local2.v1);
        this.v2.copy(local2.v2);
        this.e0.copy(local2.e0);
        this.e1.copy(local2.e1);
        this.e2.copy(local2.e2);
      }
      return this;
    }

    override protected function createPrimitive() : CollisionShape {
      return new CollisionTriangle(this.v0,this.v1,this.v2,collisionGroup,material);
    }

    private function initVertices(param1:Vector3, param2:Vector3, param3:Vector3) : void {
      this.v0.copy(param1);
      this.v1.copy(param2);
      this.v2.copy(param3);
      this.e0.diff(param2,param1);
      this.e0.normalize();
      this.e1.diff(param3,param2);
      this.e1.normalize();
      this.e2.diff(param1,param3);
      this.e2.normalize();
    }
  }
}
