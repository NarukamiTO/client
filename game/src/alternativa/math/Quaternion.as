package alternativa.math {
  import flash.geom.Vector3D;
  import flash.utils.getQualifiedClassName;

  public class Quaternion {
    private static const _q:Quaternion = new Quaternion();

    public var w:Number;
    public var x:Number;
    public var y:Number;
    public var z:Number;

    public function Quaternion(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0) {
      super();
      this.w = param1;
      this.x = param2;
      this.y = param3;
      this.z = param4;
    }

    public static function multiply(param1:Quaternion, param2:Quaternion, param3:Quaternion) : void {
      param3.w = param1.w * param2.w - param1.x * param2.x - param1.y * param2.y - param1.z * param2.z;
      param3.x = param1.w * param2.x + param1.x * param2.w + param1.y * param2.z - param1.z * param2.y;
      param3.y = param1.w * param2.y + param1.y * param2.w + param1.z * param2.x - param1.x * param2.z;
      param3.z = param1.w * param2.z + param1.z * param2.w + param1.x * param2.y - param1.y * param2.x;
    }

    public static function createFromAxisAngle(param1:Vector3, param2:Number) : Quaternion {
      var local3:Quaternion = new Quaternion();
      local3.setFromAxisAngle(param1,param2);
      return local3;
    }

    public static function createFromAxisAngleComponents(param1:Number, param2:Number, param3:Number, param4:Number) : Quaternion {
      var local5:Quaternion = new Quaternion();
      local5.setFromAxisAngleComponents(param1,param2,param3,param4);
      return local5;
    }

    public function reset(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0) : Quaternion {
      this.w = param1;
      this.x = param2;
      this.y = param3;
      this.z = param4;
      return this;
    }

    public function normalize() : Quaternion {
      var local1:Number = this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
      if(local1 == 0) {
        this.w = 1;
      } else {
        local1 = 1 / Math.sqrt(local1);
        this.w *= local1;
        this.x *= local1;
        this.y *= local1;
        this.z *= local1;
      }
      return this;
    }

    public function prepend(param1:Quaternion) : Quaternion {
      var local2:Number = this.w * param1.w - this.x * param1.x - this.y * param1.y - this.z * param1.z;
      var local3:Number = this.w * param1.x + this.x * param1.w + this.y * param1.z - this.z * param1.y;
      var local4:Number = this.w * param1.y + this.y * param1.w + this.z * param1.x - this.x * param1.z;
      var local5:Number = this.w * param1.z + this.z * param1.w + this.x * param1.y - this.y * param1.x;
      this.w = local2;
      this.x = local3;
      this.y = local4;
      this.z = local5;
      return this;
    }

    public function append(param1:Quaternion) : Quaternion {
      var local2:Number = param1.w * this.w - param1.x * this.x - param1.y * this.y - param1.z * this.z;
      var local3:Number = param1.w * this.x + param1.x * this.w + param1.y * this.z - param1.z * this.y;
      var local4:Number = param1.w * this.y + param1.y * this.w + param1.z * this.x - param1.x * this.z;
      var local5:Number = param1.w * this.z + param1.z * this.w + param1.x * this.y - param1.y * this.x;
      this.w = local2;
      this.x = local3;
      this.y = local4;
      this.z = local5;
      return this;
    }

    public function rotateByVector(param1:Vector3) : Quaternion {
      var local2:Number = -param1.x * this.x - param1.y * this.y - param1.z * this.z;
      var local3:Number = param1.x * this.w + param1.y * this.z - param1.z * this.y;
      var local4:Number = param1.y * this.w + param1.z * this.x - param1.x * this.z;
      var local5:Number = param1.z * this.w + param1.x * this.y - param1.y * this.x;
      this.w = local2;
      this.x = local3;
      this.y = local4;
      this.z = local5;
      return this;
    }

    public function addScaledVector(param1:Vector3, param2:Number) : Quaternion {
      var local3:Number = param1.x * param2;
      var local4:Number = param1.y * param2;
      var local5:Number = param1.z * param2;
      var local6:Number = -this.x * local3 - this.y * local4 - this.z * local5;
      var local7:Number = local3 * this.w + local4 * this.z - local5 * this.y;
      var local8:Number = local4 * this.w + local5 * this.x - local3 * this.z;
      var local9:Number = local5 * this.w + local3 * this.y - local4 * this.x;
      this.w += 0.5 * local6;
      this.x += 0.5 * local7;
      this.y += 0.5 * local8;
      this.z += 0.5 * local9;
      var local10:Number = this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
      if(local10 == 0) {
        this.w = 1;
      } else {
        local10 = 1 / Math.sqrt(local10);
        this.w *= local10;
        this.x *= local10;
        this.y *= local10;
        this.z *= local10;
      }
      return this;
    }

    public function toMatrix3(param1:Matrix3) : Quaternion {
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local2:Number = 2 * this.x * this.x;
      var local3:Number = 2 * this.y * this.y;
      var local4:Number = 2 * this.z * this.z;
      var local5:Number = 2 * this.x * this.y;
      var local6:Number = 2 * this.y * this.z;
      local7 = 2 * this.z * this.x;
      local8 = 2 * this.w * this.x;
      local9 = 2 * this.w * this.y;
      var local10:Number = 2 * this.w * this.z;
      param1.m00 = 1 - local3 - local4;
      param1.m01 = local5 - local10;
      param1.m02 = local7 + local9;
      param1.m10 = local5 + local10;
      param1.m11 = 1 - local2 - local4;
      param1.m12 = local6 - local8;
      param1.m20 = local7 - local9;
      param1.m21 = local6 + local8;
      param1.m22 = 1 - local2 - local3;
      return this;
    }

    public function getYAxis(param1:Vector3) : Vector3 {
      var local3:Number = NaN;
      var local2:Number = 2 * this.x * this.x;
      local3 = 2 * this.z * this.z;
      var local4:Number = 2 * this.x * this.y;
      var local5:Number = 2 * this.y * this.z;
      var local6:Number = 2 * this.w * this.x;
      var local7:Number = 2 * this.w * this.z;
      param1.x = local4 - local7;
      param1.y = 1 - local2 - local3;
      param1.z = local5 + local6;
      return param1;
    }

    public function getZAxis(param1:Vector3) : Vector3 {
      var local6:Number = NaN;
      var local2:Number = 2 * this.x * this.x;
      var local3:Number = 2 * this.y * this.y;
      var local4:Number = 2 * this.y * this.z;
      var local5:Number = 2 * this.z * this.x;
      local6 = 2 * this.w * this.x;
      var local7:Number = 2 * this.w * this.y;
      param1.x = local5 + local7;
      param1.y = local4 - local6;
      param1.z = 1 - local2 - local3;
      return param1;
    }

    public function toMatrix4(param1:Matrix4) : Quaternion {
      var local2:Number = NaN;
      var local4:Number = NaN;
      var local6:Number = NaN;
      var local8:Number = NaN;
      local2 = 2 * this.x * this.x;
      var local3:Number = 2 * this.y * this.y;
      local4 = 2 * this.z * this.z;
      var local5:Number = 2 * this.x * this.y;
      local6 = 2 * this.y * this.z;
      var local7:Number = 2 * this.z * this.x;
      local8 = 2 * this.w * this.x;
      var local9:Number = 2 * this.w * this.y;
      var local10:Number = 2 * this.w * this.z;
      param1.m00 = 1 - local3 - local4;
      param1.m01 = local5 - local10;
      param1.m02 = local7 + local9;
      param1.m10 = local5 + local10;
      param1.m11 = 1 - local2 - local4;
      param1.m12 = local6 - local8;
      param1.m20 = local7 - local9;
      param1.m21 = local6 + local8;
      param1.m22 = 1 - local2 - local3;
      return this;
    }

    public function length() : Number {
      return Math.sqrt(this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z);
    }

    public function lengthSqr() : Number {
      return this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
    }

    public function setFromAxisAngle(param1:Vector3, param2:Number) : Quaternion {
      this.w = Math.cos(0.5 * param2);
      var local3:Number = Math.sin(0.5 * param2) / Math.sqrt(param1.x * param1.x + param1.y * param1.y + param1.z * param1.z);
      this.x = param1.x * local3;
      this.y = param1.y * local3;
      this.z = param1.z * local3;
      return this;
    }

    public function setFromAxisAngleComponents(param1:Number, param2:Number, param3:Number, param4:Number) : Quaternion {
      this.w = Math.cos(0.5 * param4);
      var local5:Number = Math.sin(0.5 * param4) / Math.sqrt(param1 * param1 + param2 * param2 + param3 * param3);
      this.x = param1 * local5;
      this.y = param2 * local5;
      this.z = param3 * local5;
      return this;
    }

    public function toAxisVector(param1:Vector3 = null) : Vector3 {
      var local2:Number = NaN;
      var local3:Number = NaN;
      if(this.w < -1 || this.w > 1) {
        this.normalize();
      }
      if(param1 == null) {
        param1 = new Vector3();
      }
      if(this.w > -1 && this.w < 1) {
        if(this.w == 0) {
          param1.x = this.x;
          param1.y = this.y;
          param1.z = this.z;
        } else {
          local2 = 2 * Math.acos(this.w);
          local3 = 1 / Math.sqrt(1 - this.w * this.w);
          param1.x = this.x * local3 * local2;
          param1.y = this.y * local3 * local2;
          param1.z = this.z * local3 * local2;
        }
      } else {
        param1.x = 0;
        param1.y = 0;
        param1.z = 0;
      }
      return param1;
    }

    public function getEulerAngles(param1:Vector3) : Vector3 {
      var local2:Number = 2 * this.x * this.x;
      var local3:Number = 2 * this.y * this.y;
      var local4:Number = 2 * this.z * this.z;
      var local5:Number = 2 * this.x * this.y;
      var local6:Number = 2 * this.y * this.z;
      var local7:Number = 2 * this.z * this.x;
      var local8:Number = 2 * this.w * this.x;
      var local9:Number = 2 * this.w * this.y;
      var local10:Number = 2 * this.w * this.z;
      var local11:Number = 1 - local3 - local4;
      var local12:Number = local5 - local10;
      var local13:Number = local5 + local10;
      var local14:Number = 1 - local2 - local4;
      var local15:Number = local7 - local9;
      var local16:Number = local6 + local8;
      var local17:Number = 1 - local2 - local3;
      if(-1 < local15 && local15 < 1) {
        if(param1 == null) {
          param1 = new Vector3(Math.atan2(local16,local17),-Math.asin(local15),Math.atan2(local13,local11));
        } else {
          param1.x = Math.atan2(local16,local17);
          param1.y = -Math.asin(local15);
          param1.z = Math.atan2(local13,local11);
        }
      } else if(param1 == null) {
        param1 = new Vector3(0,0.5 * (local15 <= -1 ? Math.PI : -Math.PI),Math.atan2(-local12,local14));
      } else {
        param1.x = 0;
        param1.y = local15 <= -1 ? Math.PI : -Math.PI;
        param1.y *= 0.5;
        param1.z = Math.atan2(-local12,local14);
      }
      return param1;
    }

    public function setFromEulerAnglesXYZ(param1:Number, param2:Number, param3:Number) : void {
      this.setFromAxisAngleComponents(1,0,0,param1);
      _q.setFromAxisAngleComponents(0,1,0,param2);
      this.append(_q);
      this.normalize();
      _q.setFromAxisAngleComponents(0,0,1,param3);
      this.append(_q);
      this.normalize();
    }

    public function setFromEulerAngles(param1:Vector3) : void {
      this.setFromEulerAnglesXYZ(param1.x,param1.y,param1.z);
    }

    public function conjugate() : void {
      this.x = -this.x;
      this.y = -this.y;
      this.z = -this.z;
    }

    public function nlerp(param1:Quaternion, param2:Quaternion, param3:Number) : Quaternion {
      var local4:Number = 1 - param3;
      this.w = param1.w * local4 + param2.w * param3;
      this.x = param1.x * local4 + param2.x * param3;
      this.y = param1.y * local4 + param2.y * param3;
      this.z = param1.z * local4 + param2.z * param3;
      local4 = this.w * this.w + this.x * this.x + this.y * this.y + this.z * this.z;
      if(local4 == 0) {
        this.w = 1;
      } else {
        local4 = 1 / Math.sqrt(local4);
        this.w *= local4;
        this.x *= local4;
        this.y *= local4;
        this.z *= local4;
      }
      return this;
    }

    public function subtract(param1:Quaternion) : Quaternion {
      this.w -= param1.w;
      this.x -= param1.x;
      this.y -= param1.y;
      this.z -= param1.z;
      return this;
    }

    public function diff(param1:Quaternion, param2:Quaternion) : Quaternion {
      this.w = param2.w - param1.w;
      this.x = param2.x - param1.x;
      this.y = param2.y - param1.y;
      this.z = param2.z - param1.z;
      return this;
    }

    public function copy(param1:Quaternion) : Quaternion {
      this.w = param1.w;
      this.x = param1.x;
      this.y = param1.y;
      this.z = param1.z;
      return this;
    }

    public function toVector3D(param1:Vector3D) : Vector3D {
      param1.x = this.x;
      param1.y = this.y;
      param1.z = this.z;
      param1.w = this.w;
      return param1;
    }

    public function clone() : Quaternion {
      return new Quaternion(this.w,this.x,this.y,this.z);
    }

    public function toString() : String {
      return getQualifiedClassName(this) + "(" + this.w + ", " + this.x + ", " + this.y + ", " + this.z + ")";
    }

    public function slerp(param1:Quaternion, param2:Quaternion, param3:Number) : Quaternion {
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local4:Number = 1;
      var local5:Number = param1.w * param2.w + param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
      if(local5 < 0) {
        local5 = -local5;
        local4 = -1;
      }
      if(1 - local5 < 0.001) {
        local6 = 1 - param3;
        local7 = param3 * local4;
        this.w = param1.w * local6 + param2.w * local7;
        this.x = param1.x * local6 + param2.x * local7;
        this.y = param1.y * local6 + param2.y * local7;
        this.z = param1.z * local6 + param2.z * local7;
        this.normalize();
      } else {
        local8 = Math.acos(local5);
        local9 = Math.sin(local8);
        local10 = Math.sin((1 - param3) * local8) / local9;
        local11 = Math.sin(param3 * local8) / local9 * local4;
        this.w = param1.w * local10 + param2.w * local11;
        this.x = param1.x * local10 + param2.x * local11;
        this.y = param1.y * local10 + param2.y * local11;
        this.z = param1.z * local10 + param2.z * local11;
      }
      return this;
    }

    public function isFiniteQuaternion() : Boolean {
      return isFinite(this.w) && isFinite(this.x) && isFinite(this.y) && isFinite(this.z);
    }
  }
}
