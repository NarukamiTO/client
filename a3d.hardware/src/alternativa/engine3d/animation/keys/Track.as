package alternativa.engine3d.animation.keys {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.AnimationState;

  use namespace alternativa3d;

  public class Track {
    public var object:String;

    alternativa3d var _length:Number = 0;

    public function Track() {
      super();
    }

    public function get length() : Number {
      return this.alternativa3d::_length;
    }

    alternativa3d function get keyFramesList() : Keyframe {
      return null;
    }

    alternativa3d function set keyFramesList(param1:Keyframe) : void {
    }

    alternativa3d function addKeyToList(param1:Keyframe) : void {
      var local3:Keyframe = null;
      var local2:Number = param1.alternativa3d::_time;
      if(this.alternativa3d::keyFramesList == null) {
        this.alternativa3d::keyFramesList = param1;
        this.alternativa3d::_length = local2 <= 0 ? 0 : local2;
        return;
      }
      if(this.alternativa3d::keyFramesList.alternativa3d::_time > local2) {
        param1.alternativa3d::nextKeyFrame = this.alternativa3d::keyFramesList;
        this.alternativa3d::keyFramesList = param1;
        return;
      }
      local3 = this.alternativa3d::keyFramesList;
      while(local3.alternativa3d::nextKeyFrame != null && local3.alternativa3d::nextKeyFrame.alternativa3d::_time <= local2) {
        local3 = local3.alternativa3d::nextKeyFrame;
      }
      if(local3.alternativa3d::nextKeyFrame == null) {
        local3.alternativa3d::nextKeyFrame = param1;
        this.alternativa3d::_length = local2 <= 0 ? 0 : local2;
      } else {
        param1.alternativa3d::nextKeyFrame = local3.alternativa3d::nextKeyFrame;
        local3.alternativa3d::nextKeyFrame = param1;
      }
    }

    public function removeKey(param1:Keyframe) : Keyframe {
      var local2:Keyframe = null;
      if(this.alternativa3d::keyFramesList != null) {
        if(this.alternativa3d::keyFramesList == param1) {
          this.alternativa3d::keyFramesList = this.alternativa3d::keyFramesList.alternativa3d::nextKeyFrame;
          if(this.alternativa3d::keyFramesList == null) {
            this.alternativa3d::_length = 0;
          }
          return param1;
        }
        local2 = this.alternativa3d::keyFramesList;
        while(local2.alternativa3d::nextKeyFrame != null && local2.alternativa3d::nextKeyFrame != param1) {
          local2 = local2.alternativa3d::nextKeyFrame;
        }
        if(local2.alternativa3d::nextKeyFrame == param1) {
          if(param1.alternativa3d::nextKeyFrame == null) {
            this.alternativa3d::_length = local2.alternativa3d::_time <= 0 ? 0 : local2.alternativa3d::_time;
          }
          local2.alternativa3d::nextKeyFrame = param1.alternativa3d::nextKeyFrame;
          return param1;
        }
      }
      throw new Error("Key not found");
    }

    public function get keys() : Vector.<Keyframe> {
      var local1:Vector.<Keyframe> = new Vector.<Keyframe>();
      var local2:int = 0;
      var local3:Keyframe = this.alternativa3d::keyFramesList;
      while(local3 != null) {
        local1[local2] = local3;
        local2++;
        local3 = local3.alternativa3d::nextKeyFrame;
      }
      return local1;
    }

    alternativa3d function blend(param1:Number, param2:Number, param3:AnimationState) : void {
    }

    public function slice(param1:Number, param2:Number = 1.7976931348623157e+308) : Track {
      return null;
    }

    alternativa3d function createKeyFrame() : Keyframe {
      return null;
    }

    alternativa3d function interpolateKeyFrame(param1:Keyframe, param2:Keyframe, param3:Keyframe, param4:Number) : void {
    }

    alternativa3d function sliceImplementation(param1:Track, param2:Number, param3:Number) : void {
      var local5:Keyframe = null;
      var local8:Keyframe = null;
      var local4:Number = param2 > 0 ? param2 : 0;
      var local6:Keyframe = this.alternativa3d::keyFramesList;
      var local7:Keyframe = this.alternativa3d::createKeyFrame();
      while(local6 != null && local6.alternativa3d::_time <= param2) {
        local5 = local6;
        local6 = local6.alternativa3d::nextKeyFrame;
      }
      if(local5 != null) {
        if(local6 != null) {
          this.alternativa3d::interpolateKeyFrame(local7,local5,local6,(param2 - local5.alternativa3d::_time) / (local6.alternativa3d::_time - local5.alternativa3d::_time));
          local7.alternativa3d::_time = param2 - local4;
        } else {
          this.alternativa3d::interpolateKeyFrame(local7,local7,local5,1);
        }
      } else {
        if(local6 == null) {
          return;
        }
        this.alternativa3d::interpolateKeyFrame(local7,local7,local6,1);
        local7.alternativa3d::_time = local6.alternativa3d::_time - local4;
        local5 = local6;
        local6 = local6.alternativa3d::nextKeyFrame;
      }
      param1.alternativa3d::keyFramesList = local7;
      if(local6 == null || param3 <= param2) {
        param1.alternativa3d::_length = local7.alternativa3d::_time <= 0 ? 0 : local7.alternativa3d::_time;
        return;
      }
      while(local6 != null && local6.alternativa3d::_time <= param3) {
        local8 = this.alternativa3d::createKeyFrame();
        this.alternativa3d::interpolateKeyFrame(local8,local8,local6,1);
        local8.alternativa3d::_time = local6.alternativa3d::_time - local4;
        local7.alternativa3d::nextKeyFrame = local8;
        local7 = local8;
        local5 = local6;
        local6 = local6.alternativa3d::nextKeyFrame;
      }
      if(local6 != null) {
        local8 = this.alternativa3d::createKeyFrame();
        this.alternativa3d::interpolateKeyFrame(local8,local5,local6,(param3 - local5.alternativa3d::_time) / (local6.alternativa3d::_time - local5.alternativa3d::_time));
        local8.alternativa3d::_time = param3 - local4;
        local7.alternativa3d::nextKeyFrame = local8;
      }
      if(local8 != null) {
        param1.alternativa3d::_length = local8.alternativa3d::_time <= 0 ? 0 : local8.alternativa3d::_time;
      }
    }
  }
}
