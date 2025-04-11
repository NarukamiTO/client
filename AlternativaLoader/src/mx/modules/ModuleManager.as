package mx.modules {
  import mx.core.IFlexModuleFactory;
  import mx.core.mx_internal;

  use namespace mx_internal;

  public class ModuleManager {
    mx_internal static const VERSION:String = "4.6.0.23201";

    public function ModuleManager() {
      super();
    }

    public static function getModule(param1:String) : IModuleInfo {
      return getSingleton().getModule(param1);
    }

    public static function getAssociatedFactory(param1:Object) : IFlexModuleFactory {
      return getSingleton().getAssociatedFactory(param1);
    }

    private static function getSingleton() : Object {
      if(!ModuleManagerGlobals.managerSingleton) {
        ModuleManagerGlobals.managerSingleton = new ModuleManagerImpl();
      }
      return ModuleManagerGlobals.managerSingleton;
    }
  }
}

import flash.display.Loader;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.system.SecurityDomain;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;
import mx.core.IFlexModuleFactory;
import mx.events.ModuleEvent;
import mx.events.Request;
class ModuleManagerImpl extends EventDispatcher {
  private var moduleDictionary:Dictionary = new Dictionary(true);

  public function ModuleManagerImpl() {
    super();
  }

  public function getAssociatedFactory(param1:Object) : IFlexModuleFactory {
    var local3:Object = null;
    var local4:ModuleInfo = null;
    var local5:ApplicationDomain = null;
    var local6:Class = null;
    var local2:String = getQualifiedClassName(param1);
    for(local3 in this.moduleDictionary) {
      local4 = local3 as ModuleInfo;
      if(local4.ready) {
        local5 = local4.applicationDomain;
        if(local5.hasDefinition(local2)) {
          local6 = Class(local5.getDefinition(local2));
          if((Boolean(local6)) && param1 is local6) {
            return local4.factory;
          }
        }
      }
    }
    return null;
  }

  public function getModule(param1:String) : IModuleInfo {
    var local3:Object = null;
    var local4:ModuleInfo = null;
    var local2:ModuleInfo = null;
    for(local3 in this.moduleDictionary) {
      local4 = local3 as ModuleInfo;
      if(this.moduleDictionary[local4] == param1) {
        local2 = local4;
        break;
      }
    }
    if(!local2) {
      local2 = new ModuleInfo(param1);
      this.moduleDictionary[local2] = param1;
    }
    return new ModuleInfoProxy(local2);
  }
}

class ModuleInfo extends EventDispatcher {
  private var factoryInfo:FactoryInfo;
  private var loader:Loader;
  private var numReferences:int = 0;
  private var parentModuleFactory:IFlexModuleFactory;
  private var _error:Boolean = false;
  private var _loaded:Boolean = false;
  private var _ready:Boolean = false;
  private var _setup:Boolean = false;
  private var _url:String;

  public function ModuleInfo(param1:String) {
    super();
    this._url = param1;
  }

  public function get applicationDomain() : ApplicationDomain {
    return !!this.factoryInfo ? this.factoryInfo.applicationDomain : null;
  }

  public function get error() : Boolean {
    return this._error;
  }

  public function get factory() : IFlexModuleFactory {
    return !!this.factoryInfo ? this.factoryInfo.factory : null;
  }

  public function get loaded() : Boolean {
    return this._loaded;
  }

  public function get ready() : Boolean {
    return this._ready;
  }

  public function get setup() : Boolean {
    return this._setup;
  }

  public function get size() : int {
    return !!this.factoryInfo ? int(this.factoryInfo.bytesTotal) : 0;
  }

  public function get url() : String {
    return this._url;
  }

  public function load(param1:ApplicationDomain = null, param2:SecurityDomain = null, param3:ByteArray = null, param4:IFlexModuleFactory = null) : void {
    if(this._loaded) {
      return;
    }
    this._loaded = true;
    this.parentModuleFactory = param4;
    if(param3) {
      this.loadBytes(param1,param3);
      return;
    }
    if(this._url.indexOf("published://") == 0) {
      return;
    }
    var local5:URLRequest = new URLRequest(this._url);
    var local6:LoaderContext = new LoaderContext();
    local6.applicationDomain = !!param1 ? param1 : new ApplicationDomain(ApplicationDomain.currentDomain);
    if(param2 != null && Security.sandboxType == Security.REMOTE) {
      local6.securityDomain = param2;
    }
    this.loader = new Loader();
    this.loader.contentLoaderInfo.addEventListener(Event.INIT,this.initHandler);
    this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
    this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressHandler);
    this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
    this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.errorHandler);
    this.loader.load(local5,local6);
  }

  private function loadBytes(param1:ApplicationDomain, param2:ByteArray) : void {
    var local3:LoaderContext = new LoaderContext();
    local3.applicationDomain = !!param1 ? param1 : new ApplicationDomain(ApplicationDomain.currentDomain);
    if("allowLoadBytesCodeExecution" in local3) {
      local3["allowLoadBytesCodeExecution"] = true;
    }
    this.loader = new Loader();
    this.loader.contentLoaderInfo.addEventListener(Event.INIT,this.initHandler);
    this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
    this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
    this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.errorHandler);
    this.loader.loadBytes(param2,local3);
  }

  public function resurrect() : void {
    if(!this._ready) {
      return;
    }
    if(!this.factoryInfo) {
      if(this._loaded) {
        dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
      }
      this.loader = null;
      this._loaded = false;
      this._setup = false;
      this._ready = false;
      this._error = false;
    }
  }

  public function release() : void {
    if(!this._ready) {
      this.unload();
    }
  }

  private function clearLoader() : void {
    if(this.loader) {
      if(this.loader.contentLoaderInfo) {
        this.loader.contentLoaderInfo.removeEventListener(Event.INIT,this.initHandler);
        this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler);
        this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressHandler);
        this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
        this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.errorHandler);
      }
      try {
        if(this.loader.content) {
          this.loader.content.removeEventListener("ready",this.readyHandler);
          this.loader.content.removeEventListener("error",this.moduleErrorHandler);
        }
      }
      catch(error:Error) {
      }
      if(this._loaded) {
        try {
          this.loader.close();
        }
        catch(error:Error) {
        }
      }
      try {
        this.loader.unload();
      }
      catch(error:Error) {
      }
      this.loader = null;
    }
  }

  public function unload() : void {
    this.clearLoader();
    if(this._loaded) {
      dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
    }
    this.factoryInfo = null;
    this.parentModuleFactory = null;
    this._loaded = false;
    this._setup = false;
    this._ready = false;
    this._error = false;
  }

  public function publish(param1:IFlexModuleFactory) : void {
    if(this.factoryInfo) {
      return;
    }
    if(this._url.indexOf("published://") != 0) {
      return;
    }
    this.factoryInfo = new FactoryInfo();
    this.factoryInfo.factory = param1;
    this._loaded = true;
    this._setup = true;
    this._ready = true;
    this._error = false;
    dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
    dispatchEvent(new ModuleEvent(ModuleEvent.PROGRESS));
    dispatchEvent(new ModuleEvent(ModuleEvent.READY));
  }

  public function addReference() : void {
    ++this.numReferences;
  }

  public function removeReference() : void {
    --this.numReferences;
    if(this.numReferences == 0) {
      this.release();
    }
  }

  public function initHandler(param1:Event) : void {
    var local2:ModuleEvent = null;
    this.factoryInfo = new FactoryInfo();
    try {
      this.factoryInfo.factory = this.loader.content as IFlexModuleFactory;
    }
    catch(error:Error) {
    }
    if(!this.factoryInfo.factory) {
      local2 = new ModuleEvent(ModuleEvent.ERROR,param1.bubbles,param1.cancelable);
      local2.bytesLoaded = 0;
      local2.bytesTotal = 0;
      local2.errorText = "SWF is not a loadable module";
      dispatchEvent(local2);
      return;
    }
    this.loader.content.addEventListener("ready",this.readyHandler);
    this.loader.content.addEventListener("error",this.moduleErrorHandler);
    this.loader.content.addEventListener(Request.GET_PARENT_FLEX_MODULE_FACTORY_REQUEST,this.getFlexModuleFactoryRequestHandler,false,0,true);
    try {
      this.factoryInfo.applicationDomain = this.loader.contentLoaderInfo.applicationDomain;
    }
    catch(error:Error) {
    }
    this._setup = true;
    dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
  }

  public function progressHandler(param1:ProgressEvent) : void {
    var local2:ModuleEvent = new ModuleEvent(ModuleEvent.PROGRESS,param1.bubbles,param1.cancelable);
    local2.bytesLoaded = param1.bytesLoaded;
    local2.bytesTotal = param1.bytesTotal;
    dispatchEvent(local2);
  }

  public function completeHandler(param1:Event) : void {
    var local2:ModuleEvent = new ModuleEvent(ModuleEvent.PROGRESS,param1.bubbles,param1.cancelable);
    local2.bytesLoaded = this.loader.contentLoaderInfo.bytesLoaded;
    local2.bytesTotal = this.loader.contentLoaderInfo.bytesTotal;
    dispatchEvent(local2);
  }

  public function errorHandler(param1:ErrorEvent) : void {
    this._error = true;
    var local2:ModuleEvent = new ModuleEvent(ModuleEvent.ERROR,param1.bubbles,param1.cancelable);
    local2.bytesLoaded = 0;
    local2.bytesTotal = 0;
    local2.errorText = param1.text;
    dispatchEvent(local2);
  }

  public function getFlexModuleFactoryRequestHandler(param1:Request) : void {
    param1.value = this.parentModuleFactory;
  }

  public function readyHandler(param1:Event) : void {
    this._ready = true;
    this.factoryInfo.bytesTotal = this.loader.contentLoaderInfo.bytesTotal;
    var local2:ModuleEvent = new ModuleEvent(ModuleEvent.READY);
    local2.bytesLoaded = this.loader.contentLoaderInfo.bytesLoaded;
    local2.bytesTotal = this.loader.contentLoaderInfo.bytesTotal;
    this.clearLoader();
    dispatchEvent(local2);
  }

  public function moduleErrorHandler(param1:Event) : void {
    var local2:ModuleEvent = null;
    this._ready = true;
    this.factoryInfo.bytesTotal = this.loader.contentLoaderInfo.bytesTotal;
    this.clearLoader();
    if(param1 is ModuleEvent) {
      local2 = ModuleEvent(param1);
    } else {
      local2 = new ModuleEvent(ModuleEvent.ERROR);
    }
    dispatchEvent(local2);
  }
}

class FactoryInfo {
  public var factory:IFlexModuleFactory;
  public var applicationDomain:ApplicationDomain;
  public var bytesTotal:int = 0;

  public function FactoryInfo() {
    super();
  }
}

class ModuleInfoProxy extends EventDispatcher implements IModuleInfo {
  private var info:ModuleInfo;
  private var referenced:Boolean = false;
  private var _data:Object;

  public function ModuleInfoProxy(param1:ModuleInfo) {
    super();
    this.info = param1;
    param1.addEventListener(ModuleEvent.SETUP,this.moduleEventHandler,false,0,true);
    param1.addEventListener(ModuleEvent.PROGRESS,this.moduleEventHandler,false,0,true);
    param1.addEventListener(ModuleEvent.READY,this.moduleEventHandler,false,0,true);
    param1.addEventListener(ModuleEvent.ERROR,this.moduleEventHandler,false,0,true);
    param1.addEventListener(ModuleEvent.UNLOAD,this.moduleEventHandler,false,0,true);
  }

  public function get data() : Object {
    return this._data;
  }

  public function set data(param1:Object) : void {
    this._data = param1;
  }

  public function get error() : Boolean {
    return this.info.error;
  }

  public function get factory() : IFlexModuleFactory {
    return this.info.factory;
  }

  public function get loaded() : Boolean {
    return this.info.loaded;
  }

  public function get ready() : Boolean {
    return this.info.ready;
  }

  public function get setup() : Boolean {
    return this.info.setup;
  }

  public function get url() : String {
    return this.info.url;
  }

  public function publish(param1:IFlexModuleFactory) : void {
    this.info.publish(param1);
  }

  public function load(param1:ApplicationDomain = null, param2:SecurityDomain = null, param3:ByteArray = null, param4:IFlexModuleFactory = null) : void {
    var local5:ModuleEvent = null;
    this.info.resurrect();
    if(!this.referenced) {
      this.info.addReference();
      this.referenced = true;
    }
    if(this.info.error) {
      dispatchEvent(new ModuleEvent(ModuleEvent.ERROR));
    } else if(this.info.loaded) {
      if(this.info.setup) {
        dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
        if(this.info.ready) {
          local5 = new ModuleEvent(ModuleEvent.PROGRESS);
          local5.bytesLoaded = this.info.size;
          local5.bytesTotal = this.info.size;
          dispatchEvent(local5);
          dispatchEvent(new ModuleEvent(ModuleEvent.READY));
        }
      }
    } else {
      this.info.load(param1,param2,param3,param4);
    }
  }

  public function release() : void {
    if(this.referenced) {
      this.info.removeReference();
      this.referenced = false;
    }
  }

  public function unload() : void {
    this.info.unload();
    this.info.removeEventListener(ModuleEvent.SETUP,this.moduleEventHandler);
    this.info.removeEventListener(ModuleEvent.PROGRESS,this.moduleEventHandler);
    this.info.removeEventListener(ModuleEvent.READY,this.moduleEventHandler);
    this.info.removeEventListener(ModuleEvent.ERROR,this.moduleEventHandler);
    this.info.removeEventListener(ModuleEvent.UNLOAD,this.moduleEventHandler);
  }

  private function moduleEventHandler(param1:ModuleEvent) : void {
    dispatchEvent(param1);
  }
}
