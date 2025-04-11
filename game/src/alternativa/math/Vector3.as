package alternativa.math {
  import flash.geom.Vector3D;
  import flash.utils.getQualifiedClassName;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class Vector3 {
    public static const ZERO:Vector3 = new Vector3(0,0,0);
    public static const X_AXIS:Vector3 = new Vector3(1,0,0);
    public static const Y_AXIS:Vector3 = new Vector3(0,1,0);
    public static const Z_AXIS:Vector3 = new Vector3(0,0,1);
    public static const DOWN:Vector3 = new Vector3(0,0,-1);

    public var x:Number;
    public var y:Number;
    public var z:Number;

    public function Vector3(param1:Number = 0, param2:Number = 0, param3:Number = 0) {
      super();
      this.x = param1;
      this.y = param2;
      this.z = param3;
    }

    public static function isFiniteVector(param1:Vector3) : Boolean {
      return param1 != null && isFinite(param1.x) && isFinite(param1.y) && isFinite(param1.z);
    }

    public static function interpolate(param1:Number, param2:Vector3, param3:Vector3, param4:Vector3) : void {
      param4.x = param2.x + param1 * (param3.x - param2.x);
      param4.y = param2.y + param1 * (param3.y - param2.y);
      param4.z = param2.z + param1 * (param3.z - param2.z);
    }

    public static function distanceBetween(param1:Vector3, param2:Vector3) : Number {
      var local3:Number = param1.x - param2.x;
      var local4:Number = param1.y - param2.y;
      var local5:Number = param1.z - param2.z;
      return Math.sqrt(local3 * local3 + local4 * local4 + local5 * local5);
    }

    public static function fromVector3d(param1:Vector3d) : Vector3 {
      return new Vector3(param1.x,param1.y,param1.z);
    }

    public function interpolate(param1:Number, param2:Vector3, param3:Vector3) : void {
      this.x = param2.x + param1 * (param3.x - param2.x);
      this.y = param2.y + param1 * (param3.y - param2.y);
      this.z = param2.z + param1 * (param3.z - param2.z);
    }

    public function isFiniteVector() : Boolean {
      return isFinite(this.x) && isFinite(this.y) && isFinite(this.z);
    }

    public function length() : Number {
      return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
    }

    public function lengthSqr() : Number {
      return this.x * this.x + this.y * this.y + this.z * this.z;
    }

    public function setLength(param1:Number) : Vector3 {
      var local3:Number = NaN;
      var local2:Number = this.x * this.x + this.y * this.y + this.z * this.z;
      if(local2 == 0) {
        this.x = param1;
      } else {
        local3 = param1 / Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
        this.x *= local3;
        this.y *= local3;
        this.z *= local3;
      }
      return this;
    }

    public function normalize() : Vector3 {
      var local1:Number = this.x * this.x + this.y * this.y + this.z * this.z;
      if(local1 == 0) {
        this.x = 1;
      } else {
        local1 = Math.sqrt(local1);
        this.x /= local1;
        this.y /= local1;
        this.z /= local1;
      }
      return this;
    }

    public function add(param1:Vector3) : Vector3 {
      this.x += param1.x;
      this.y += param1.y;
      this.z += param1.z;
      return this;
    }

    public function addScaled(param1:Number, param2:Vector3) : Vector3 {
      this.x += param1 * param2.x;
      this.y += param1 * param2.y;
      this.z += param1 * param2.z;
      return this;
    }

    public function subtract(param1:Vector3) : Vector3 {
      this.x -= param1.x;
      this.y -= param1.y;
      this.z -= param1.z;
      return this;
    }

    public function sum(param1:Vector3, param2:Vector3) : Vector3 {
      this.x = param1.x + param2.x;
      this.y = param1.y + param2.y;
      this.z = param1.z + param2.z;
      return this;
    }

    public function diff(param1:Vector3, param2:Vector3) : Vector3 {
      this.x = param1.x - param2.x;
      this.y = param1.y - param2.y;
      this.z = param1.z - param2.z;
      return this;
    }

    public function diff2d(param1:Vector3, param2:Vector3) : Vector3 {
      this.x = param1.x - param2.x;
      this.y = param1.y - param2.y;
      this.z = 0;
      return this;
    }

    public function scale(param1:Number) : Vector3 {
      this.x *= param1;
      this.y *= param1;
      this.z *= param1;
      return this;
    }

    public function reverse() : Vector3 {
      this.x = -this.x;
      this.y = -this.y;
      this.z = -this.z;
      return this;
    }

    public function dot(param1:Vector3) : Number {
      return this.x * param1.x + this.y * param1.y + this.z * param1.z;
    }

    public function cross(param1:Vector3) : Vector3 {
      var local2:Number = this.y * param1.z - this.z * param1.y;
      var local3:Number = this.z * param1.x - this.x * param1.z;
      var local4:Number = this.x * param1.y - this.y * param1.x;
      this.x = local2;
      this.y = local3;
      this.z = local4;
      return this;
    }

    public function cross2(param1:Vector3, param2:Vector3) : Vector3 {
      this.x = param1.y * param2.z - param1.z * param2.y;
      this.y = param1.z * param2.x - param1.x * param2.z;
      this.z = param1.x * param2.y - param1.y * param2.x;
      return this;
    }

    public function transform3(param1:Matrix3) : Vector3 {
      var local2:Number = this.x;
      var local3:Number = this.y;
      var local4:Number = this.z;
      this.x = param1.m00 * local2 + param1.m01 * local3 + param1.m02 * local4;
      this.y = param1.m10 * local2 + param1.m11 * local3 + param1.m12 * local4;
      this.z = param1.m20 * local2 + param1.m21 * local3 + param1.m22 * local4;
      return this;
    }

    public function transformTransposed3(param1:Matrix3) : Vector3 {
      var local2:Number = this.x;
      var local3:Number = this.y;
      var local4:Number = this.z;
      this.x = param1.m00 * local2 + param1.m10 * local3 + param1.m20 * local4;
      this.y = param1.m01 * local2 + param1.m11 * local3 + param1.m21 * local4;
      this.z = param1.m02 * local2 + param1.m12 * local3 + param1.m22 * local4;
      return this;
    }

    public function transform4(param1:Matrix4) : Vector3 {
      var local2:Number = this.x;
      var local3:Number = this.y;
      var local4:Number = this.z;
      this.x = param1.m00 * local2 + param1.m01 * local3 + param1.m02 * local4 + param1.m03;
      this.y = param1.m10 * local2 + param1.m11 * local3 + param1.m12 * local4 + param1.m13;
      this.z = param1.m20 * local2 + param1.m21 * local3 + param1.m22 * local4 + param1.m23;
      return this;
    }

    public function deltaTransform4(param1:Matrix4) : Vector3 {
      var local2:Number = this.x;
      var local3:Number = this.y;
      var local4:Number = this.z;
      this.x = param1.m00 * local2 + param1.m01 * local3 + param1.m02 * local4;
      this.y = param1.m10 * local2 + param1.m11 * local3 + param1.m12 * local4;
      this.z = param1.m20 * local2 + param1.m21 * local3 + param1.m22 * local4;
      return this;
    }

    public function transformInverse4(param1:Matrix4) : Vector3 {
      var local2:Number = this.x - param1.m03;
      var local3:Number = this.y - param1.m13;
      var local4:Number = this.z - param1.m23;
      this.x = param1.m00 * local2 + param1.m10 * local3 + param1.m20 * local4;
      this.y = param1.m01 * local2 + param1.m11 * local3 + param1.m21 * local4;
      this.z = param1.m02 * local2 + param1.m12 * local3 + param1.m22 * local4;
      return this;
    }

    public function transformVector4(param1:Matrix4) : Vector3 {
      var local2:Number = this.x;
      var local3:Number = this.y;
      var local4:Number = this.z;
      this.x = param1.m00 * local2 + param1.m01 * local3 + param1.m02 * local4;
      this.y = param1.m10 * local2 + param1.m11 * local3 + param1.m12 * local4;
      this.z = param1.m20 * local2 + param1.m21 * local3 + param1.m22 * local4;
      return this;
    }

    public function reset(param1:Number = 0, param2:Number = 0, param3:Number = 0) : Vector3 {
      this.x = param1;
      this.y = param2;
      this.z = param3;
      return this;
    }

    public function copy(param1:Vector3) : Vector3 {
      this.x = param1.x;
      this.y = param1.y;
      this.z = param1.z;
      return this;
    }

    public function clone() : Vector3 {
      return new Vector3(this.x,this.y,this.z);
    }

    public function toVector3D(param1:Vector3D) : Vector3D {
      param1.x = this.x;
      param1.y = this.y;
      param1.z = this.z;
      return param1;
    }

    public function copyFromVector3D(param1:Vector3D) : Vector3 {
      this.x = param1.x;
      this.y = param1.y;
      this.z = param1.z;
      return this;
    }

    public function toString() : String {
      return getQualifiedClassName(this) + " (" + this.x.toFixed(5) + ", " + this.y.toFixed(5) + ", " + this.z.toFixed(5) + ")";
    }

    public function distanceToXYSquared(param1:Vector3) : Number {
      var local2:Number = this.x - param1.x;
      var local3:Number = this.y - param1.y;
      return local2 * local2 + local3 * local3;
    }

    public function distanceToXY(param1:Vector3) : Number {
      var local2:Number = this.x - param1.x;
      var local3:Number = this.y - param1.y;
      return Math.sqrt(local2 * local2 + local3 * local3);
    }

    public function distanceTo(param1:Vector3) : Number {
      var local2:Number = this.x - param1.x;
      var local3:Number = this.y - param1.y;
      var local4:Number = this.z - param1.z;
      return Math.sqrt(local2 * local2 + local3 * local3 + local4 * local4);
    }

    public function distanceToSquared(param1:Vector3) : Number {
      var local2:Number = this.x - param1.x;
      var local3:Number = this.y - param1.y;
      var local4:Number = this.z - param1.z;
      return local2 * local2 + local3 * local3 + local4 * local4;
    }

    public function setLengthAlongDirection(param1:Vector3, param2:Number) : void {
      var local3:Number = this.x * param1.x + this.y * param1.y + this.z * param1.z;
      var local4:Number = param2 - local3;
      this.x += local4 * param1.x;
      this.y += local4 * param1.y;
      this.z += local4 * param1.z;
    }

    public function projectOnPlane(param1:Vector3) : void {
      var local2:Number = this.x * param1.x + this.y * param1.y + this.z * param1.z;
      this.x -= local2 * param1.x;
      this.y -= local2 * param1.y;
      this.z -= local2 * param1.z;
    }

    public function toVector3d() : Vector3d {
      return new Vector3d(this.x,this.y,this.z);
    }

    public function copyFromVector3d(param1:Vector3d) : Vector3 {
      this.x = param1.x;
      this.y = param1.y;
      this.z = param1.z;
      return this;
    }

    public function rotationToOut(param1:Vector3, param2:Quaternion) : void {
      var local3:Vector3 = this.clone().cross(param1).normalize();
      var local4:Number = Math.acos(this.clone().normalize().dot(param1.clone().normalize()));
      param2.setFromAxisAngle(local3,local4);
    }

    public function rotationTo(param1:Vector3) : Quaternion {
      var local2:* = new Quaternion();
      this.rotationToOut(param1,local2);
      return local2;
    }
  }
}
