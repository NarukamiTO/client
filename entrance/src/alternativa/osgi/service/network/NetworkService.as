package alternativa.osgi.service.network {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.startup.ConnectionParameters;
  import flash.net.SharedObject;

  public class NetworkService implements INetworkService {
    private static const SHARED_OBJECT_NAME:String = "connection";

    private var logService:LogService;
    private var _controlServerAddress:String;
    private var _controlServerPorts:Vector.<int>;
    private var _resourcesRootUrl:String;
    private var _secure:Boolean;

    public function NetworkService(param1:ConnectionParameters) {
      super();
      this._controlServerAddress = param1.serverAddress;
      this._controlServerPorts = param1.serverPorts;
      this._resourcesRootUrl = param1.resourcesRootURL;
      this._secure = param1.secure;
      this.logService = LogService(OSGi.getInstance().getService(LogService));
    }

    public function get controlServerAddress() : String {
      return this._controlServerAddress;
    }

    public function get secure() : Boolean {
      return this._secure;
    }

    public function get controlServerPorts() : Vector.<int> {
      return this._controlServerPorts;
    }

    public function get resourcesRootUrl() : String {
      return this._resourcesRootUrl;
    }

    public function getLastPort(param1:String) : int {
      var local2:SharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
      return local2.data[param1];
    }

    public function saveLastPort(param1:String, param2:int) : void {
      var so:SharedObject = null;
      var host:String = param1;
      var port:int = param2;
      try {
        so = SharedObject.getLocal(SHARED_OBJECT_NAME,"/");
        so.data[host] = port;
        so.flush();
      }
      catch(e:Error) {
        logService.getLogger("NetworkServer").warning("Error stored port in shared object, message = %1",[e]);
      }
    }
  }
}
