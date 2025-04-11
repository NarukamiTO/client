package alternativa.physics.collision.primitives {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.types.AABB;

  public class CollisionSphere extends CollisionShape {
    public var r:Number = 0;

    public function CollisionSphere(param1:Number, param2:int, param3:PhysicsMaterial) {
      super(SPHERE,param2,param3);
      this.r = param1;
    }

    override public function calculateAABB() : AABB {
      var local1:AABB = null;
      var local2:Matrix4 = null;
      local1 = this.aabb;
      local2 = this.transform;
      local1.maxX = local2.m03 + this.r;
      local1.minX = local2.m03 - this.r;
      local1.maxY = local2.m13 + this.r;
      local1.minY = local2.m13 - this.r;
      local1.maxZ = local2.m23 + this.r;
      local1.minZ = local2.m23 - this.r;
      return local1;
    }

    override public function raycast(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : Number {
      var local5:Matrix4 = this.transform;
      var local6:Number = param1.x - local5.m03;
      var local7:Number = param1.y - local5.m13;
      var local8:Number = param1.z - local5.m23;
      var local9:Number = param2.x * local6 + param2.y * local7 + param2.z * local8;
      if(local9 > 0) {
        return -1;
      }
      var local10:Number = param2.x * param2.x + param2.y * param2.y + param2.z * param2.z;
      var local11:Number = local9 * local9 - local10 * (local6 * local6 + local7 * local7 + local8 * local8 - this.r * this.r);
      if(local11 < 0) {
        return -1;
      }
      return -(local9 + Math.sqrt(local11)) / local10;
    }

    override public function copyFrom(param1:CollisionShape) : CollisionShape {
      var local2:CollisionSphere = param1 as CollisionSphere;
      if(local2 == null) {
        return this;
      }
      super.copyFrom(local2);
      this.r = local2.r;
      return this;
    }

    override protected function createPrimitive() : CollisionShape {
      return new CollisionSphere(this.r,collisionGroup,material);
    }
  }
}
