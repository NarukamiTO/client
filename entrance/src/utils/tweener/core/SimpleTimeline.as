package utils.tweener.core {
  public class SimpleTimeline extends TweenCore {
    protected var _firstChild:TweenCore;
    protected var _lastChild:TweenCore;

    public var autoRemoveChildren:Boolean;

    public function SimpleTimeline(param1:Object = null) {
      super(0,param1);
    }

    public function insert(param1:TweenCore, param2:* = 0) : TweenCore {
      var local3:SimpleTimeline = param1.timeline;
      if(!param1.cachedOrphan && Boolean(local3)) {
        local3.remove(param1,true);
      }
      param1.timeline = this;
      param1.cachedStartTime = Number(param2) + param1.delay;
      if(param1.gc) {
        param1.setEnabled(true,true);
      }
      if(param1.cachedPaused && local3 != this) {
        param1.cachedPauseTime = param1.cachedStartTime + (this.rawTime - param1.cachedStartTime) / param1.cachedTimeScale;
      }
      if(Boolean(this._lastChild)) {
        this._lastChild.nextNode = param1;
      } else {
        this._firstChild = param1;
      }
      param1.prevNode = this._lastChild;
      this._lastChild = param1;
      param1.nextNode = null;
      param1.cachedOrphan = false;
      return param1;
    }

    public function remove(param1:TweenCore, param2:Boolean = false) : void {
      if(param1.cachedOrphan) {
        return;
      }
      if(!param2) {
        param1.setEnabled(false,true);
      }
      if(Boolean(param1.nextNode)) {
        param1.nextNode.prevNode = param1.prevNode;
      } else if(this._lastChild == param1) {
        this._lastChild = param1.prevNode;
      }
      if(Boolean(param1.prevNode)) {
        param1.prevNode.nextNode = param1.nextNode;
      } else if(this._firstChild == param1) {
        this._firstChild = param1.nextNode;
      }
      param1.cachedOrphan = true;
    }

    override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void {
      var local5:Number = NaN;
      var local6:TweenCore = null;
      var local4:TweenCore = this._firstChild;
      this.cachedTotalTime = param1;
      this.cachedTime = param1;
      while(Boolean(local4)) {
        local6 = local4.nextNode;
        if(local4.active || param1 >= local4.cachedStartTime && !local4.cachedPaused && !local4.gc) {
          if(!local4.cachedReversed) {
            local4.renderTime((param1 - local4.cachedStartTime) * local4.cachedTimeScale,param2,false);
          } else {
            local5 = local4.cacheIsDirty ? local4.totalDuration : local4.cachedTotalDuration;
            local4.renderTime(local5 - (param1 - local4.cachedStartTime) * local4.cachedTimeScale,param2,false);
          }
        }
        local4 = local6;
      }
    }

    public function get rawTime() : Number {
      return this.cachedTotalTime;
    }
  }
}
