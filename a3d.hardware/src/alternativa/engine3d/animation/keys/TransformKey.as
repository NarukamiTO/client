package alternativa.engine3d.animation.keys {
  import alternativa.engine3d.alternativa3d;
  import flash.geom.Matrix3D;
  import flash.geom.Orientation3D;
  import flash.geom.Vector3D;

  use namespace alternativa3d;

  public class TransformKey extends Keyframe {
    alternativa3d var x:Number = 0;
    alternativa3d var y:Number = 0;
    alternativa3d var z:Number = 0;
    alternativa3d var rotation:Vector3D = new Vector3D(0,0,0,1);
    alternativa3d var scaleX:Number = 1;
    alternativa3d var scaleY:Number = 1;
    alternativa3d var scaleZ:Number = 1;
    alternativa3d var next:TransformKey;

    public function TransformKey() {
      super();
    }

    override public function get value() : Object {
      var local1:Matrix3D = new Matrix3D();
      local1.recompose(Vector.<Vector3D>([new Vector3D(this.alternativa3d::x,this.alternativa3d::y,this.alternativa3d::z),this.alternativa3d::rotation,new Vector3D(this.alternativa3d::scaleX,this.alternativa3d::scaleY,this.alternativa3d::scaleZ)]),Orientation3D.QUATERNION);
      return local1;
    }

    override public function set value(param1:Object) : void {
      var local2:Matrix3D = Matrix3D(param1);
      var local3:Vector.<Vector3D> = local2.decompose(Orientation3D.QUATERNION);
      this.alternativa3d::x = local3[0].x;
      this.alternativa3d::y = local3[0].y;
      this.alternativa3d::z = local3[0].z;
      this.alternativa3d::rotation = local3[1];
      this.alternativa3d::scaleX = local3[2].x;
      this.alternativa3d::scaleY = local3[2].y;
      this.alternativa3d::scaleZ = local3[2].z;
    }

    public function interpolate(param1:TransformKey, param2:TransformKey, param3:Number) : void {
      var local4:Number = 1 - param3;
      this.alternativa3d::x = local4 * param1.alternativa3d::x + param3 * param2.alternativa3d::x;
      this.alternativa3d::y = local4 * param1.alternativa3d::y + param3 * param2.alternativa3d::y;
      this.alternativa3d::z = local4 * param1.alternativa3d::z + param3 * param2.alternativa3d::z;
      this.slerp(param1.alternativa3d::rotation,param2.alternativa3d::rotation,param3,this.alternativa3d::rotation);
      this.alternativa3d::scaleX = local4 * param1.alternativa3d::scaleX + param3 * param2.alternativa3d::scaleX;
      this.alternativa3d::scaleY = local4 * param1.alternativa3d::scaleY + param3 * param2.alternativa3d::scaleY;
      this.alternativa3d::scaleZ = local4 * param1.alternativa3d::scaleZ + param3 * param2.alternativa3d::scaleZ;
    }

    private function slerp(param1:Vector3D, param2:Vector3D, param3:Number, param4:Vector3D) : void {
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local5:Number = 1;
      var local6:Number = param1.w * param2.w + param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
      if(local6 < 0) {
        local6 = -local6;
        local5 = -1;
      }
      if(1 - local6 < 0.001) {
        local7 = 1 - param3;
        local8 = param3 * local5;
        param4.w = param1.w * local7 + param2.w * local8;
        param4.x = param1.x * local7 + param2.x * local8;
        param4.y = param1.y * local7 + param2.y * local8;
        param4.z = param1.z * local7 + param2.z * local8;
        local9 = param4.w * param4.w + param4.x * param4.x + param4.y * param4.y + param4.z * param4.z;
        if(local9 == 0) {
          param4.w = 1;
        } else {
          param4.scaleBy(1 / Math.sqrt(local9));
        }
      } else {
        local10 = Math.acos(local6);
        local11 = Math.sin(local10);
        local12 = Math.sin((1 - param3) * local10) / local11;
        local13 = Math.sin(param3 * local10) / local11 * local5;
        param4.w = param1.w * local12 + param2.w * local13;
        param4.x = param1.x * local12 + param2.x * local13;
        param4.y = param1.y * local12 + param2.y * local13;
        param4.z = param1.z * local12 + param2.z * local13;
      }
    }

    override alternativa3d function get nextKeyFrame() : Keyframe {
      return this.alternativa3d::next;
    }

    override alternativa3d function set nextKeyFrame(param1:Keyframe) : void {
      this.alternativa3d::next = TransformKey(param1);
    }
  }
}
