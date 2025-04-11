package alternativa.engine3d.core {
  import flash.display.Stage;
  import flash.events.Event;
  import flash.net.SharedObject;
  import flash.utils.clearInterval;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;

  public class PerformanceController {
    public static const FOG:String = "fog";
    public static const DIRECTIONAL_LIGHT:String = "directionalLight";
    public static const SHADOW_MAP:String = "shadowMap";
    public static const SOFT_TRANSPARENCY:String = "softTransparency";
    public static const SHADOWS:String = "shadows";
    public static const ANTI_ALIAS:String = "antiAlias";
    public static const SSAO:String = "ssao";
    public static const DEFERRED_LIGHTING:String = "deferredLighting";

    private static var storage:SharedObject = SharedObject.getLocal("performance");

    private var types:Vector.<String> = new Vector.<String>();
    private var speeds:Vector.<Number> = new Vector.<Number>();
    private var actives:Vector.<Boolean> = new Vector.<Boolean>();
    private var stage:Stage;
    private var camera:Camera3D;
    private var fpsThreshold:Number;
    private var ratioThreshold:Number;
    private var testTime:Number;
    private var maxAttempts:uint;
    private var key:String;
    private var traceLog:Boolean;
    private var mask:int;
    private var id:uint;
    private var idleId:uint;
    private var timer:int;
    private var frameCounter:int;
    private var lowCounter:int;
    private var state:int;
    private var features:Vector.<Feature>;
    private var featuresCount:int;
    private var index:int;
    private var _block:Boolean = false;
    private var afterIdle:Boolean;

    public function PerformanceController() {
      super();
    }

    public function addFeature(param1:String, param2:Number, param3:Boolean) : void {
      var local4:String = null;
      if(this.camera != null) {
        throw new Error("Cannot add feature during analysis.");
      }
      if(param1 != FOG && param1 != SHADOWS && param1 != DIRECTIONAL_LIGHT && param1 != SHADOW_MAP && param1 != SOFT_TRANSPARENCY && param1 != ANTI_ALIAS && param1 != SSAO && param1 != DEFERRED_LIGHTING) {
        throw new Error("Nonexistent feature.");
      }
      for each(local4 in this.types) {
        if(local4 == param1) {
          throw new Error("Feature already exists.");
        }
      }
      this.types.push(param1);
      this.speeds.push(param2);
      this.actives.push(param3);
    }

    public function get activated() : Boolean {
      return this.camera != null;
    }

    public function clearSharedObject() : void {
      storage.clear();
    }

    public function start(param1:Stage, param2:Camera3D, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint, param8:String, param9:Boolean = false) : void {
      var local10:int = 0;
      if(this.camera != null) {
        throw new Error("Analysis already started.");
      }
      var local11:int = int(this.types.length);
      this.stage = param1;
      this.camera = param2;
      this.fpsThreshold = param3;
      this.ratioThreshold = param4;
      this.testTime = param6;
      this.maxAttempts = param7;
      this.key = param8;
      this.traceLog = param9;
      this.mask = 0;
      local10 = 0;
      while(local10 < local11) {
        this.key += "_5_" + this.types[local10];
        if(this.actives[local10]) {
          this.mask |= 1 << local10;
        }
        local10++;
      }
      if(storage.data[this.key] != undefined) {
        this.mask = storage.data[this.key];
      } else {
        this.save();
      }
      this.features = new Vector.<Feature>();
      this.featuresCount = 0;
      local10 = 0;
      while(local10 < local11) {
        if((this.mask & 1 << local10) > 0) {
          this.features[this.featuresCount] = new Feature(this.types[local10],this.speeds[local10]);
          ++this.featuresCount;
        }
        local10++;
      }
      this.index = this.featuresCount - 1;
      local10 = 0;
      while(local10 < local11) {
        if((this.mask & 1 << local10) == 0) {
          this.features[this.featuresCount] = new Feature(this.types[local10],this.speeds[local10]);
          ++this.featuresCount;
          this.disableFeature(this.types[local10]);
        }
        local10++;
      }
      this.afterIdle = false;
      if(param5 > 0) {
        this.idleId = setTimeout(this.onIdle,param5 * 1000);
      } else {
        this.onIdle();
      }
      this.traceFeatures("\nStart",true);
    }

    public function stop() : void {
      if(this.camera == null) {
        return;
      }
      this.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      clearInterval(this.id);
      clearInterval(this.idleId);
      var local1:int = int(this.types.length);
      var local2:int = 0;
      while(local2 < local1) {
        this.restoreFeature(this.types[local2]);
        local2++;
      }
      this.stage = null;
      this.camera = null;
    }

    public function get block() : Boolean {
      return this._block;
    }

    public function set block(param1:Boolean) : void {
      if(this._block != param1) {
        this._block = param1;
        this.traceFeatures("\nBlock " + this._block,false);
        if(this.camera != null && this.afterIdle) {
          if(this._block) {
            this.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            clearInterval(this.id);
            if(this.index < this.featuresCount - 1) {
              this.disableFeature(Feature(this.features[this.index + 1]).type);
            }
          } else {
            this.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.timer = getTimer();
            if(this.state == 0) {
              this.testCurrent();
            }
          }
        }
      }
    }

    private function onIdle() : void {
      this.state = 0;
      this.afterIdle = true;
      if(!this._block) {
        this.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
        this.timer = getTimer();
        this.testCurrent();
      }
    }

    private function onEnterFrame(param1:Event) : void {
      var local4:Number = NaN;
      var local2:int = getTimer();
      var local3:Number = (local2 - this.timer) / 1000;
      this.timer = local2;
      if(this.state == 1) {
        local4 = this.changeStrength(Feature(this.features[this.index]).type,local3 * this.speeds[this.index]);
        if(local4 >= 1) {
          if(this.index + 1 < this.featuresCount) {
            this.testNext();
          } else {
            this.testCurrent();
          }
        }
      } else if(this.state == -1) {
        local4 = this.changeStrength(Feature(this.features[this.index]).type,-local3 * this.speeds[this.index]);
        if(local4 <= 0) {
          this.mask &= ~(1 << this.types.indexOf(Feature(this.features[this.index]).type));
          this.save();
          --this.index;
          this.swap();
          this.traceFeatures(null,true);
          this.testCurrent();
        }
      } else {
        ++this.frameCounter;
        if(1 / local3 < this.fpsThreshold) {
          ++this.lowCounter;
        }
      }
    }

    private function testNext() : void {
      this.state = 0;
      this.frameCounter = 0;
      this.lowCounter = 0;
      this.testFeature(Feature(this.features[this.index + 1]).type);
      this.id = setTimeout(this.onTestNext,this.testTime * 1000);
      this.traceFeatures("\nTest Next " + String(this.index + 1) + " " + this.features[this.index + 1].type,false);
    }

    private function onTestNext() : void {
      if(this.lowCounter / this.frameCounter < this.ratioThreshold) {
        ++this.index;
        this.mask |= 1 << this.types.indexOf(Feature(this.features[this.index]).type);
        this.save();
        Feature(this.features[this.index]).attempts = 0;
        this.state = 1;
        this.traceFeatures("SUCCESS",true);
      } else {
        this.swap();
        this.traceFeatures("FAIL",true);
        if(this.index + 1 < this.featuresCount) {
          this.testNext();
        } else {
          this.testCurrent();
        }
      }
    }

    private function testCurrent() : void {
      this.state = 0;
      this.frameCounter = 0;
      this.lowCounter = 0;
      this.id = setTimeout(this.onTestCurrent,this.testTime * 1000);
      this.traceFeatures("\nTest Current " + this.index + " " + (this.index >= 0 ? this.features[this.index].type : "none"),false);
    }

    private function onTestCurrent() : void {
      if(this.lowCounter / this.frameCounter < this.ratioThreshold) {
        this.traceFeatures("SUCCESS",true);
        if(this.index + 1 < this.featuresCount) {
          this.testNext();
        } else {
          this.testCurrent();
        }
      } else if(this.index >= 0) {
        this.traceFeatures("FAIL",false);
        this.state = -1;
      } else {
        this.traceFeatures("FAIL",true);
        this.testCurrent();
      }
    }

    private function swap() : void {
      var local1:Feature = Feature(this.features[this.index + 1]);
      this.disableFeature(local1.type);
      ++local1.attempts;
      var local2:int = this.index + 1;
      while(local2 < this.featuresCount - 1) {
        this.features[local2] = this.features[local2 + 1];
        local2++;
      }
      if(local1.attempts < this.maxAttempts) {
        this.features[this.featuresCount - 1] = local1;
      } else {
        --this.featuresCount;
        this.features.length = this.featuresCount;
      }
    }

    private function save() : void {
      storage.data[this.key] = this.mask;
    }

    private function traceFeatures(param1:String = null, param2:Boolean = false) : void {
      var local3:int = 0;
      var local4:String = null;
      if(this.traceLog) {
        if(param1 != null) {
        }
        if(param2) {
          local3 = 0;
          while(local3 <= this.index) {
            local3++;
          }
          local3 = this.index + 1;
          while(local3 < this.featuresCount) {
            local3++;
          }
          local4 = " ";
          local3 = 0;
          while(local3 < this.types.length) {
            local4 += this.types[local3] + ((this.mask & 1 << local3) > 0 ? "+ " : "- ");
            local3++;
          }
        }
      }
    }

    private function disableFeature(param1:String) : void {
      switch(param1) {
        case FOG:
          this.camera.fogStrength = 0;
          break;
        case DIRECTIONAL_LIGHT:
          this.camera.directionalLightStrength = 0;
          break;
        case SHADOW_MAP:
          this.camera.shadowMapStrength = 0;
          break;
        case SOFT_TRANSPARENCY:
          this.camera.softTransparencyStrength = 0;
          break;
        case SHADOWS:
          this.camera.shadowsStrength = 0;
          break;
        case ANTI_ALIAS:
          this.camera.view.antiAliasEnabled = false;
          break;
        case SSAO:
          this.camera.ssaoStrength = 0;
          break;
        case DEFERRED_LIGHTING:
          this.camera.deferredLightingStrength = 0;
      }
    }

    private function restoreFeature(param1:String) : void {
      switch(param1) {
        case FOG:
          this.camera.fogStrength = 1;
          break;
        case DIRECTIONAL_LIGHT:
          this.camera.directionalLightStrength = 1;
          break;
        case SHADOW_MAP:
          this.camera.shadowMapStrength = 1;
          break;
        case SOFT_TRANSPARENCY:
          this.camera.softTransparencyStrength = 1;
          break;
        case SHADOWS:
          this.camera.shadowsStrength = 1;
          this.camera.shadowsDistanceMultiplier = 1;
          break;
        case ANTI_ALIAS:
          this.camera.view.antiAliasEnabled = true;
          break;
        case SSAO:
          this.camera.ssaoStrength = 1;
          break;
        case DEFERRED_LIGHTING:
          this.camera.deferredLightingStrength = 1;
      }
    }

    private function testFeature(param1:String) : void {
      switch(param1) {
        case FOG:
          this.camera.fogStrength = 0.01;
          break;
        case DIRECTIONAL_LIGHT:
          this.camera.directionalLightStrength = 0.01;
          break;
        case SHADOW_MAP:
          this.camera.shadowMapStrength = 0.01;
          break;
        case SOFT_TRANSPARENCY:
          this.camera.softTransparencyStrength = 0.01;
          break;
        case SHADOWS:
          this.camera.shadowsStrength = 0.01;
          break;
        case ANTI_ALIAS:
          this.camera.view.antiAliasEnabled = true;
          break;
        case SSAO:
          this.camera.ssaoStrength = 0.01;
          break;
        case DEFERRED_LIGHTING:
          this.camera.deferredLightingStrength = 0.01;
      }
    }

    private function changeStrength(param1:String, param2:Number) : Number {
      var local3:Number = 0;
      switch(param1) {
        case FOG:
          this.camera.fogStrength += param2;
          if(this.camera.fogStrength > 1) {
            this.camera.fogStrength = 1;
          }
          if(this.camera.fogStrength < 0) {
            this.camera.fogStrength = 0;
          }
          local3 = this.camera.fogStrength;
          break;
        case DIRECTIONAL_LIGHT:
          this.camera.directionalLightStrength += param2;
          if(this.camera.directionalLightStrength > 1) {
            this.camera.directionalLightStrength = 1;
          }
          if(this.camera.directionalLightStrength < 0) {
            this.camera.directionalLightStrength = 0;
          }
          local3 = this.camera.directionalLightStrength;
          break;
        case SHADOW_MAP:
          this.camera.shadowMapStrength += param2;
          if(this.camera.shadowMapStrength > 1) {
            this.camera.shadowMapStrength = 1;
          }
          if(this.camera.shadowMapStrength < 0) {
            this.camera.shadowMapStrength = 0;
          }
          local3 = this.camera.shadowMapStrength;
          break;
        case SOFT_TRANSPARENCY:
          this.camera.softTransparencyStrength += param2;
          if(this.camera.softTransparencyStrength > 1) {
            this.camera.softTransparencyStrength = 1;
          }
          if(this.camera.softTransparencyStrength < 0) {
            this.camera.softTransparencyStrength = 0;
          }
          local3 = this.camera.softTransparencyStrength;
          break;
        case SHADOWS:
          this.camera.shadowsStrength += param2;
          if(this.camera.shadowsStrength > 1) {
            this.camera.shadowsStrength = 1;
          }
          if(this.camera.shadowsStrength < 0) {
            this.camera.shadowsStrength = 0;
          }
          local3 = this.camera.shadowsStrength;
          break;
        case ANTI_ALIAS:
          this.camera.view.antiAliasEnabled = param2 > 0;
          local3 = this.camera.view.antiAliasEnabled ? 1 : 0;
          break;
        case SSAO:
          this.camera.ssaoStrength += param2;
          if(this.camera.ssaoStrength > 1) {
            this.camera.ssaoStrength = 1;
          }
          if(this.camera.ssaoStrength < 0) {
            this.camera.ssaoStrength = 0;
          }
          local3 = this.camera.ssaoStrength;
          break;
        case DEFERRED_LIGHTING:
          this.camera.deferredLightingStrength += param2;
          if(this.camera.deferredLightingStrength > 1) {
            this.camera.deferredLightingStrength = 1;
          }
          if(this.camera.deferredLightingStrength < 0) {
            this.camera.deferredLightingStrength = 0;
          }
          local3 = this.camera.deferredLightingStrength;
      }
      return local3;
    }
  }
}

class Feature {
  public var type:String;
  public var speed:Number;
  public var attempts:int = 0;

  public function Feature(param1:String, param2:Number) {
    super();
    this.type = param1;
    this.speed = param2;
  }
}
