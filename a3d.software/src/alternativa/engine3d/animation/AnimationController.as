package alternativa.engine3d.animation {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.events.NotifyEvent;
  import alternativa.engine3d.core.Object3D;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;

  use namespace alternativa3d;

  public class AnimationController {
    private var _root:AnimationNode;
    private var _objects:Vector.<Object>;
    private var _object3ds:Vector.<Object3D> = new Vector.<Object3D>();
    private var objectsUsedCount:Dictionary = new Dictionary();
    private var states:Object = new Object();
    private var lastTime:int = -1;

    alternativa3d var nearestNotifyers:AnimationNotify;

    public function AnimationController() {
      super();
    }

    public function get root() : AnimationNode {
      return this._root;
    }

    public function set root(param1:AnimationNode) : void {
      if(this._root != param1) {
        if(this._root != null) {
          this._root.alternativa3d::setController(null);
          this._root.alternativa3d::_isActive = false;
        }
        if(param1 != null) {
          param1.alternativa3d::setController(this);
          param1.alternativa3d::_isActive = true;
        }
        this._root = param1;
      }
    }

    public function update() : void {
      var local1:Number = NaN;
      var local2:AnimationState = null;
      var local3:int = 0;
      var local4:int = 0;
      var local6:int = 0;
      var local7:Object3D = null;
      if(this.lastTime < 0) {
        this.lastTime = getTimer();
        local1 = 0;
      } else {
        local6 = getTimer();
        local1 = 0.001 * (local6 - this.lastTime);
        this.lastTime = local6;
      }
      if(this._root == null) {
        return;
      }
      for each(local2 in this.states) {
        local2.reset();
      }
      this._root.alternativa3d::update(local1,1);
      local3 = 0;
      local4 = int(this._object3ds.length);
      while(local3 < local4) {
        local7 = this._object3ds[local3];
        local2 = this.states[local7.name];
        if(local2 != null) {
          local2.apply(local7);
        }
        local3++;
      }
      var local5:AnimationNotify = this.alternativa3d::nearestNotifyers;
      while(local5 != null) {
        if(local5.willTrigger(NotifyEvent.NOTIFY)) {
          local5.dispatchEvent(new NotifyEvent(local5));
        }
        local5 = local5.alternativa3d::processNext;
      }
      this.alternativa3d::nearestNotifyers = null;
    }

    alternativa3d function addObject(param1:Object) : void {
      if(param1 in this.objectsUsedCount) {
        ++this.objectsUsedCount[param1];
      } else {
        if(param1 is Object3D) {
          this._object3ds.push(param1);
        } else {
          this._objects.push(param1);
        }
        this.objectsUsedCount[param1] = 1;
      }
    }

    alternativa3d function removeObject(param1:Object) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      var local2:int = int(this.objectsUsedCount[param1]);
      local2--;
      if(local2 <= 0) {
        if(param1 is Object3D) {
          local3 = int(this._object3ds.indexOf(param1));
          local5 = this._object3ds.length - 1;
          local4 = local3 + 1;
          while(local3 < local5) {
            this._object3ds[local3] = this._object3ds[local4];
            local3++;
            local4++;
          }
          this._object3ds.length = local5;
        } else {
          local3 = int(this._objects.indexOf(param1));
          local5 = this._objects.length - 1;
          local4 = local3 + 1;
          while(local3 < local5) {
            this._objects[local3] = this._objects[local4];
            local3++;
            local4++;
          }
          this._objects.length = local5;
        }
        delete this.objectsUsedCount[param1];
      } else {
        this.objectsUsedCount[param1] = local2;
      }
    }

    alternativa3d function getState(param1:String) : AnimationState {
      var local2:AnimationState = this.states[param1];
      if(local2 == null) {
        local2 = new AnimationState();
        this.states[param1] = local2;
      }
      return local2;
    }

    public function freeze() : void {
      this.lastTime = -1;
    }
  }
}
