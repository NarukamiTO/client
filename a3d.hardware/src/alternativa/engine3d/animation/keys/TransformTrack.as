package alternativa.engine3d.animation.keys {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.AnimationState;
  import flash.geom.Matrix3D;
  import flash.geom.Orientation3D;
  import flash.geom.Vector3D;

  use namespace alternativa3d;

  public class TransformTrack extends Track {
    private static var tempQuat:Vector3D = new Vector3D();
    private static var temp:TransformKey = new TransformKey();

    private var keyList:TransformKey;

    public function TransformTrack(param1:String) {
      super();
      this.object = param1;
    }

    override alternativa3d function get keyFramesList() : Keyframe {
      return this.keyList;
    }

    override alternativa3d function set keyFramesList(param1:Keyframe) : void {
      this.keyList = TransformKey(param1);
    }

    public function addKey(param1:Number, param2:Matrix3D) : TransformKey {
      var local3:TransformKey = null;
      local3 = new TransformKey();
      local3.alternativa3d::_time = param1;
      var local4:Vector.<Vector3D> = param2.decompose(Orientation3D.QUATERNION);
      local3.alternativa3d::x = local4[0].x;
      local3.alternativa3d::y = local4[0].y;
      local3.alternativa3d::z = local4[0].z;
      local3.alternativa3d::rotation = local4[1];
      local3.alternativa3d::scaleX = local4[2].x;
      local3.alternativa3d::scaleY = local4[2].y;
      local3.alternativa3d::scaleZ = local4[2].z;
      alternativa3d::addKeyToList(local3);
      return local3;
    }

    public function addKeyComponents(param1:Number, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 1, param9:Number = 1, param10:Number = 1) : TransformKey {
      var local11:TransformKey = new TransformKey();
      local11.alternativa3d::_time = param1;
      local11.alternativa3d::x = param2;
      local11.alternativa3d::y = param3;
      local11.alternativa3d::z = param4;
      local11.alternativa3d::rotation = this.createQuatFromEuler(param5,param6,param7);
      local11.alternativa3d::scaleX = param8;
      local11.alternativa3d::scaleY = param9;
      local11.alternativa3d::scaleZ = param10;
      alternativa3d::addKeyToList(local11);
      return local11;
    }

    private function appendQuat(param1:Vector3D, param2:Vector3D) : void {
      var local3:Number = param2.w * param1.w - param2.x * param1.x - param2.y * param1.y - param2.z * param1.z;
      var local4:Number = param2.w * param1.x + param2.x * param1.w + param2.y * param1.z - param2.z * param1.y;
      var local5:Number = param2.w * param1.y + param2.y * param1.w + param2.z * param1.x - param2.x * param1.z;
      var local6:Number = param2.w * param1.z + param2.z * param1.w + param2.x * param1.y - param2.y * param1.x;
      param1.w = local3;
      param1.x = local4;
      param1.y = local5;
      param1.z = local6;
    }

    private function normalizeQuat(param1:Vector3D) : void {
      var local2:Number = param1.w * param1.w + param1.x * param1.x + param1.y * param1.y + param1.z * param1.z;
      if(local2 == 0) {
        param1.w = 1;
      } else {
        local2 = 1 / Math.sqrt(local2);
        param1.w *= local2;
        param1.x *= local2;
        param1.y *= local2;
        param1.z *= local2;
      }
    }

    private function setQuatFromAxisAngle(param1:Vector3D, param2:Number, param3:Number, param4:Number, param5:Number) : void {
      param1.w = Math.cos(0.5 * param5);
      var local6:Number = Math.sin(0.5 * param5) / Math.sqrt(param2 * param2 + param3 * param3 + param4 * param4);
      param1.x = param2 * local6;
      param1.y = param3 * local6;
      param1.z = param4 * local6;
    }

    private function createQuatFromEuler(param1:Number, param2:Number, param3:Number) : Vector3D {
      var local4:Vector3D = new Vector3D();
      this.setQuatFromAxisAngle(local4,1,0,0,param1);
      this.setQuatFromAxisAngle(tempQuat,0,1,0,param2);
      this.appendQuat(local4,tempQuat);
      this.normalizeQuat(local4);
      this.setQuatFromAxisAngle(tempQuat,0,0,1,param3);
      this.appendQuat(local4,tempQuat);
      this.normalizeQuat(local4);
      return local4;
    }

    override alternativa3d function blend(param1:Number, param2:Number, param3:AnimationState) : void {
      var local4:TransformKey = null;
      var local5:TransformKey = this.keyList;
      while(local5 != null && local5.alternativa3d::_time < param1) {
        local4 = local5;
        local5 = local5.alternativa3d::next;
      }
      if(local4 != null) {
        if(local5 != null) {
          temp.interpolate(local4,local5,(param1 - local4.alternativa3d::_time) / (local5.alternativa3d::_time - local4.alternativa3d::_time));
          param3.addWeightedTransform(temp,param2);
        } else {
          param3.addWeightedTransform(local4,param2);
        }
      } else if(local5 != null) {
        param3.addWeightedTransform(local5,param2);
      }
    }

    override alternativa3d function createKeyFrame() : Keyframe {
      return new TransformKey();
    }

    override alternativa3d function interpolateKeyFrame(param1:Keyframe, param2:Keyframe, param3:Keyframe, param4:Number) : void {
      TransformKey(param1).interpolate(TransformKey(param2),TransformKey(param3),param4);
    }

    override public function slice(param1:Number, param2:Number = 1.7976931348623157e+308) : Track {
      var local3:TransformTrack = new TransformTrack(object);
      alternativa3d::sliceImplementation(local3,param1,param2);
      return local3;
    }
  }
}
