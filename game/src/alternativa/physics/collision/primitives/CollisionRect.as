package alternativa.physics.collision.primitives {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.types.AABB;

  public class CollisionRect extends CollisionShape {
    private static const EPSILON:Number = 0.005;

    public var hs:Vector3 = new Vector3();

    public function CollisionRect(param1:Vector3, param2:int, param3:PhysicsMaterial) {
      super(RECT,param2,param3);
      this.hs.copy(param1);
    }

    override public function calculateAABB() : AABB {
      var local1:Matrix4 = null;
      local1 = transform;
      var local2:Number = local1.m00 < 0 ? -local1.m00 : local1.m00;
      var local3:Number = local1.m01 < 0 ? -local1.m01 : local1.m01;
      var local4:Number = local1.m02 < 0 ? -local1.m02 : local1.m02;
      var local5:AABB = this.aabb;
      local5.maxX = this.hs.x * local2 + this.hs.y * local3 + EPSILON * local4;
      local5.minX = -local5.maxX;
      local2 = local1.m10 < 0 ? -local1.m10 : local1.m10;
      local3 = local1.m11 < 0 ? -local1.m11 : local1.m11;
      local4 = local1.m12 < 0 ? -local1.m12 : local1.m12;
      local5.maxY = this.hs.x * local2 + this.hs.y * local3 + EPSILON * local4;
      local5.minY = -local5.maxY;
      local2 = local1.m20 < 0 ? -local1.m20 : local1.m20;
      local3 = local1.m21 < 0 ? -local1.m21 : local1.m21;
      local4 = local1.m22 < 0 ? -local1.m22 : local1.m22;
      local5.maxZ = this.hs.x * local2 + this.hs.y * local3 + EPSILON * local4;
      local5.minZ = -local5.maxZ;
      local5.minX += local1.m03;
      local5.maxX += local1.m03;
      local5.minY += local1.m13;
      local5.maxY += local1.m13;
      local5.minZ += local1.m23;
      local5.maxZ += local1.m23;
      return local5;
    }

    override public function copyFrom(param1:CollisionShape) : CollisionShape {
      var local2:CollisionRect = param1 as CollisionRect;
      if(local2 == null) {
        return this;
      }
      super.copyFrom(local2);
      this.hs.copy(local2.hs);
      return this;
    }

    override protected function createPrimitive() : CollisionShape {
      return new CollisionRect(this.hs,collisionGroup,material);
    }

    override public function raycast(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : Number {
      var local5:Matrix4 = null;
      local5 = this.transform;
      var local6:Number = param1.x - local5.m03;
      var local7:Number = param1.y - local5.m13;
      var local8:Number = param1.z - local5.m23;
      var local9:Number = local5.m00 * local6 + local5.m10 * local7 + local5.m20 * local8;
      var local10:Number = local5.m01 * local6 + local5.m11 * local7 + local5.m21 * local8;
      var local11:Number = local5.m02 * local6 + local5.m12 * local7 + local5.m22 * local8;
      local6 = local5.m00 * param2.x + local5.m10 * param2.y + local5.m20 * param2.z;
      local7 = local5.m01 * param2.x + local5.m11 * param2.y + local5.m21 * param2.z;
      local8 = local5.m02 * param2.x + local5.m12 * param2.y + local5.m22 * param2.z;
      if(local8 > -param3 && local8 < param3) {
        return -1;
      }
      var local12:Number = -local11 / local8;
      if(local12 < 0) {
        return -1;
      }
      local9 += local6 * local12;
      local10 += local7 * local12;
      local11 = 0;
      if(local9 < -this.hs.x - param3 || local9 > this.hs.x + param3 || local10 < -this.hs.y - param3 || local10 > this.hs.y + param3) {
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
      return local12;
    }
  }
}
