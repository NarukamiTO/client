package alternativa.osgi.catalogs {
  import alternativa.osgi.ServiceParamNames;
  import flash.utils.Dictionary;

  public class ServicesCatalog {
    protected var _namedServicesDictionary:Dictionary;
    protected var _nullParamsServiceDictionary:Dictionary;

    public function ServicesCatalog() {
      super();
      this._namedServicesDictionary = new Dictionary();
      this._nullParamsServiceDictionary = new Dictionary();
    }

    public function getService(param1:Class, param2:String) : Object {
      var local3:String = null;
      var local4:NamedServicesCatalog = null;
      if(param2) {
        local3 = this.getNameByFilter(param2);
        if(local3 != null) {
          local4 = this._namedServicesDictionary[param1];
          if(local4 != null) {
            return local4.getService(local3);
          }
        }
        return null;
      }
      return this._nullParamsServiceDictionary[param1];
    }

    public function getNameByFilter(param1:String) : String {
      var local4:String = null;
      if(param1 == null) {
        return null;
      }
      var local2:RegExp = / /gi;
      param1 = param1.replace(local2,"");
      var local3:int = int(param1.indexOf("name="));
      if(local3 != -1) {
        local4 = param1.substr(local3 + 5,param1.length - local3 - 5);
        local3 = int(local4.indexOf(")"));
        if(local3 != -1) {
          return local4.substr(0,local3);
        }
        return local4;
      }
      return null;
    }

    public function addService(param1:Class, param2:Object, param3:Dictionary) : void {
      var local4:String = null;
      var local5:NamedServicesCatalog = null;
      if(param3 == null) {
        if(this._nullParamsServiceDictionary[param1] != null) {
          throw new ArgumentError("Service " + param1 + " without parameters is already registered");
        }
        this._nullParamsServiceDictionary[param1] = param2;
      } else {
        local4 = param3[ServiceParamNames.PARAM_NAME];
        if(local4 == null) {
          throw new ArgumentError("Invalid params. You can only use the parameter \'name\'");
        }
        local5 = this._namedServicesDictionary[param1];
        if(local5 == null) {
          local5 = new NamedServicesCatalog(param1);
          this._namedServicesDictionary[param1] = local5;
        }
        local5.addService(local4,param2);
      }
    }

    public function removeService(param1:Class, param2:Dictionary) : Object {
      var local3:String = null;
      var local4:NamedServicesCatalog = null;
      var local5:Object = null;
      if(param2 != null) {
        local3 = param2[ServiceParamNames.PARAM_NAME];
        if(local3 != null) {
          local4 = this._namedServicesDictionary[param1];
          if(local4 != null) {
            return local4.removeService(local3);
          }
        }
        return null;
      }
      local5 = this._nullParamsServiceDictionary[param1];
      delete this._nullParamsServiceDictionary[param1];
      return local5;
    }

    public function get serviceList() : Vector.<Object> {
      var local2:Object = null;
      var local3:NamedServicesCatalog = null;
      var local4:Vector.<Object> = null;
      var local5:int = 0;
      var local6:int = 0;
      var local1:Vector.<Object> = new Vector.<Object>();
      for each(local2 in this._nullParamsServiceDictionary) {
        local1.push(local2);
      }
      for each(local3 in this._namedServicesDictionary) {
        local4 = local3.serviceList;
        local5 = 0;
        local6 = int(local4.length);
        while(local5 < local6) {
          local2 = local4[local5];
          if(local1.indexOf(local2) == -1) {
            local1.push(local2);
          }
          local5++;
        }
      }
      return local1;
    }

    public function getServicesInfo() : Vector.<ServiceInfo> {
      var local2:Object = null;
      var local3:NamedServicesCatalog = null;
      var local4:Vector.<ServiceInfo> = null;
      var local5:int = 0;
      var local6:int = 0;
      var local1:Vector.<ServiceInfo> = new Vector.<ServiceInfo>();
      for each(local2 in this._nullParamsServiceDictionary) {
        local1.push(new ServiceInfo(local2,null));
      }
      for each(local3 in this._namedServicesDictionary) {
        local4 = local3.getServicesInfo();
        local5 = 0;
        local6 = int(local4.length);
        while(local5 < local6) {
          local1.push(local4[local5]);
          local5++;
        }
      }
      return local1;
    }
  }
}
