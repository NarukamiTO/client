package alternativa.osgi.catalogs {
  import alternativa.osgi.ServiceParamNames;
  import flash.utils.Dictionary;

  public class NamedServicesCatalog {
    protected var namesDictionary:Dictionary;

    private var serviceInterface:Class;

    public function NamedServicesCatalog(param1:Class) {
      super();
      this.serviceInterface = param1;
      this.namesDictionary = new Dictionary();
    }

    public function getService(param1:String) : Object {
      if(param1 == null) {
        throw new ArgumentError("name can\'t be null");
      }
      return this.namesDictionary[param1];
    }

    public function addService(param1:String, param2:Object) : void {
      var local3:Object = null;
      if(param1 == null) {
        throw new ArgumentError("name can\'t be null");
      }
      local3 = this.namesDictionary[param1];
      if(local3 != null && local3 != param2) {
        throw new ArgumentError("Service " + this.serviceInterface + "with name \'" + param1 + "\' is already registered");
      }
      this.namesDictionary[param1] = param2;
    }

    public function removeService(param1:String) : Object {
      var local2:Object = null;
      if(param1 == null) {
        throw new ArgumentError("name can\'t be null");
      }
      local2 = this.namesDictionary[param1];
      delete this.namesDictionary[param1];
      return local2;
    }

    public function get serviceList() : Vector.<Object> {
      var local2:Object = null;
      var local1:Vector.<Object> = new Vector.<Object>();
      for each(local2 in this.namesDictionary) {
        local1.push(local2);
      }
      return local1;
    }

    public function getServicesInfo() : Vector.<ServiceInfo> {
      var local2:* = undefined;
      var local1:Vector.<ServiceInfo> = new Vector.<ServiceInfo>();
      for(local2 in this.namesDictionary) {
        local1.push(new ServiceInfo(this.namesDictionary[local2],Vector.<ServiceParam>([new ServiceParam(ServiceParamNames.PARAM_NAME,local2)])));
      }
      return local1;
    }
  }
}
