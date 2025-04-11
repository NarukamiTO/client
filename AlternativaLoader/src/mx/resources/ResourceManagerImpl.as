package mx.resources {
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.FocusEvent;
  import flash.events.IEventDispatcher;
  import flash.events.TimerEvent;
  import flash.system.ApplicationDomain;
  import flash.system.Capabilities;
  import flash.system.SecurityDomain;
  import flash.utils.Dictionary;
  import flash.utils.Timer;
  import mx.core.mx_internal;
  import mx.events.FlexEvent;
  import mx.events.ModuleEvent;
  import mx.events.ResourceEvent;
  import mx.managers.SystemManagerGlobals;
  import mx.modules.IModuleInfo;
  import mx.modules.ModuleManager;
  import mx.utils.StringUtil;

  use namespace mx_internal;

  public class ResourceManagerImpl extends EventDispatcher implements IResourceManager {
    private static var instance:IResourceManager;

    mx_internal static const VERSION:String = "4.6.0.23201";

    private var ignoreMissingBundles:Boolean;
    private var bundleDictionary:Dictionary;
    private var localeMap:Object = {};
    private var resourceModules:Object = {};
    private var initializedForNonFrameworkApp:Boolean = false;
    private var _localeChain:Array;

    public function ResourceManagerImpl() {
      super();
      if(SystemManagerGlobals.topLevelSystemManagers.length) {
        if(SystemManagerGlobals.topLevelSystemManagers[0].currentFrame == 1) {
          this.ignoreMissingBundles = true;
          SystemManagerGlobals.topLevelSystemManagers[0].addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
        }
      }
      var local1:Object = SystemManagerGlobals.info;
      if(local1) {
        this.processInfo(local1,false);
      }
      this.ignoreMissingBundles = false;
      if(SystemManagerGlobals.topLevelSystemManagers.length) {
        SystemManagerGlobals.topLevelSystemManagers[0].addEventListener(FlexEvent.NEW_CHILD_APPLICATION,this.newChildApplicationHandler);
      }
    }

    public static function getInstance() : IResourceManager {
      if(!instance) {
        instance = new ResourceManagerImpl();
      }
      return instance;
    }

    public function get localeChain() : Array {
      return this._localeChain;
    }

    public function set localeChain(param1:Array) : void {
      this._localeChain = param1;
      this.update();
    }

    public function installCompiledResourceBundles(param1:ApplicationDomain, param2:Array, param3:Array, param4:Boolean = false) : Array {
      var local10:String = null;
      var local11:int = 0;
      var local12:String = null;
      var local13:IResourceBundle = null;
      var local5:Array = [];
      var local6:uint = 0;
      var local7:int = !!param2 ? int(param2.length) : 0;
      var local8:int = !!param3 ? int(param3.length) : 0;
      var local9:int = 0;
      while(local9 < local7) {
        local10 = param2[local9];
        local11 = 0;
        while(local11 < local8) {
          local12 = param3[local11];
          local13 = this.installCompiledResourceBundle(param1,local10,local12,param4);
          if(local13) {
            var local14:*;
            local5[local14 = local6++] = local13;
          }
          local11++;
        }
        local9++;
      }
      return local5;
    }

    private function installCompiledResourceBundle(param1:ApplicationDomain, param2:String, param3:String, param4:Boolean = false) : IResourceBundle {
      var local5:String = null;
      var local6:String = param3;
      var local7:int = int(param3.indexOf(":"));
      if(local7 != -1) {
        local5 = param3.substring(0,local7);
        local6 = param3.substring(local7 + 1);
      }
      var local8:IResourceBundle = this.getResourceBundleInternal(param2,param3,param4);
      if(local8) {
        return local8;
      }
      var local9:* = param2 + "$" + local6 + "_properties";
      if(local5 != null) {
        local9 = local5 + "." + local9;
      }
      var local10:Class = null;
      if(param1.hasDefinition(local9)) {
        local10 = Class(param1.getDefinition(local9));
      }
      if(!local10) {
        local9 = param3;
        if(param1.hasDefinition(local9)) {
          local10 = Class(param1.getDefinition(local9));
        }
      }
      if(!local10) {
        local9 = param3 + "_properties";
        if(param1.hasDefinition(local9)) {
          local10 = Class(param1.getDefinition(local9));
        }
      }
      if(!local10) {
        if(this.ignoreMissingBundles) {
          return null;
        }
        throw new Error("Could not find compiled resource bundle \'" + param3 + "\' for locale \'" + param2 + "\'.");
      }
      local8 = ResourceBundle(new local10());
      ResourceBundle(local8).mx_internal::_locale = param2;
      ResourceBundle(local8).mx_internal::_bundleName = param3;
      this.addResourceBundle(local8,param4);
      return local8;
    }

    private function newChildApplicationHandler(param1:FocusEvent) : void {
      var local2:Object = param1.relatedObject["info"]();
      var local3:Boolean = false;
      if("_resourceBundles" in param1.relatedObject) {
        local3 = true;
      }
      var local4:Array = this.processInfo(local2,local3);
      if(local3) {
        param1.relatedObject["_resourceBundles"] = local4;
      }
    }

    private function processInfo(param1:Object, param2:Boolean) : Array {
      var local3:Array = param1["compiledLocales"];
      ResourceBundle.mx_internal::locale = local3 != null && local3.length > 0 ? local3[0] : "en_US";
      var local4:String = SystemManagerGlobals.parameters["localeChain"];
      if(local4 != null && local4 != "") {
        this.localeChain = local4.split(",");
      }
      var local5:ApplicationDomain = param1["currentDomain"];
      var local6:Array = param1["compiledResourceBundleNames"];
      var local7:Array = this.installCompiledResourceBundles(local5,local3,local6,param2);
      if(!this.localeChain) {
        this.initializeLocaleChain(local3);
      }
      return local7;
    }

    public function initializeLocaleChain(param1:Array) : void {
      this.localeChain = LocaleSorter.sortLocalesByPreference(param1,this.getSystemPreferredLocales(),null,true);
    }

    public function loadResourceModule(param1:String, param2:Boolean = true, param3:ApplicationDomain = null, param4:SecurityDomain = null) : IEventDispatcher {
      var errorHandler:Function;
      var moduleInfo:IModuleInfo = null;
      var resourceEventDispatcher:ResourceEventDispatcher = null;
      var timer:Timer = null;
      var timerHandler:Function = null;
      var url:String = param1;
      var updateFlag:Boolean = param2;
      var applicationDomain:ApplicationDomain = param3;
      var securityDomain:SecurityDomain = param4;
      moduleInfo = ModuleManager.getModule(url);
      resourceEventDispatcher = new ResourceEventDispatcher(moduleInfo);
      var readyHandler:Function = function(param1:ModuleEvent):void {
        var local2:* = param1.module.factory.create();
        resourceModules[param1.module.url].resourceModule = local2;
        if(updateFlag) {
          update();
        }
      };
      moduleInfo.addEventListener(ModuleEvent.READY,readyHandler,false,0,true);
      errorHandler = function(param1:ModuleEvent):void {
        var local3:ResourceEvent = null;
        var local2:String = "Unable to load resource module from " + url;
        if(resourceEventDispatcher.willTrigger(ResourceEvent.ERROR)) {
          local3 = new ResourceEvent(ResourceEvent.ERROR,param1.bubbles,param1.cancelable);
          local3.bytesLoaded = 0;
          local3.bytesTotal = 0;
          local3.errorText = local2;
          resourceEventDispatcher.dispatchEvent(local3);
          return;
        }
        throw new Error(local2);
      };
      moduleInfo.addEventListener(ModuleEvent.ERROR,errorHandler,false,0,true);
      this.resourceModules[url] = new ResourceModuleInfo(moduleInfo,readyHandler,errorHandler);
      timer = new Timer(0);
      timerHandler = function(param1:TimerEvent):void {
        timer.removeEventListener(TimerEvent.TIMER,timerHandler);
        timer.stop();
        moduleInfo.load(applicationDomain,securityDomain);
      };
      timer.addEventListener(TimerEvent.TIMER,timerHandler,false,0,true);
      timer.start();
      return resourceEventDispatcher;
    }

    public function unloadResourceModule(param1:String, param2:Boolean = true) : void {
      var local4:Array = null;
      var local5:int = 0;
      var local6:int = 0;
      var local7:String = null;
      var local8:String = null;
      var local3:ResourceModuleInfo = this.resourceModules[param1];
      if(!local3) {
        return;
      }
      if(local3.resourceModule) {
        local4 = local3.resourceModule.resourceBundles;
        if(local4) {
          local5 = int(local4.length);
          local6 = 0;
          while(local6 < local5) {
            local7 = local4[local6].locale;
            local8 = local4[local6].bundleName;
            this.removeResourceBundle(local7,local8);
            local6++;
          }
        }
      }
      this.resourceModules[param1] = null;
      delete this.resourceModules[param1];
      local3.moduleInfo.unload();
      if(param2) {
        this.update();
      }
    }

    public function addResourceBundle(param1:IResourceBundle, param2:Boolean = false) : void {
      var local3:String = param1.locale;
      var local4:String = param1.bundleName;
      if(!this.localeMap[local3]) {
        this.localeMap[local3] = {};
      }
      if(param2) {
        if(!this.bundleDictionary) {
          this.bundleDictionary = new Dictionary(true);
        }
        this.bundleDictionary[param1] = local3 + local4;
        this.localeMap[local3][local4] = this.bundleDictionary;
      } else {
        this.localeMap[local3][local4] = param1;
      }
    }

    public function getResourceBundle(param1:String, param2:String) : IResourceBundle {
      return this.getResourceBundleInternal(param1,param2,false);
    }

    private function getResourceBundleInternal(param1:String, param2:String, param3:Boolean) : IResourceBundle {
      var local7:String = null;
      var local8:Object = null;
      var local4:Object = this.localeMap[param1];
      if(!local4) {
        return null;
      }
      var local5:IResourceBundle = null;
      var local6:Object = local4[param2];
      if(local6 is Dictionary) {
        if(param3) {
          return null;
        }
        local7 = param1 + param2;
        for(local8 in local6) {
          if(local6[local8] == local7) {
            local5 = local8 as IResourceBundle;
            break;
          }
        }
      } else {
        local5 = local6 as IResourceBundle;
      }
      return local5;
    }

    public function removeResourceBundle(param1:String, param2:String) : void {
      delete this.localeMap[param1][param2];
      if(this.getBundleNamesForLocale(param1).length == 0) {
        delete this.localeMap[param1];
      }
    }

    public function removeResourceBundlesForLocale(param1:String) : void {
      delete this.localeMap[param1];
    }

    public function update() : void {
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function getLocales() : Array {
      var local2:String = null;
      var local1:Array = [];
      for(local2 in this.localeMap) {
        local1.push(local2);
      }
      return local1;
    }

    public function getPreferredLocaleChain() : Array {
      return LocaleSorter.sortLocalesByPreference(this.getLocales(),this.getSystemPreferredLocales(),null,true);
    }

    public function getBundleNamesForLocale(param1:String) : Array {
      var local3:String = null;
      var local2:Array = [];
      for(local3 in this.localeMap[param1]) {
        local2.push(local3);
      }
      return local2;
    }

    public function findResourceBundleWithResource(param1:String, param2:String) : IResourceBundle {
      var local5:String = null;
      var local6:Object = null;
      var local7:Object = null;
      var local8:IResourceBundle = null;
      var local9:String = null;
      var local10:Object = null;
      if(!this._localeChain) {
        return null;
      }
      var local3:int = int(this._localeChain.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = this.localeChain[local4];
        local6 = this.localeMap[local5];
        if(local6) {
          local7 = local6[param1];
          if(local7) {
            local8 = null;
            if(local7 is Dictionary) {
              local9 = local5 + param1;
              for(local10 in local7) {
                if(local7[local10] == local9) {
                  local8 = local10 as IResourceBundle;
                  break;
                }
              }
            } else {
              local8 = local7 as IResourceBundle;
            }
            if(Boolean(local8) && param2 in local8.content) {
              return local8;
            }
          }
        }
        local4++;
      }
      return null;
    }

    [Bindable("change")]
    public function getObject(param1:String, param2:String, param3:String = null) : * {
      var local4:IResourceBundle = this.findBundle(param1,param2,param3);
      if(!local4) {
        return undefined;
      }
      return local4.content[param2];
    }

    [Bindable("change")]
    public function getString(param1:String, param2:String, param3:Array = null, param4:String = null) : String {
      var local5:IResourceBundle = this.findBundle(param1,param2,param4);
      if(!local5) {
        return null;
      }
      var local6:String = String(local5.content[param2]);
      if(param3) {
        local6 = StringUtil.substitute(local6,param3);
      }
      return local6;
    }

    [Bindable("change")]
    public function getStringArray(param1:String, param2:String, param3:String = null) : Array {
      var local4:IResourceBundle = this.findBundle(param1,param2,param3);
      if(!local4) {
        return null;
      }
      var local5:* = local4.content[param2];
      var local6:Array = String(local5).split(",");
      var local7:int = int(local6.length);
      var local8:int = 0;
      while(local8 < local7) {
        local6[local8] = StringUtil.trim(local6[local8]);
        local8++;
      }
      return local6;
    }

    [Bindable("change")]
    public function getNumber(param1:String, param2:String, param3:String = null) : Number {
      var local4:IResourceBundle = this.findBundle(param1,param2,param3);
      if(!local4) {
        return NaN;
      }
      var local5:* = local4.content[param2];
      return Number(local5);
    }

    [Bindable("change")]
    public function getInt(param1:String, param2:String, param3:String = null) : int {
      var local4:IResourceBundle = this.findBundle(param1,param2,param3);
      if(!local4) {
        return 0;
      }
      var local5:* = local4.content[param2];
      return int(local5);
    }

    [Bindable("change")]
    public function getUint(param1:String, param2:String, param3:String = null) : uint {
      var local4:IResourceBundle = this.findBundle(param1,param2,param3);
      if(!local4) {
        return 0;
      }
      var local5:* = local4.content[param2];
      return uint(local5);
    }

    [Bindable("change")]
    public function getBoolean(param1:String, param2:String, param3:String = null) : Boolean {
      var local4:IResourceBundle = this.findBundle(param1,param2,param3);
      if(!local4) {
        return false;
      }
      var local5:* = local4.content[param2];
      return String(local5).toLowerCase() == "true";
    }

    [Bindable("change")]
    public function getClass(param1:String, param2:String, param3:String = null) : Class {
      var local4:IResourceBundle = this.findBundle(param1,param2,param3);
      if(!local4) {
        return null;
      }
      var local5:* = local4.content[param2];
      return local5 as Class;
    }

    private function findBundle(param1:String, param2:String, param3:String) : IResourceBundle {
      this.supportNonFrameworkApps();
      return param3 != null ? this.getResourceBundle(param3,param1) : this.findResourceBundleWithResource(param1,param2);
    }

    private function supportNonFrameworkApps() : void {
      if(this.initializedForNonFrameworkApp) {
        return;
      }
      this.initializedForNonFrameworkApp = true;
      if(this.getLocales().length > 0) {
        return;
      }
      var local1:ApplicationDomain = ApplicationDomain.currentDomain;
      if(!local1.hasDefinition("_CompiledResourceBundleInfo")) {
        return;
      }
      var local2:Class = Class(local1.getDefinition("_CompiledResourceBundleInfo"));
      var local3:Array = local2.compiledLocales;
      var local4:Array = local2.compiledResourceBundleNames;
      this.installCompiledResourceBundles(local1,local3,local4);
      this.localeChain = local3;
    }

    private function getSystemPreferredLocales() : Array {
      var local1:Array = null;
      if(Capabilities["languages"]) {
        local1 = Capabilities["languages"];
      } else {
        local1 = [Capabilities.language];
      }
      return local1;
    }

    private function dumpResourceModule(param1:*) : void {
      var local2:ResourceBundle = null;
      var local3:String = null;
      for each(local2 in param1.resourceBundles) {
        trace(local2.locale,local2.bundleName);
        for(local3 in local2.content) {
        }
      }
    }

    private function enterFrameHandler(param1:Event) : void {
      if(SystemManagerGlobals.topLevelSystemManagers.length) {
        if(SystemManagerGlobals.topLevelSystemManagers[0].currentFrame != 2) {
          return;
        }
        SystemManagerGlobals.topLevelSystemManagers[0].removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      var local2:Object = SystemManagerGlobals.info;
      if(local2) {
        this.processInfo(local2,false);
      }
    }
  }
}

import flash.events.EventDispatcher;
import mx.events.ModuleEvent;
import mx.events.ResourceEvent;
import mx.modules.IModuleInfo;
class ResourceModuleInfo {
  public var errorHandler:Function;
  public var moduleInfo:IModuleInfo;
  public var readyHandler:Function;
  public var resourceModule:IResourceModule;

  public function ResourceModuleInfo(param1:IModuleInfo, param2:Function, param3:Function) {
    super();
    this.moduleInfo = param1;
    this.readyHandler = param2;
    this.errorHandler = param3;
  }
}

class ResourceEventDispatcher extends EventDispatcher {
  public function ResourceEventDispatcher(param1:IModuleInfo) {
    super();
    param1.addEventListener(ModuleEvent.ERROR,this.moduleInfo_errorHandler,false,0,true);
    param1.addEventListener(ModuleEvent.PROGRESS,this.moduleInfo_progressHandler,false,0,true);
    param1.addEventListener(ModuleEvent.READY,this.moduleInfo_readyHandler,false,0,true);
  }

  private function moduleInfo_errorHandler(param1:ModuleEvent) : void {
    var local2:ResourceEvent = new ResourceEvent(ResourceEvent.ERROR,param1.bubbles,param1.cancelable);
    local2.bytesLoaded = param1.bytesLoaded;
    local2.bytesTotal = param1.bytesTotal;
    local2.errorText = param1.errorText;
    dispatchEvent(local2);
  }

  private function moduleInfo_progressHandler(param1:ModuleEvent) : void {
    var local2:ResourceEvent = new ResourceEvent(ResourceEvent.PROGRESS,param1.bubbles,param1.cancelable);
    local2.bytesLoaded = param1.bytesLoaded;
    local2.bytesTotal = param1.bytesTotal;
    dispatchEvent(local2);
  }

  private function moduleInfo_readyHandler(param1:ModuleEvent) : void {
    var local2:ResourceEvent = new ResourceEvent(ResourceEvent.COMPLETE);
    dispatchEvent(local2);
  }
}
