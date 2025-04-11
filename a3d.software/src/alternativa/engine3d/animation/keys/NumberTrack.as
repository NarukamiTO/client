package alternativa.engine3d.animation.keys {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.AnimationState;

  use namespace alternativa3d;

  public class NumberTrack extends Track {
    private static var temp:NumberKey = new NumberKey();

    alternativa3d var keyList:NumberKey;

    public var property:String;

    public function NumberTrack(param1:String, param2:String) {
      super();
      this.property = param2;
      this.object = param1;
    }

    override alternativa3d function get keyFramesList() : Keyframe {
      return this.alternativa3d::keyList;
    }

    override alternativa3d function set keyFramesList(param1:Keyframe) : void {
      this.alternativa3d::keyList = NumberKey(param1);
    }

    public function addKey(param1:Number, param2:Number = 0) : Keyframe {
      var local3:NumberKey = new NumberKey();
      local3.alternativa3d::_time = param1;
      local3.value = param2;
      alternativa3d::addKeyToList(local3);
      return local3;
    }

    override alternativa3d function blend(param1:Number, param2:Number, param3:AnimationState) : void {
      var local4:NumberKey = null;
      if(this.property == null) {
        return;
      }
      var local5:NumberKey = this.alternativa3d::keyList;
      while(local5 != null && local5.alternativa3d::_time < param1) {
        local4 = local5;
        local5 = local5.alternativa3d::next;
      }
      if(local4 != null) {
        if(local5 != null) {
          temp.interpolate(local4,local5,(param1 - local4.alternativa3d::_time) / (local5.alternativa3d::_time - local4.alternativa3d::_time));
          param3.addWeightedNumber(this.property,temp.alternativa3d::_value,param2);
        } else {
          param3.addWeightedNumber(this.property,local4.alternativa3d::_value,param2);
        }
      } else if(local5 != null) {
        param3.addWeightedNumber(this.property,local5.alternativa3d::_value,param2);
      }
    }

    override alternativa3d function createKeyFrame() : Keyframe {
      return new NumberKey();
    }

    override alternativa3d function interpolateKeyFrame(param1:Keyframe, param2:Keyframe, param3:Keyframe, param4:Number) : void {
      NumberKey(param1).interpolate(NumberKey(param2),NumberKey(param3),param4);
    }

    override public function slice(param1:Number, param2:Number = 1.7976931348623157e+308) : Track {
      var local3:NumberTrack = new NumberTrack(object,this.property);
      alternativa3d::sliceImplementation(local3,param1,param2);
      return local3;
    }
  }
}
