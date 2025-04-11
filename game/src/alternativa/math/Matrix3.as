package alternativa.math {
  import alternativa.engine3d.core.Object3D;
  import flash.geom.Vector3D;
  import flash.utils.getQualifiedClassName;

  public class Matrix3 {
    public static const ZERO:Matrix3 = new Matrix3(0,0,0,0,0,0,0,0,0);
    public static const IDENTITY:Matrix3 = new Matrix3();

    private static const xAxis:Vector3 = new Vector3();
    private static const yAxis:Vector3 = new Vector3();
    private static const zAxis:Vector3 = new Vector3();

    public var m00:Number;
    public var m01:Number;
    public var m02:Number;
    public var m10:Number;
    public var m11:Number;
    public var m12:Number;
    public var m20:Number;
    public var m21:Number;
    public var m22:Number;

    public function Matrix3(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 1, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 1) {
      super();
      this.m00 = param1;
      this.m01 = param2;
      this.m02 = param3;
      this.m10 = param4;
      this.m11 = param5;
      this.m12 = param6;
      this.m20 = param7;
      this.m21 = param8;
      this.m22 = param9;
    }

    public function toIdentity() : Matrix3 {
      this.m00 = this.m11 = this.m22 = 1;
      this.m01 = this.m02 = this.m10 = this.m12 = this.m20 = this.m21 = 0;
      return this;
    }

    public function invert() : Matrix3 {
      var local1:Number = this.m00;
      var local2:Number = this.m01;
      var local3:Number = this.m02;
      var local4:Number = this.m10;
      var local5:Number = this.m11;
      var local6:Number = this.m12;
      var local7:Number = this.m20;
      var local8:Number = this.m21;
      var local9:Number = this.m22;
      var local10:Number = 1 / (-local3 * local5 * local7 + local2 * local6 * local7 + local3 * local4 * local8 - local1 * local6 * local8 - local2 * local4 * local9 + local1 * local5 * local9);
      this.m00 = (local5 * local9 - local6 * local8) * local10;
      this.m01 = (local3 * local8 - local2 * local9) * local10;
      this.m02 = (local2 * local6 - local3 * local5) * local10;
      this.m10 = (local6 * local7 - local4 * local9) * local10;
      this.m11 = (local1 * local9 - local3 * local7) * local10;
      this.m12 = (local3 * local4 - local1 * local6) * local10;
      this.m20 = (local4 * local8 - local5 * local7) * local10;
      this.m21 = (local2 * local7 - local1 * local8) * local10;
      this.m22 = (local1 * local5 - local2 * local4) * local10;
      return this;
    }

    public function append(param1:Matrix3) : Matrix3 {
      var local2:Number = this.m00;
      var local3:Number = this.m01;
      var local4:Number = this.m02;
      var local5:Number = this.m10;
      var local6:Number = this.m11;
      var local7:Number = this.m12;
      var local8:Number = this.m20;
      var local9:Number = this.m21;
      var local10:Number = this.m22;
      this.m00 = param1.m00 * local2 + param1.m01 * local5 + param1.m02 * local8;
      this.m01 = param1.m00 * local3 + param1.m01 * local6 + param1.m02 * local9;
      this.m02 = param1.m00 * local4 + param1.m01 * local7 + param1.m02 * local10;
      this.m10 = param1.m10 * local2 + param1.m11 * local5 + param1.m12 * local8;
      this.m11 = param1.m10 * local3 + param1.m11 * local6 + param1.m12 * local9;
      this.m12 = param1.m10 * local4 + param1.m11 * local7 + param1.m12 * local10;
      this.m20 = param1.m20 * local2 + param1.m21 * local5 + param1.m22 * local8;
      this.m21 = param1.m20 * local3 + param1.m21 * local6 + param1.m22 * local9;
      this.m22 = param1.m20 * local4 + param1.m21 * local7 + param1.m22 * local10;
      return this;
    }

    public function prepend(param1:Matrix3) : Matrix3 {
      var local2:Number = this.m00;
      var local3:Number = this.m01;
      var local4:Number = this.m02;
      var local5:Number = this.m10;
      var local6:Number = this.m11;
      var local7:Number = this.m12;
      var local8:Number = this.m20;
      var local9:Number = this.m21;
      var local10:Number = this.m22;
      this.m00 = local2 * param1.m00 + local3 * param1.m10 + local4 * param1.m20;
      this.m01 = local2 * param1.m01 + local3 * param1.m11 + local4 * param1.m21;
      this.m02 = local2 * param1.m02 + local3 * param1.m12 + local4 * param1.m22;
      this.m10 = local5 * param1.m00 + local6 * param1.m10 + local7 * param1.m20;
      this.m11 = local5 * param1.m01 + local6 * param1.m11 + local7 * param1.m21;
      this.m12 = local5 * param1.m02 + local6 * param1.m12 + local7 * param1.m22;
      this.m20 = local8 * param1.m00 + local9 * param1.m10 + local10 * param1.m20;
      this.m21 = local8 * param1.m01 + local9 * param1.m11 + local10 * param1.m21;
      this.m22 = local8 * param1.m02 + local9 * param1.m12 + local10 * param1.m22;
      return this;
    }

    public function prependTransposed(param1:Matrix3) : Matrix3 {
      var local2:Number = this.m00;
      var local3:Number = this.m01;
      var local4:Number = this.m02;
      var local5:Number = this.m10;
      var local6:Number = this.m11;
      var local7:Number = this.m12;
      var local8:Number = this.m20;
      var local9:Number = this.m21;
      var local10:Number = this.m22;
      this.m00 = local2 * param1.m00 + local3 * param1.m01 + local4 * param1.m02;
      this.m01 = local2 * param1.m10 + local3 * param1.m11 + local4 * param1.m12;
      this.m02 = local2 * param1.m20 + local3 * param1.m21 + local4 * param1.m22;
      this.m10 = local5 * param1.m00 + local6 * param1.m01 + local7 * param1.m02;
      this.m11 = local5 * param1.m10 + local6 * param1.m11 + local7 * param1.m12;
      this.m12 = local5 * param1.m20 + local6 * param1.m21 + local7 * param1.m22;
      this.m20 = local8 * param1.m00 + local9 * param1.m01 + local10 * param1.m02;
      this.m21 = local8 * param1.m10 + local9 * param1.m11 + local10 * param1.m12;
      this.m22 = local8 * param1.m20 + local9 * param1.m21 + local10 * param1.m22;
      return this;
    }

    public function add(param1:Matrix3) : Matrix3 {
      this.m00 += param1.m00;
      this.m01 += param1.m01;
      this.m02 += param1.m02;
      this.m10 += param1.m10;
      this.m11 += param1.m11;
      this.m12 += param1.m12;
      this.m20 += param1.m20;
      this.m21 += param1.m21;
      this.m22 += param1.m22;
      return this;
    }

    public function subtract(param1:Matrix3) : Matrix3 {
      this.m00 -= param1.m00;
      this.m01 -= param1.m01;
      this.m02 -= param1.m02;
      this.m10 -= param1.m10;
      this.m11 -= param1.m11;
      this.m12 -= param1.m12;
      this.m20 -= param1.m20;
      this.m21 -= param1.m21;
      this.m22 -= param1.m22;
      return this;
    }

    public function transpose() : Matrix3 {
      var local1:Number = this.m01;
      this.m01 = this.m10;
      this.m10 = local1;
      local1 = this.m02;
      this.m02 = this.m20;
      this.m20 = local1;
      local1 = this.m12;
      this.m12 = this.m21;
      this.m21 = local1;
      return this;
    }

    public function transformVector(param1:Vector3, param2:Vector3) : void {
      param2.x = this.m00 * param1.x + this.m01 * param1.y + this.m02 * param1.z;
      param2.y = this.m10 * param1.x + this.m11 * param1.y + this.m12 * param1.z;
      param2.z = this.m20 * param1.x + this.m21 * param1.y + this.m22 * param1.z;
    }

    public function transformVectorInverse(param1:Vector3, param2:Vector3) : void {
      param2.x = this.m00 * param1.x + this.m10 * param1.y + this.m20 * param1.z;
      param2.y = this.m01 * param1.x + this.m11 * param1.y + this.m21 * param1.z;
      param2.z = this.m02 * param1.x + this.m12 * param1.y + this.m22 * param1.z;
    }

    public function transformVector3To3D(param1:Vector3, param2:Vector3D) : void {
      param2.x = this.m00 * param1.x + this.m01 * param1.y + this.m02 * param1.z;
      param2.y = this.m10 * param1.x + this.m11 * param1.y + this.m12 * param1.z;
      param2.z = this.m20 * param1.x + this.m21 * param1.y + this.m22 * param1.z;
    }

    public function createSkewSymmetric(param1:Vector3) : Matrix3 {
      this.m00 = this.m11 = this.m22 = 0;
      this.m01 = -param1.z;
      this.m02 = param1.y;
      this.m10 = param1.z;
      this.m12 = -param1.x;
      this.m20 = -param1.y;
      this.m21 = param1.x;
      return this;
    }

    public function copy(param1:Matrix3) : Matrix3 {
      this.m00 = param1.m00;
      this.m01 = param1.m01;
      this.m02 = param1.m02;
      this.m10 = param1.m10;
      this.m11 = param1.m11;
      this.m12 = param1.m12;
      this.m20 = param1.m20;
      this.m21 = param1.m21;
      this.m22 = param1.m22;
      return this;
    }

    public function setRotationMatrix(param1:Number, param2:Number, param3:Number) : Matrix3 {
      var local4:Number = Math.cos(param1);
      var local5:Number = Math.sin(param1);
      var local6:Number = Math.cos(param2);
      var local7:Number = Math.sin(param2);
      var local8:Number = Math.cos(param3);
      var local9:Number = Math.sin(param3);
      var local10:Number = local8 * local7;
      var local11:Number = local9 * local7;
      this.m00 = local8 * local6;
      this.m01 = local10 * local5 - local9 * local4;
      this.m02 = local10 * local4 + local9 * local5;
      this.m10 = local9 * local6;
      this.m11 = local11 * local5 + local8 * local4;
      this.m12 = local11 * local4 - local8 * local5;
      this.m20 = -local7;
      this.m21 = local6 * local5;
      this.m22 = local6 * local4;
      return this;
    }

    public function setRotationMatrixForObject3D(param1:Object3D) : void {
      this.setRotationMatrix(param1.rotationX,param1.rotationY,param1.rotationZ);
    }

    public function fromAxisAngle(param1:Vector3, param2:Number) : void {
      var local3:Number = Math.cos(param2);
      var local4:Number = Math.sin(param2);
      var local5:Number = 1 - local3;
      var local6:Number = param1.x;
      var local7:Number = param1.y;
      var local8:Number = param1.z;
      this.m00 = local5 * local6 * local6 + local3;
      this.m01 = local5 * local6 * local7 - local8 * local4;
      this.m02 = local5 * local6 * local8 + local7 * local4;
      this.m10 = local5 * local6 * local7 + local8 * local4;
      this.m11 = local5 * local7 * local7 + local3;
      this.m12 = local5 * local7 * local8 - local6 * local4;
      this.m20 = local5 * local6 * local8 - local7 * local4;
      this.m21 = local5 * local7 * local8 + local6 * local4;
      this.m22 = local5 * local8 * local8 + local3;
    }

    public function clone() : Matrix3 {
      return new Matrix3(this.m00,this.m01,this.m02,this.m10,this.m11,this.m12,this.m20,this.m21,this.m22);
    }

    public function toString() : String {
      return getQualifiedClassName(this) + " (" + this.m00 + ", " + this.m01 + ", " + this.m02 + "), (" + this.m10 + ", " + this.m11 + ", " + this.m12 + "), (" + this.m20 + ", " + this.m21 + ", " + this.m22 + ")";
    }

    public function getEulerAngles(param1:Vector3) : void {
      if(-1 < this.m20 && this.m20 < 1) {
        param1.x = Math.atan2(this.m21,this.m22);
        param1.y = -Math.asin(this.m20);
        param1.z = Math.atan2(this.m10,this.m00);
      } else {
        param1.x = 0;
        param1.y = this.m20 <= -1 ? Math.PI : -Math.PI;
        param1.y *= 0.5;
        param1.z = Math.atan2(-this.m01,this.m11);
      }
    }

    public function getRight(param1:Vector3) : void {
      this.getAxis(0,param1);
    }

    public function getForward(param1:Vector3) : void {
      this.getAxis(1,param1);
    }

    public function getUp(param1:Vector3) : void {
      this.getAxis(2,param1);
    }

    public function getAxis(param1:int, param2:Vector3) : void {
      switch(param1) {
        case 0:
          param2.reset(this.m00,this.m10,this.m20);
          break;
        case 1:
          param2.reset(this.m01,this.m11,this.m21);
          break;
        case 2:
          param2.reset(this.m02,this.m12,this.m22);
      }
    }

    public function setDirectionVector(param1:Vector3) : void {
      yAxis.copy(param1).normalize();
      if(yAxis.dot(Vector3.X_AXIS) < 0.9) {
        zAxis.cross2(Vector3.X_AXIS,yAxis);
      } else {
        zAxis.cross2(yAxis,Vector3.Y_AXIS);
      }
      zAxis.normalize();
      xAxis.cross2(yAxis,zAxis).normalize();
      this.setAxis(xAxis,yAxis,zAxis);
    }

    public function setAxis(param1:Vector3, param2:Vector3, param3:Vector3) : void {
      this.m00 = param1.x;
      this.m01 = param2.x;
      this.m02 = param3.x;
      this.m10 = param1.y;
      this.m11 = param2.y;
      this.m12 = param3.y;
      this.m20 = param1.z;
      this.m21 = param2.z;
      this.m22 = param3.z;
    }

    public function rotationMatrixToQuaternion(param1:Quaternion) : void {
      var local3:Number = NaN;
      var local2:Number = this.m00 + this.m11 + this.m22;
      if(local2 > 0) {
        local3 = Math.sqrt(local2 + 1) * 2;
        param1.w = 0.25 * local3;
        param1.x = (this.m21 - this.m12) / local3;
        param1.y = (this.m02 - this.m20) / local3;
        param1.z = (this.m10 - this.m01) / local3;
      } else if(this.m00 > this.m11 && this.m00 > this.m22) {
        local3 = Math.sqrt(1 + this.m00 - this.m11 - this.m22) * 2;
        param1.w = (this.m21 - this.m12) / local3;
        param1.x = 0.25 * local3;
        param1.y = (this.m01 + this.m10) / local3;
        param1.z = (this.m02 + this.m20) / local3;
      } else if(this.m11 > this.m22) {
        local3 = Math.sqrt(1 + this.m11 - this.m00 - this.m22) * 2;
        param1.w = (this.m02 - this.m20) / local3;
        param1.x = (this.m01 + this.m10) / local3;
        param1.y = 0.25 * local3;
        param1.z = (this.m12 + this.m21) / local3;
      } else {
        local3 = Math.sqrt(1 + this.m22 - this.m00 - this.m11) * 2;
        param1.w = (this.m10 - this.m01) / local3;
        param1.x = (this.m02 + this.m20) / local3;
        param1.y = (this.m12 + this.m21) / local3;
        param1.z = 0.25 * local3;
      }
    }
  }
}
