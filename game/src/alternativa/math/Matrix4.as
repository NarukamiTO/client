package alternativa.math {
  import alternativa.engine3d.core.Object3D;
  import flash.geom.Matrix3D;
  import flash.utils.getQualifiedClassName;

  public class Matrix4 {
    public static const IDENTITY:Matrix4 = new Matrix4();

    public var m00:Number;
    public var m01:Number;
    public var m02:Number;
    public var m03:Number;
    public var m10:Number;
    public var m11:Number;
    public var m12:Number;
    public var m13:Number;
    public var m20:Number;
    public var m21:Number;
    public var m22:Number;
    public var m23:Number;

    public function Matrix4(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 1, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 1, param12:Number = 0) {
      super();
      this.init(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
    }

    public function init(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number) : void {
      this.m00 = param1;
      this.m01 = param2;
      this.m02 = param3;
      this.m03 = param4;
      this.m10 = param5;
      this.m11 = param6;
      this.m12 = param7;
      this.m13 = param8;
      this.m20 = param9;
      this.m21 = param10;
      this.m22 = param11;
      this.m23 = param12;
    }

    public function toIdentity() : Matrix4 {
      this.m00 = this.m11 = this.m22 = 1;
      this.m01 = this.m02 = this.m10 = this.m12 = this.m20 = this.m21 = this.m03 = this.m13 = this.m23 = 0;
      return this;
    }

    public function invert() : Matrix4 {
      var local1:Number = this.m00;
      var local2:Number = this.m01;
      var local3:Number = this.m02;
      var local4:Number = this.m03;
      var local5:Number = this.m10;
      var local6:Number = this.m11;
      var local7:Number = this.m12;
      var local8:Number = this.m13;
      var local9:Number = this.m20;
      var local10:Number = this.m21;
      var local11:Number = this.m22;
      var local12:Number = this.m23;
      var local13:Number = -local3 * local6 * local9 + local2 * local7 * local9 + local3 * local5 * local10 - local1 * local7 * local10 - local2 * local5 * local11 + local1 * local6 * local11;
      this.m00 = (-local7 * local10 + local6 * local11) / local13;
      this.m01 = (local3 * local10 - local2 * local11) / local13;
      this.m02 = (-local3 * local6 + local2 * local7) / local13;
      this.m03 = (local4 * local7 * local10 - local3 * local8 * local10 - local4 * local6 * local11 + local2 * local8 * local11 + local3 * local6 * local12 - local2 * local7 * local12) / local13;
      this.m10 = (local7 * local9 - local5 * local11) / local13;
      this.m11 = (-local3 * local9 + local1 * local11) / local13;
      this.m12 = (local3 * local5 - local1 * local7) / local13;
      this.m13 = (local3 * local8 * local9 - local4 * local7 * local9 + local4 * local5 * local11 - local1 * local8 * local11 - local3 * local5 * local12 + local1 * local7 * local12) / local13;
      this.m20 = (-local6 * local9 + local5 * local10) / local13;
      this.m21 = (local2 * local9 - local1 * local10) / local13;
      this.m22 = (-local2 * local5 + local1 * local6) / local13;
      this.m23 = (local4 * local6 * local9 - local2 * local8 * local9 - local4 * local5 * local10 + local1 * local8 * local10 + local2 * local5 * local12 - local1 * local6 * local12) / local13;
      return this;
    }

    public function append(param1:Matrix4) : Matrix4 {
      var local2:Number = this.m00;
      var local3:Number = this.m01;
      var local4:Number = this.m02;
      var local5:Number = this.m03;
      var local6:Number = this.m10;
      var local7:Number = this.m11;
      var local8:Number = this.m12;
      var local9:Number = this.m13;
      var local10:Number = this.m20;
      var local11:Number = this.m21;
      var local12:Number = this.m22;
      var local13:Number = this.m23;
      this.m00 = param1.m00 * local2 + param1.m01 * local6 + param1.m02 * local10;
      this.m01 = param1.m00 * local3 + param1.m01 * local7 + param1.m02 * local11;
      this.m02 = param1.m00 * local4 + param1.m01 * local8 + param1.m02 * local12;
      this.m03 = param1.m00 * local5 + param1.m01 * local9 + param1.m02 * local13 + param1.m03;
      this.m10 = param1.m10 * local2 + param1.m11 * local6 + param1.m12 * local10;
      this.m11 = param1.m10 * local3 + param1.m11 * local7 + param1.m12 * local11;
      this.m12 = param1.m10 * local4 + param1.m11 * local8 + param1.m12 * local12;
      this.m13 = param1.m10 * local5 + param1.m11 * local9 + param1.m12 * local13 + param1.m13;
      this.m20 = param1.m20 * local2 + param1.m21 * local6 + param1.m22 * local10;
      this.m21 = param1.m20 * local3 + param1.m21 * local7 + param1.m22 * local11;
      this.m22 = param1.m20 * local4 + param1.m21 * local8 + param1.m22 * local12;
      this.m23 = param1.m20 * local5 + param1.m21 * local9 + param1.m22 * local13 + param1.m23;
      return this;
    }

    public function prepend(param1:Matrix4) : Matrix4 {
      var local2:Number = this.m00;
      var local3:Number = this.m01;
      var local4:Number = this.m02;
      var local5:Number = this.m03;
      var local6:Number = this.m10;
      var local7:Number = this.m11;
      var local8:Number = this.m12;
      var local9:Number = this.m13;
      var local10:Number = this.m20;
      var local11:Number = this.m21;
      var local12:Number = this.m22;
      var local13:Number = this.m23;
      this.m00 = local2 * param1.m00 + local3 * param1.m10 + local4 * param1.m20;
      this.m01 = local2 * param1.m01 + local3 * param1.m11 + local4 * param1.m21;
      this.m02 = local2 * param1.m02 + local3 * param1.m12 + local4 * param1.m22;
      this.m03 = local2 * param1.m03 + local3 * param1.m13 + local4 * param1.m23 + local5;
      this.m10 = local6 * param1.m00 + local7 * param1.m10 + local8 * param1.m20;
      this.m11 = local6 * param1.m01 + local7 * param1.m11 + local8 * param1.m21;
      this.m12 = local6 * param1.m02 + local7 * param1.m12 + local8 * param1.m22;
      this.m13 = local6 * param1.m03 + local7 * param1.m13 + local8 * param1.m23 + local9;
      this.m20 = local10 * param1.m00 + local11 * param1.m10 + local12 * param1.m20;
      this.m21 = local10 * param1.m01 + local11 * param1.m11 + local12 * param1.m21;
      this.m22 = local10 * param1.m02 + local11 * param1.m12 + local12 * param1.m22;
      this.m23 = local10 * param1.m03 + local11 * param1.m13 + local12 * param1.m23 + local13;
      return this;
    }

    public function add(param1:Matrix4) : Matrix4 {
      this.m00 += param1.m00;
      this.m01 += param1.m01;
      this.m02 += param1.m02;
      this.m03 += param1.m03;
      this.m10 += param1.m10;
      this.m11 += param1.m11;
      this.m12 += param1.m12;
      this.m13 += param1.m13;
      this.m20 += param1.m20;
      this.m21 += param1.m21;
      this.m22 += param1.m22;
      this.m23 += param1.m23;
      return this;
    }

    public function subtract(param1:Matrix4) : Matrix4 {
      this.m00 -= param1.m00;
      this.m01 -= param1.m01;
      this.m02 -= param1.m02;
      this.m03 -= param1.m03;
      this.m10 -= param1.m10;
      this.m11 -= param1.m11;
      this.m12 -= param1.m12;
      this.m13 -= param1.m13;
      this.m20 -= param1.m20;
      this.m21 -= param1.m21;
      this.m22 -= param1.m22;
      this.m23 -= param1.m23;
      return this;
    }

    public function transformVector(param1:Vector3, param2:Vector3) : void {
      param2.x = this.m00 * param1.x + this.m01 * param1.y + this.m02 * param1.z + this.m03;
      param2.y = this.m10 * param1.x + this.m11 * param1.y + this.m12 * param1.z + this.m13;
      param2.z = this.m20 * param1.x + this.m21 * param1.y + this.m22 * param1.z + this.m23;
    }

    public function transformVectorXYZ(param1:Number, param2:Number, param3:Number, param4:Vector3) : void {
      param4.x = this.m00 * param1 + this.m01 * param2 + this.m02 * param3 + this.m03;
      param4.y = this.m10 * param1 + this.m11 * param2 + this.m12 * param3 + this.m13;
      param4.z = this.m20 * param1 + this.m21 * param2 + this.m22 * param3 + this.m23;
    }

    public function transformVectorInverse(param1:Vector3, param2:Vector3) : void {
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local3:Number = param1.x - this.m03;
      local4 = param1.y - this.m13;
      local5 = param1.z - this.m23;
      param2.x = this.m00 * local3 + this.m10 * local4 + this.m20 * local5;
      param2.y = this.m01 * local3 + this.m11 * local4 + this.m21 * local5;
      param2.z = this.m02 * local3 + this.m12 * local4 + this.m22 * local5;
    }

    public function transformVectors(param1:Vector.<Vector3>, param2:Vector.<Vector3>) : void {
      var local4:Vector3 = null;
      var local5:Vector3 = null;
      var local3:int = int(param1.length);
      var local6:int = 0;
      while(local6 < local3) {
        local4 = param1[local6];
        local5 = param2[local6];
        local5.x = this.m00 * local4.x + this.m01 * local4.y + this.m02 * local4.z + this.m03;
        local5.y = this.m10 * local4.x + this.m11 * local4.y + this.m12 * local4.z + this.m13;
        local5.z = this.m20 * local4.x + this.m21 * local4.y + this.m22 * local4.z + this.m23;
        local6++;
      }
    }

    public function transformVectorsN(param1:Vector.<Vector3>, param2:Vector.<Vector3>, param3:int) : void {
      var local4:Vector3 = null;
      var local5:Vector3 = null;
      var local6:int = 0;
      while(local6 < param3) {
        local4 = param1[local6];
        local5 = param2[local6];
        local5.x = this.m00 * local4.x + this.m01 * local4.y + this.m02 * local4.z + this.m03;
        local5.y = this.m10 * local4.x + this.m11 * local4.y + this.m12 * local4.z + this.m13;
        local5.z = this.m20 * local4.x + this.m21 * local4.y + this.m22 * local4.z + this.m23;
        local6++;
      }
    }

    public function transformVectorsInverse(param1:Vector.<Vector3>, param2:Vector.<Vector3>) : void {
      var local4:Vector3 = null;
      var local5:Vector3 = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local3:int = int(param1.length);
      var local6:int = 0;
      while(local6 < local3) {
        local4 = param1[local6];
        local5 = param2[local6];
        local7 = local4.x - this.m03;
        local8 = local4.y - this.m13;
        local9 = local4.z - this.m23;
        local5.x = this.m00 * local7 + this.m10 * local8 + this.m20 * local9;
        local5.y = this.m01 * local7 + this.m11 * local8 + this.m21 * local9;
        local5.z = this.m02 * local7 + this.m12 * local8 + this.m22 * local9;
        local6++;
      }
    }

    public function transformVectorsInverseN(param1:Vector.<Vector3>, param2:Vector.<Vector3>, param3:int) : void {
      var local4:Vector3 = null;
      var local5:Vector3 = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local6:int = 0;
      while(local6 < param3) {
        local4 = param1[local6];
        local5 = param2[local6];
        local7 = local4.x - this.m03;
        local8 = local4.y - this.m13;
        local9 = local4.z - this.m23;
        local5.x = this.m00 * local7 + this.m10 * local8 + this.m20 * local9;
        local5.y = this.m01 * local7 + this.m11 * local8 + this.m21 * local9;
        local5.z = this.m02 * local7 + this.m12 * local8 + this.m22 * local9;
        local6++;
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
          param2.x = this.m00;
          param2.y = this.m10;
          param2.z = this.m20;
          return;
        case 1:
          param2.x = this.m01;
          param2.y = this.m11;
          param2.z = this.m21;
          return;
        case 2:
          param2.x = this.m02;
          param2.y = this.m12;
          param2.z = this.m22;
          return;
        case 3:
          param2.x = this.m03;
          param2.y = this.m13;
          param2.z = this.m23;
          return;
        default:
          return;
      }
    }

    public function deltaTransformVector(param1:Vector3, param2:Vector3) : void {
      param2.x = this.m00 * param1.x + this.m01 * param1.y + this.m02 * param1.z;
      param2.y = this.m10 * param1.x + this.m11 * param1.y + this.m12 * param1.z;
      param2.z = this.m20 * param1.x + this.m21 * param1.y + this.m22 * param1.z;
    }

    public function deltaTransformVectorInverse(param1:Vector3, param2:Vector3) : void {
      param2.x = this.m00 * param1.x + this.m10 * param1.y + this.m20 * param1.z;
      param2.y = this.m01 * param1.x + this.m11 * param1.y + this.m21 * param1.z;
      param2.z = this.m02 * param1.x + this.m12 * param1.y + this.m22 * param1.z;
    }

    public function copy(param1:Matrix4) : Matrix4 {
      this.m00 = param1.m00;
      this.m01 = param1.m01;
      this.m02 = param1.m02;
      this.m03 = param1.m03;
      this.m10 = param1.m10;
      this.m11 = param1.m11;
      this.m12 = param1.m12;
      this.m13 = param1.m13;
      this.m20 = param1.m20;
      this.m21 = param1.m21;
      this.m22 = param1.m22;
      this.m23 = param1.m23;
      return this;
    }

    public function setFromMatrix3(param1:Matrix3, param2:Vector3) : Matrix4 {
      this.m00 = param1.m00;
      this.m01 = param1.m01;
      this.m02 = param1.m02;
      this.m03 = param2.x;
      this.m10 = param1.m10;
      this.m11 = param1.m11;
      this.m12 = param1.m12;
      this.m13 = param2.y;
      this.m20 = param1.m20;
      this.m21 = param1.m21;
      this.m22 = param1.m22;
      this.m23 = param2.z;
      return this;
    }

    public function setOrientationFromMatrix3(param1:Matrix3) : Matrix4 {
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

    public function setRotationMatrix(param1:Number, param2:Number, param3:Number) : Matrix4 {
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

    public function setMatrixForObject3D(param1:Object3D) : void {
      this.setMatrix(param1.x,param1.y,param1.z,param1.rotationX,param1.rotationY,param1.rotationZ);
    }

    public function setMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Matrix4 {
      var local7:Number = Math.cos(param4);
      var local8:Number = Math.sin(param4);
      var local9:Number = Math.cos(param5);
      var local10:Number = Math.sin(param5);
      var local11:Number = Math.cos(param6);
      var local12:Number = Math.sin(param6);
      var local13:Number = local11 * local10;
      var local14:Number = local12 * local10;
      this.m00 = local11 * local9;
      this.m01 = local13 * local8 - local12 * local7;
      this.m02 = local13 * local7 + local12 * local8;
      this.m03 = param1;
      this.m10 = local12 * local9;
      this.m11 = local14 * local8 + local11 * local7;
      this.m12 = local14 * local7 - local11 * local8;
      this.m13 = param2;
      this.m20 = -local10;
      this.m21 = local9 * local8;
      this.m22 = local9 * local7;
      this.m23 = param3;
      return this;
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

    public function setPosition(param1:Vector3) : void {
      this.m03 = param1.x;
      this.m13 = param1.y;
      this.m23 = param1.z;
    }

    public function getPosition(param1:Vector3) : void {
      param1.x = this.m03;
      param1.y = this.m13;
      param1.z = this.m23;
    }

    public function clone() : Matrix4 {
      return new Matrix4(this.m00,this.m01,this.m02,this.m03,this.m10,this.m11,this.m12,this.m13,this.m20,this.m21,this.m22,this.m23);
    }

    public function toString() : String {
      return getQualifiedClassName(this) + " (" + this.m00.toFixed(3) + " " + this.m01.toFixed(3) + " " + this.m02.toFixed(3) + " " + this.m03.toFixed(3) + "] [" + this.m10.toFixed(3) + " " + this.m11.toFixed(3) + " " + this.m12.toFixed(3) + " " + this.m13.toFixed(3) + "] [" + this.m20.toFixed(3) + " " + this.m21.toFixed(3) + " " + this.m22.toFixed(3) + " " + this.m23.toFixed(3) + ")";
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

    public function setFromMatrix3D(param1:Matrix3D) : void {
      var local2:Vector.<Number> = param1.rawData;
      this.init(local2[0],local2[4],local2[8],local2[12],local2[1],local2[5],local2[9],local2[13],local2[2],local2[6],local2[10],local2[14]);
    }
  }
}
