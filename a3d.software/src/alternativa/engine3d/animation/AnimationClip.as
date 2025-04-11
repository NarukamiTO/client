package alternativa.engine3d.animation {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.keys.Track;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.objects.Joint;
  import alternativa.engine3d.objects.Skin;

  use namespace alternativa3d;

  public class AnimationClip extends AnimationNode {
    alternativa3d var _objects:Array;

    public var name:String;
    public var loop:Boolean = true;
    public var length:Number = 0;
    public var animated:Boolean = true;

    private var _time:Number = 0;
    private var _numTracks:int = 0;
    private var _tracks:Vector.<Track> = new Vector.<Track>();
    private var _notifiersList:AnimationNotify;

    public function AnimationClip(param1:String = null) {
      super();
      this.name = param1;
    }

    public function get objects() : Array {
      return this.alternativa3d::_objects == null ? null : [].concat(this.alternativa3d::_objects);
    }

    public function set objects(param1:Array) : void {
      this.updateObjects(this.alternativa3d::_objects,alternativa3d::controller,param1,alternativa3d::controller);
      this.alternativa3d::_objects = param1 == null ? null : [].concat(param1);
    }

    override alternativa3d function setController(param1:AnimationController) : void {
      this.updateObjects(this.alternativa3d::_objects,alternativa3d::controller,this.alternativa3d::_objects,param1);
      this.alternativa3d::controller = param1;
    }

    private function addObject(param1:Object) : void {
      if(this.alternativa3d::_objects == null) {
        this.alternativa3d::_objects = [param1];
      } else {
        this.alternativa3d::_objects.push(param1);
      }
      if(alternativa3d::controller != null) {
        alternativa3d::controller.alternativa3d::addObject(param1);
      }
    }

    private function updateObjects(param1:Array, param2:AnimationController, param3:Array, param4:AnimationController) : void {
      var local5:int = 0;
      var local6:int = 0;
      if(param2 != null && param1 != null) {
        local5 = 0;
        local6 = int(this.alternativa3d::_objects.length);
        while(local5 < local6) {
          param2.alternativa3d::removeObject(param1[local5]);
          local5++;
        }
      }
      if(param4 != null && param3 != null) {
        local5 = 0;
        local6 = int(param3.length);
        while(local5 < local6) {
          param4.alternativa3d::addObject(param3[local5]);
          local5++;
        }
      }
    }

    public function updateLength() : void {
      var local2:Track = null;
      var local3:Number = NaN;
      var local1:int = 0;
      while(local1 < this._numTracks) {
        local2 = this._tracks[local1];
        local3 = local2.length;
        if(local3 > this.length) {
          this.length = local3;
        }
        local1++;
      }
    }

    public function addTrack(param1:Track) : Track {
      if(param1 == null) {
        throw new Error("Track can not be null");
      }
      var local2:* = this._numTracks++;
      this._tracks[local2] = param1;
      if(param1.length > this.length) {
        this.length = param1.length;
      }
      return param1;
    }

    public function removeTrack(param1:Track) : Track {
      var local5:Track = null;
      var local2:int = int(this._tracks.indexOf(param1));
      if(local2 < 0) {
        throw new ArgumentError("Track not found");
      }
      --this._numTracks;
      var local3:int = local2 + 1;
      while(local2 < this._numTracks) {
        this._tracks[local2] = this._tracks[local3];
        local2++;
        local3++;
      }
      this._tracks.length = this._numTracks;
      this.length = 0;
      var local4:int = 0;
      while(local4 < this._numTracks) {
        local5 = this._tracks[local4];
        if(local5.length > this.length) {
          this.length = local5.length;
        }
        local4++;
      }
      return param1;
    }

    public function getTrackAt(param1:int) : Track {
      return this._tracks[param1];
    }

    public function get numTracks() : int {
      return this._numTracks;
    }

    override alternativa3d function update(param1:Number, param2:Number) : void {
      var local4:int = 0;
      var local5:Track = null;
      var local6:AnimationState = null;
      var local3:Number = this._time;
      if(this.animated) {
        this._time += param1 * speed;
        if(this.loop) {
          if(this._time < 0) {
            this._time = 0;
          } else if(this._time >= this.length) {
            this.alternativa3d::collectNotifiers(local3,this.length);
            this._time = this.length <= 0 ? 0 : this._time % this.length;
            this.alternativa3d::collectNotifiers(0,this._time);
          } else {
            this.alternativa3d::collectNotifiers(local3,this._time);
          }
        } else {
          if(this._time < 0) {
            this._time = 0;
          } else if(this._time >= this.length) {
            this._time = this.length;
          }
          this.alternativa3d::collectNotifiers(local3,this._time);
        }
      }
      if(param2 > 0) {
        local4 = 0;
        while(local4 < this._numTracks) {
          local5 = this._tracks[local4];
          if(local5.object != null) {
            local6 = alternativa3d::controller.alternativa3d::getState(local5.object);
            if(local6 != null) {
              local5.alternativa3d::blend(this._time,param2,local6);
            }
          }
          local4++;
        }
      }
    }

    public function get time() : Number {
      return this._time;
    }

    public function set time(param1:Number) : void {
      this._time = param1;
    }

    public function get normalizedTime() : Number {
      return this.length == 0 ? 0 : this._time / this.length;
    }

    public function set normalizedTime(param1:Number) : void {
      this._time = param1 * this.length;
    }

    private function getNumChildren(param1:Object) : int {
      if(param1 is Joint) {
        return Joint(param1).numChildren;
      }
      if(param1 is Object3DContainer) {
        return Object3DContainer(param1).numChildren;
      }
      if(param1 is Skin) {
        return Skin(param1).numJoints;
      }
      return 0;
    }

    private function getChildAt(param1:Object, param2:int) : Object {
      if(param1 is Joint) {
        return Joint(param1).getChildAt(param2);
      }
      if(param1 is Object3DContainer) {
        return Object3DContainer(param1).getChildAt(param2);
      }
      if(param1 is Skin) {
        return Skin(param1).getJointAt(param2);
      }
      return null;
    }

    private function addChildren(param1:Object) : void {
      var local4:Object = null;
      var local2:int = 0;
      var local3:int = this.getNumChildren(param1);
      while(local2 < local3) {
        local4 = this.getChildAt(param1,local2);
        this.addObject(local4);
        this.addChildren(local4);
        local2++;
      }
    }

    public function attach(param1:Object, param2:Boolean) : void {
      this.updateObjects(this.alternativa3d::_objects,alternativa3d::controller,null,alternativa3d::controller);
      this.alternativa3d::_objects = null;
      this.addObject(param1);
      if(param2) {
        this.addChildren(param1);
      }
    }

    alternativa3d function collectNotifiers(param1:Number, param2:Number) : void {
      var local3:AnimationNotify = this._notifiersList;
      while(local3 != null) {
        if(local3.alternativa3d::_time > param1) {
          if(local3.alternativa3d::_time > param2) {
            return;
          }
          local3.alternativa3d::processNext = alternativa3d::controller.alternativa3d::nearestNotifyers;
          alternativa3d::controller.alternativa3d::nearestNotifyers = local3;
        }
        local3 = local3.alternativa3d::next;
      }
    }

    public function addNotify(param1:Number, param2:String = null) : AnimationNotify {
      var local4:AnimationNotify = null;
      param1 = param1 <= 0 ? 0 : (param1 >= this.length ? this.length : param1);
      var local3:AnimationNotify = new AnimationNotify(param2);
      local3.alternativa3d::_time = param1;
      if(this._notifiersList == null) {
        this._notifiersList = local3;
        return local3;
      }
      if(this._notifiersList.alternativa3d::_time > param1) {
        local3.alternativa3d::next = this._notifiersList;
        this._notifiersList = local3;
        return local3;
      }
      local4 = this._notifiersList;
      while(local4.alternativa3d::next != null && local4.alternativa3d::next.alternativa3d::_time <= param1) {
        local4 = local4.alternativa3d::next;
      }
      if(local4.alternativa3d::next == null) {
        local4.alternativa3d::next = local3;
      } else {
        local3.alternativa3d::next = local4.alternativa3d::next;
        local4.alternativa3d::next = local3;
      }
      return local3;
    }

    public function addNotifyAtEnd(param1:Number = 0, param2:String = null) : AnimationNotify {
      return this.addNotify(this.length - param1,param2);
    }

    public function removeNotify(param1:AnimationNotify) : AnimationNotify {
      var local2:AnimationNotify = null;
      if(this._notifiersList != null) {
        if(this._notifiersList == param1) {
          this._notifiersList = this._notifiersList.alternativa3d::next;
          return param1;
        }
        local2 = this._notifiersList;
        while(local2.alternativa3d::next != null && local2.alternativa3d::next != param1) {
          local2 = local2.alternativa3d::next;
        }
        if(local2.alternativa3d::next == param1) {
          local2.alternativa3d::next = param1.alternativa3d::next;
          return param1;
        }
      }
      throw new Error("Notify not found");
    }

    public function get notifiers() : Vector.<AnimationNotify> {
      var local1:Vector.<AnimationNotify> = new Vector.<AnimationNotify>();
      var local2:int = 0;
      var local3:AnimationNotify = this._notifiersList;
      while(local3 != null) {
        local1[local2] = local3;
        local2++;
        local3 = local3.alternativa3d::next;
      }
      return local1;
    }

    public function slice(param1:Number, param2:Number = 1.7976931348623157e+308) : AnimationClip {
      var local3:AnimationClip = new AnimationClip(this.name);
      local3.alternativa3d::_objects = this.alternativa3d::_objects == null ? null : [].concat(this.alternativa3d::_objects);
      var local4:int = 0;
      while(local4 < this._numTracks) {
        local3.addTrack(this._tracks[local4].slice(param1,param2));
        local4++;
      }
      return local3;
    }

    public function clone() : AnimationClip {
      var local1:AnimationClip = new AnimationClip(this.name);
      local1.alternativa3d::_objects = this.alternativa3d::_objects == null ? null : [].concat(this.alternativa3d::_objects);
      var local2:int = 0;
      while(local2 < this._numTracks) {
        local1.addTrack(this._tracks[local2]);
        local2++;
      }
      local1.length = this.length;
      return local1;
    }
  }
}
