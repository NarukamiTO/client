package utils.tweener {
  import flash.display.Shape;
  import flash.events.Event;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import utils.tweener.core.PropTween;
  import utils.tweener.core.SimpleTimeline;
  import utils.tweener.core.TweenCore;

  public class TweenLite extends TweenCore {
    public static var onPluginEvent:Function;
    public static var overwriteManager:Object;
    public static var rootFrame:Number;
    public static var rootTimeline:SimpleTimeline;
    public static var rootFramesTimeline:SimpleTimeline;
    public static var plugins:Object = {};
    public static var defaultEase:Function = TweenLite.easeOut;
    public static var masterList:Dictionary = new Dictionary(false);

    private static var _shape:Shape = new Shape();

    protected static var _reservedProps:Object = {
      "ease":1,
      "delay":1,
      "overwrite":1,
      "onComplete":1,
      "onCompleteParams":1,
      "useFrames":1,
      "runBackwards":1,
      "startAt":1,
      "onUpdate":1,
      "onUpdateParams":1,
      "onStart":1,
      "onStartParams":1,
      "onInit":1,
      "onInitParams":1,
      "onReverseComplete":1,
      "onReverseCompleteParams":1,
      "onRepeat":1,
      "onRepeatParams":1,
      "proxiedEase":1,
      "easeParams":1,
      "yoyo":1,
      "onCompleteListener":1,
      "onUpdateListener":1,
      "onStartListener":1,
      "onReverseCompleteListener":1,
      "onRepeatListener":1,
      "orientToBezier":1,
      "timeScale":1,
      "immediateRender":1,
      "repeat":1,
      "repeatDelay":1,
      "timeline":1,
      "data":1,
      "paused":1,
      "reversed":1
    };

    public var target:Object;
    public var propTweenLookup:Object;
    public var ratio:Number = 0;
    public var cachedPT1:PropTween;

    protected var _ease:Function;
    protected var _overwrite:int;
    protected var _overwrittenProps:Object;
    protected var _hasPlugins:Boolean;
    protected var _notifyPluginsOfEnabled:Boolean;

    public function TweenLite(param1:Object, param2:Number, param3:Object) {
      var local5:TweenLite = null;
      super(param2,param3);
      if(param1 == null) {
        throw new Error("Cannot tween a null object.");
      }
      this.target = param1;
      if(this.target is TweenCore && Boolean(this.vars.timeScale)) {
        this.cachedTimeScale = 1;
      }
      this.propTweenLookup = {};
      this._ease = defaultEase;
      this._overwrite = Number(param3.overwrite) <= -1 || !overwriteManager.enabled && param3.overwrite > 1 ? int(overwriteManager.mode) : int(param3.overwrite);
      var local4:Array = masterList[param1];
      if(!local4) {
        masterList[param1] = [this];
      } else if(this._overwrite == 1) {
        for each(local5 in local4) {
          if(!local5.gc) {
            local5.setEnabled(false,false);
          }
        }
        masterList[param1] = [this];
      } else {
        local4[local4.length] = this;
      }
      if(this.active || Boolean(this.vars.immediateRender)) {
        this.renderTime(0,false,true);
      }
    }

    public static function initClass() : void {
      rootFrame = 0;
      rootTimeline = new SimpleTimeline(null);
      rootFramesTimeline = new SimpleTimeline(null);
      rootTimeline.cachedStartTime = getTimer() * 0.001;
      rootFramesTimeline.cachedStartTime = rootFrame;
      rootTimeline.autoRemoveChildren = true;
      rootFramesTimeline.autoRemoveChildren = true;
      _shape.addEventListener(Event.ENTER_FRAME,updateAll,false,0,true);
      if(overwriteManager == null) {
        overwriteManager = {
          "mode":1,
          "enabled":false
        };
      }
    }

    public static function to(param1:Object, param2:Number, param3:Object) : TweenLite {
      return new TweenLite(param1,param2,param3);
    }

    public static function from(param1:Object, param2:Number, param3:Object) : TweenLite {
      if(Boolean(param3.isGSVars)) {
        param3 = param3.vars;
      }
      param3.runBackwards = true;
      if(!("immediateRender" in param3)) {
        param3.immediateRender = true;
      }
      return new TweenLite(param1,param2,param3);
    }

    protected static function updateAll(param1:Event = null) : void {
      var local2:Dictionary = null;
      var local3:Object = null;
      var local4:Array = null;
      var local5:int = 0;
      rootTimeline.renderTime((getTimer() * 0.001 - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale,false,false);
      rootFrame += 1;
      rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale,false,false);
      if(!(rootFrame % 60)) {
        local2 = masterList;
        for(local3 in local2) {
          local4 = local2[local3];
          local5 = int(local4.length);
          while(--local5 > -1) {
            if(TweenLite(local4[local5]).gc) {
              local4.splice(local5,1);
            }
          }
          if(local4.length == 0) {
            delete local2[local3];
          }
        }
      }
    }

    public static function killTweensOf(param1:Object, param2:Boolean = false, param3:Object = null) : void {
      var local4:Array = null;
      var local5:int = 0;
      var local6:TweenLite = null;
      if(param1 in masterList) {
        local4 = masterList[param1];
        local5 = int(local4.length);
        while(--local5 > -1) {
          local6 = local4[local5];
          if(!local6.gc) {
            if(param2) {
              local6.complete(false,false);
            }
            if(param3 != null) {
              local6.killVars(param3);
            }
            if(param3 == null || local6.cachedPT1 == null && local6.initted) {
              local6.setEnabled(false,false);
            }
          }
        }
        if(param3 == null) {
          delete masterList[param1];
        }
      }
    }

    protected static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
      return 1 - (param1 = 1 - param1 / param4) * param1;
    }

    protected function init() : void {
      var local1:String = null;
      var local2:int = 0;
      var local3:* = undefined;
      var local4:Boolean = false;
      var local5:Array = null;
      var local6:PropTween = null;
      if(Boolean(this.vars.onInit)) {
        this.vars.onInit.apply(null,this.vars.onInitParams);
      }
      if(typeof this.vars.ease == "function") {
        this._ease = this.vars.ease;
      }
      if(Boolean(this.vars.easeParams)) {
        this.vars.proxiedEase = this._ease;
        this._ease = this.easeProxy;
      }
      this.cachedPT1 = null;
      this.propTweenLookup = {};
      for(local1 in this.vars) {
        if(!(local1 in _reservedProps && !(local1 == "timeScale" && this.target is TweenCore))) {
          if(local1 in plugins && Boolean((local3 = new (plugins[local1] as Class)()).onInitTween(this.target,this.vars[local1],this))) {
            this.cachedPT1 = new PropTween(local3,"changeFactor",0,1,local3.overwriteProps.length == 1 ? local3.overwriteProps[0] : "_MULTIPLE_",true,this.cachedPT1);
            if(this.cachedPT1.name == "_MULTIPLE_") {
              local2 = int(local3.overwriteProps.length);
              while(--local2 > -1) {
                this.propTweenLookup[local3.overwriteProps[local2]] = this.cachedPT1;
              }
            } else {
              this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
            }
            if(Boolean(local3.priority)) {
              this.cachedPT1.priority = local3.priority;
              local4 = true;
            }
            if(Boolean(local3.onDisable) || Boolean(local3.onEnable)) {
              this._notifyPluginsOfEnabled = true;
            }
            this._hasPlugins = true;
          } else {
            this.cachedPT1 = new PropTween(this.target,local1,Number(this.target[local1]),typeof this.vars[local1] == "number" ? Number(this.vars[local1]) - this.target[local1] : Number(this.vars[local1]),local1,false,this.cachedPT1);
            this.propTweenLookup[local1] = this.cachedPT1;
          }
        }
      }
      if(local4) {
        onPluginEvent("onInitAllProps",this);
      }
      if(Boolean(this.vars.runBackwards)) {
        local6 = this.cachedPT1;
        while(Boolean(local6)) {
          local6.start += local6.change;
          local6.change = -local6.change;
          local6 = local6.nextNode;
        }
      }
      _hasUpdate = Boolean(this.vars.onUpdate != null);
      if(Boolean(this._overwrittenProps)) {
        this.killVars(this._overwrittenProps);
        if(this.cachedPT1 == null) {
          this.setEnabled(false,false);
        }
      }
      if(this._overwrite > 1 && this.cachedPT1 && (local5 = masterList[this.target]) && local5.length > 1) {
        if(Boolean(overwriteManager.manageOverwrites(this,this.propTweenLookup,local5,this._overwrite))) {
          this.init();
        }
      }
      this.initted = true;
    }

    override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void {
      var local4:Boolean = false;
      var local5:Number = this.cachedTime;
      if(param1 >= this.cachedDuration) {
        this.cachedTotalTime = this.cachedTime = this.cachedDuration;
        this.ratio = 1;
        local4 = !this.cachedReversed;
        if(this.cachedDuration == 0) {
          if((param1 == 0 || _rawPrevTime < 0) && _rawPrevTime != param1) {
            param3 = true;
          }
          _rawPrevTime = param1;
        }
      } else if(param1 <= 0) {
        this.cachedTotalTime = this.cachedTime = this.ratio = 0;
        if(param1 < 0) {
          this.active = false;
          if(this.cachedDuration == 0) {
            if(_rawPrevTime >= 0) {
              param3 = true;
              local4 = _rawPrevTime > 0;
            }
            _rawPrevTime = param1;
          }
        }
        if(this.cachedReversed && local5 != 0) {
          local4 = true;
        }
      } else {
        this.cachedTotalTime = this.cachedTime = param1;
        this.ratio = this._ease(param1,0,1,this.cachedDuration);
      }
      if(this.cachedTime == local5 && !param3) {
        return;
      }
      if(!this.initted) {
        this.init();
        if(!local4 && Boolean(this.cachedTime)) {
          this.ratio = this._ease(this.cachedTime,0,1,this.cachedDuration);
        }
      }
      if(!this.active && !this.cachedPaused) {
        this.active = true;
      }
      if(local5 == 0 && this.vars.onStart && (this.cachedTime != 0 || this.cachedDuration == 0) && !param2) {
        this.vars.onStart.apply(null,this.vars.onStartParams);
      }
      var local6:PropTween = this.cachedPT1;
      while(Boolean(local6)) {
        local6.target[local6.property] = local6.start + this.ratio * local6.change;
        local6 = local6.nextNode;
      }
      if(_hasUpdate && !param2) {
        this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
      }
      if(local4 && !this.gc) {
        if(this._hasPlugins && Boolean(this.cachedPT1)) {
          onPluginEvent("onComplete",this);
        }
        complete(true,param2);
      }
    }

    public function killVars(param1:Object, param2:Boolean = true) : Boolean {
      var local3:String = null;
      var local4:PropTween = null;
      var local5:Boolean = false;
      if(this._overwrittenProps == null) {
        this._overwrittenProps = {};
      }
      for(local3 in param1) {
        if(local3 in this.propTweenLookup) {
          local4 = this.propTweenLookup[local3];
          if(local4.isPlugin && local4.name == "_MULTIPLE_") {
            local4.target.killProps(param1);
            if(local4.target.overwriteProps.length == 0) {
              local4.name = "";
            }
            if(local3 != local4.target.propName || local4.name == "") {
              delete this.propTweenLookup[local3];
            }
          }
          if(local4.name != "_MULTIPLE_") {
            if(Boolean(local4.nextNode)) {
              local4.nextNode.prevNode = local4.prevNode;
            }
            if(Boolean(local4.prevNode)) {
              local4.prevNode.nextNode = local4.nextNode;
            } else if(this.cachedPT1 == local4) {
              this.cachedPT1 = local4.nextNode;
            }
            if(local4.isPlugin && Boolean(local4.target.onDisable)) {
              local4.target.onDisable();
              if(Boolean(local4.target.activeDisable)) {
                local5 = true;
              }
            }
            delete this.propTweenLookup[local3];
          }
        }
        if(param2 && param1 != this._overwrittenProps) {
          this._overwrittenProps[local3] = 1;
        }
      }
      return local5;
    }

    override public function invalidate() : void {
      if(this._notifyPluginsOfEnabled && Boolean(this.cachedPT1)) {
        onPluginEvent("onDisable",this);
      }
      this.cachedPT1 = null;
      this._overwrittenProps = null;
      _hasUpdate = this.initted = this.active = this._notifyPluginsOfEnabled = false;
      this.propTweenLookup = {};
    }

    override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean {
      var local3:Array = null;
      if(param1) {
        local3 = TweenLite.masterList[this.target];
        if(!local3) {
          TweenLite.masterList[this.target] = [this];
        } else if(local3.indexOf(this) == -1) {
          local3[local3.length] = this;
        }
      }
      super.setEnabled(param1,param2);
      if(this._notifyPluginsOfEnabled && Boolean(this.cachedPT1)) {
        return onPluginEvent(param1 ? "onEnable" : "onDisable",this);
      }
      return false;
    }

    protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
      return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
    }
  }
}
