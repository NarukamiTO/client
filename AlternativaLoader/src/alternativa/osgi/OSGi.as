package alternativa.osgi {
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.bundle.IBundleDescriptor;
  import alternativa.osgi.catalogs.ServiceInfo;
  import alternativa.osgi.catalogs.ServiceListenersCatalog;
  import alternativa.osgi.catalogs.ServicesCatalog;
  import alternativa.osgi.service.IServiceRegisterListener;
  import alternativa.osgi.service.clientlog.IClientLogBase;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.osgi.service.logging.impl.LogServiceImpl;
  import flash.net.SharedObject;
  import flash.utils.Dictionary;

  public class OSGi {
    public static var clientLog:IClientLogBase;

    private static var instance:OSGi;

    private var bundleDescriptors:Object = {};
    private var services:ServicesCatalog = new ServicesCatalog();
    private var serivceInterface2injectPoints:Dictionary = new Dictionary();
    private var serviceRegisterListenersByInterface:Dictionary = new Dictionary();
    private var logger:Logger;

    public function OSGi() {
      super();
      if(instance == null) {
        instance = this;
        this.initLogging();
        return;
      }
      throw new Error("Only one instance of OSGi class is allowed");
    }

    public static function getInstance() : OSGi {
      if(instance == null) {
        instance = new OSGi();
      }
      return instance;
    }

    public static function paramsToString(param1:Dictionary) : String {
      var local3:* = undefined;
      var local2:String = "";
      for(local3 in param1) {
        local2 += " (" + local3 + " = " + param1[local3] + ")";
      }
      return local2;
    }

    private static function notifyServiceRemovalListeners(param1:Class, param2:Object, param3:Vector.<ListenerInfo>) : void {
      var local4:ListenerInfo = null;
      var local5:Vector.<Object> = null;
      var local6:Object = null;
      for each(local4 in param3) {
        local5 = local4.implementations;
        for each(local6 in local5) {
          if(local6 == param2) {
            local4.listener.serviceUnregistered(param1,param2);
            break;
          }
        }
      }
    }

    private function initLogging() : void {
      var local1:LogServiceImpl = new LogServiceImpl();
      this.logger = local1.getLogger("osgi");
      this.registerService(LogService,local1);
    }

    public function installBundle(param1:IBundleDescriptor) : void {
      var local3:int = 0;
      var local4:IBundleActivator = null;
      if(this.bundleDescriptors[param1.name]) {
        throw new Error("Bundle " + param1.name + " is already installed");
      }
      this.bundleDescriptors[param1.name] = param1;
      var local2:Vector.<IBundleActivator> = param1.activators;
      if(local2 != null) {
        local3 = 0;
        while(local3 < local2.length) {
          local4 = local2[local3];
          local4.start(this);
          local3++;
        }
      }
    }

    public function uninstallBundle(param1:String) : void {
      var local4:int = 0;
      var local5:IBundleActivator = null;
      if(param1 == null) {
        throw new ArgumentError("Bundle name is null");
      }
      var local2:IBundleDescriptor = this.bundleDescriptors[param1];
      if(local2 == null) {
        throw new Error("Bundle " + param1 + " not found");
      }
      var local3:Vector.<IBundleActivator> = local2.activators;
      if(local3 != null) {
        local4 = 0;
        while(local4 < local3.length) {
          local5 = local3[local4];
          local5.stop(this);
          local4++;
        }
      }
      delete this.bundleDescriptors[param1];
    }

    public function registerService(param1:Class, param2:Object, param3:Dictionary = null) : void {
      this.services.addService(param1,param2,param3);
      this.updateInject(param1);
      this.notifyServiceRegistrationListeners(param1,param2);
    }

    private function updateInject(param1:Class) : void {
      var local2:Vector.<InjectPoint> = null;
      var local3:InjectPoint = null;
      if(this.serivceInterface2injectPoints[param1] != null) {
        local2 = this.serivceInterface2injectPoints[param1];
        for each(local3 in local2) {
          local3.injectFunction(this.services.getService(param1,local3.filter));
        }
      }
    }

    private function notifyServiceRegistrationListeners(param1:Class, param2:Object) : void {
      var local5:IServiceRegisterListener = null;
      var local6:Vector.<String> = null;
      var local7:String = null;
      var local8:Object = null;
      var local3:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[param1];
      if(local3 == null) {
        return;
      }
      var local4:Vector.<IServiceRegisterListener> = local3.getListeners();
      if(local4 == null) {
        return;
      }
      for each(local5 in local4) {
        local6 = local3.getFilters(local5);
        for each(local7 in local6) {
          local8 = this.services.getService(param1,local7);
          if(local8 == param2) {
            local5.serviceRegistered(param1,param2);
            break;
          }
        }
      }
    }

    public function registerServiceMulti(param1:Array, param2:Object, param3:Dictionary = null) : void {
      var local4:Class = null;
      for each(local4 in param1) {
        this.registerService(local4,param2,param3);
      }
    }

    public function unregisterService(param1:Class, param2:Dictionary = null) : void {
      var local6:int = 0;
      var local7:InjectPoint = null;
      var local3:Vector.<ListenerInfo> = this.getListenerInfos(param1);
      var local4:Object = this.services.removeService(param1,param2);
      if(local4 == null) {
        return;
      }
      var local5:Vector.<InjectPoint> = this.serivceInterface2injectPoints[param1];
      if(local5 != null) {
        local6 = int(local5.length - 1);
        while(local6 >= 0) {
          local7 = local5[local6];
          if(local7.valueReturnInjectFunction() == local4) {
            local7.injectFunction(null);
          }
          local6--;
        }
      }
      notifyServiceRemovalListeners(param1,local4,local3);
    }

    private function getListenerInfos(param1:Class) : Vector.<ListenerInfo> {
      var local4:Vector.<IServiceRegisterListener> = null;
      var local5:IServiceRegisterListener = null;
      var local6:Vector.<String> = null;
      var local7:ListenerInfo = null;
      var local8:String = null;
      var local9:Object = null;
      var local2:Vector.<ListenerInfo> = new Vector.<ListenerInfo>();
      var local3:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[param1];
      if(local3 != null) {
        local4 = local3.getListeners();
        if(local4 != null) {
          for each(local5 in local4) {
            local6 = local3.getFilters(local5);
            local7 = new ListenerInfo(local5);
            for each(local8 in local6) {
              local9 = this.services.getService(param1,local8);
              if(local9 != null) {
                local7.addService(local9);
              }
            }
            local2.push(local7);
          }
        }
      }
      return local2;
    }

    public function getService(param1:Class, param2:String = "") : * {
      return this.services.getService(param1,param2);
    }

    public function addServiceRegisterListener(param1:Class, param2:IServiceRegisterListener, param3:String = "") : void {
      var local4:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[param1];
      if(local4 == null) {
        local4 = new ServiceListenersCatalog();
        this.serviceRegisterListenersByInterface[param1] = local4;
      }
      local4.addListener(param2,param3);
    }

    public function removeServiceRegisterListener(param1:Class, param2:IServiceRegisterListener, param3:String = "") : void {
      var local4:ServiceListenersCatalog = this.serviceRegisterListenersByInterface[param1];
      if(local4 != null) {
        local4.removeListener(param2,param3);
      }
    }

    public function injectService(param1:Class, param2:Function, param3:Function, param4:String = "") : void {
      if(!this.serivceInterface2injectPoints[param1]) {
        this.serivceInterface2injectPoints[param1] = new Vector.<InjectPoint>();
      }
      this.serivceInterface2injectPoints[param1].push(new InjectPoint(param2,param3,param4));
      var local5:Object = this.services.getService(param1,param4);
      param2(local5);
    }

    public function get bundleList() : Vector.<IBundleDescriptor> {
      var local2:IBundleDescriptor = null;
      var local1:Vector.<IBundleDescriptor> = new Vector.<IBundleDescriptor>();
      for each(local2 in this.bundleDescriptors) {
        local1.push(local2);
      }
      return local1;
    }

    public function get serviceList() : Vector.<Object> {
      return this.services.serviceList;
    }

    public function getServicesInfo() : Vector.<ServiceInfo> {
      return this.services.getServicesInfo();
    }

    public function createSharedObject(param1:String, param2:String = null, param3:Boolean = false) : SharedObject {
      return SharedObject.getLocal(param1,param2,param3);
    }
  }
}

import alternativa.osgi.service.IServiceRegisterListener;
class InjectPoint {
  public var injectFunction:Function;
  public var valueReturnInjectFunction:Function;
  public var filter:String;

  public function InjectPoint(param1:Function, param2:Function, param3:String) {
    super();
    this.injectFunction = param1;
    this.valueReturnInjectFunction = param2;
    this.filter = param3;
  }
}

class ListenerInfo {
  public var listener:IServiceRegisterListener;
  public var implementations:Vector.<Object> = new Vector.<Object>();

  public function ListenerInfo(param1:IServiceRegisterListener) {
    super();
    this.listener = param1;
  }

  public function addService(param1:Object) : void {
    if(this.implementations.indexOf(param1) == -1) {
      this.implementations.push(param1);
    }
  }
}
