package alternativa.physics.collision.primitives {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.types.AABB;

  public class CollisionBox extends CollisionShape {
    public var hs:Vector3 = new Vector3();

    public function CollisionBox(param1:Vector3, param2:int, param3:PhysicsMaterial) {
      super(BOX,param2,param3);
      this.hs.copy(param1);
    }

    override public function calculateAABB() : AABB {
      var local1:Matrix4 = null;
      var local2:AABB = null;
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      local1 = transform;
      local2 = this.aabb;
      local3 = local1.m00 < 0 ? -local1.m00 : local1.m00;
      local4 = local1.m01 < 0 ? -local1.m01 : local1.m01;
      local5 = local1.m02 < 0 ? -local1.m02 : local1.m02;
      local2.maxX = this.hs.x * local3 + this.hs.y * local4 + this.hs.z * local5;
      local2.minX = -local2.maxX;
      local3 = local1.m10 < 0 ? -local1.m10 : local1.m10;
      local4 = local1.m11 < 0 ? -local1.m11 : local1.m11;
      local5 = local1.m12 < 0 ? -local1.m12 : local1.m12;
      local2.maxY = this.hs.x * local3 + this.hs.y * local4 + this.hs.z * local5;
      local2.minY = -local2.maxY;
      local3 = local1.m20 < 0 ? -local1.m20 : local1.m20;
      local4 = local1.m21 < 0 ? -local1.m21 : local1.m21;
      local5 = local1.m22 < 0 ? -local1.m22 : local1.m22;
      local2.maxZ = this.hs.x * local3 + this.hs.y * local4 + this.hs.z * local5;
      local2.minZ = -local2.maxZ;
      local2.minX += local1.m03;
      local2.maxX += local1.m03;
      local2.minY += local1.m13;
      local2.maxY += local1.m13;
      local2.minZ += local1.m23;
      local2.maxZ += local1.m23;
      return local2;
    }

    override public function copyFrom(param1:CollisionShape) : CollisionShape {
      var local2:CollisionBox = param1 as CollisionBox;
      if(local2 == null) {
        return this;
      }
      super.copyFrom(local2);
      this.hs.copy(local2.hs);
      return this;
    }

    override protected function createPrimitive() : CollisionShape {
      return new CollisionBox(this.hs,collisionGroup,material);
    }

    override public function raycast(param1:Vector3, param2:Vector3, param3:Number, param4:Vector3) : Number {
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local5:Matrix4 = this.transform;
      var local6:Number = -1;
      var local7:Number = 1e+308;
      var local10:Number = param1.x - local5.m03;
      var local11:Number = param1.y - local5.m13;
      var local12:Number = param1.z - local5.m23;
      var local13:Number = local5.m00 * local10 + local5.m10 * local11 + local5.m20 * local12;
      var local14:Number = local5.m01 * local10 + local5.m11 * local11 + local5.m21 * local12;
      var local15:Number = local5.m02 * local10 + local5.m12 * local11 + local5.m22 * local12;
      local10 = local5.m00 * param2.x + local5.m10 * param2.y + local5.m20 * param2.z;
      local11 = local5.m01 * param2.x + local5.m11 * param2.y + local5.m21 * param2.z;
      local12 = local5.m02 * param2.x + local5.m12 * param2.y + local5.m22 * param2.z;
      if(local10 < param3 && local10 > -param3) {
        if(local13 < -this.hs.x || local13 > this.hs.x) {
          return -1;
        }
      } else {
        local8 = (-this.hs.x - local13) / local10;
        local9 = (this.hs.x - local13) / local10;
        if(local8 < local9) {
          if(local8 > local6) {
            local6 = local8;
            param4.x = -1;
            param4.y = param4.z = 0;
          }
          if(local9 < local7) {
            local7 = local9;
          }
        } else {
          if(local9 > local6) {
            local6 = local9;
            param4.x = 1;
            param4.y = param4.z = 0;
          }
          if(local8 < local7) {
            local7 = local8;
          }
        }
        if(local7 < local6) {
          return -1;
        }
      }
      if(local11 < param3 && local11 > -param3) {
        if(local14 < -this.hs.y || local14 > this.hs.y) {
          return -1;
        }
      } else {
        local8 = (-this.hs.y - local14) / local11;
        local9 = (this.hs.y - local14) / local11;
        if(local8 < local9) {
          if(local8 > local6) {
            local6 = local8;
            param4.y = -1;
            param4.x = param4.z = 0;
          }
          if(local9 < local7) {
            local7 = local9;
          }
        } else {
          if(local9 > local6) {
            local6 = local9;
            param4.y = 1;
            param4.x = param4.z = 0;
          }
          if(local8 < local7) {
            local7 = local8;
          }
        }
        if(local7 < local6) {
          return -1;
        }
      }
      if(local12 < param3 && local12 > -param3) {
        if(local15 < -this.hs.z || local15 > this.hs.z) {
          return -1;
        }
      } else {
        local8 = (-this.hs.z - local15) / local12;
        local9 = (this.hs.z - local15) / local12;
        if(local8 < local9) {
          if(local8 > local6) {
            local6 = local8;
            param4.z = -1;
            param4.x = param4.y = 0;
          }
          if(local9 < local7) {
            local7 = local9;
          }
        } else {
          if(local9 > local6) {
            local6 = local9;
            param4.z = 1;
            param4.x = param4.y = 0;
          }
          if(local8 < local7) {
            local7 = local8;
          }
        }
        if(local7 < local6) {
          return -1;
        }
      }
      local10 = param4.x;
      local11 = param4.y;
      local12 = param4.z;
      param4.x = local5.m00 * local10 + local5.m01 * local11 + local5.m02 * local12;
      param4.y = local5.m10 * local10 + local5.m11 * local11 + local5.m12 * local12;
      param4.z = local5.m20 * local10 + local5.m21 * local11 + local5.m22 * local12;
      return local6;
    }
  }
}
