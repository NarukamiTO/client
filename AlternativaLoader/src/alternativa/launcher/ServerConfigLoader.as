package alternativa.launcher {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.launcherparams.LauncherParams;
  import alternativa.osgi.service.serverlog.ServerLoggingService;
  import alternativa.startup.ConnectionParameters;
  import alternativa.types.URL;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.utils.clearInterval;
  import flash.utils.setTimeout;

  public class ServerConfigLoader {
    public static var resourcesRootURL:String;

    public static const PARAM_CONFIG_URL:String = "config";

    private const LOAD_CONFIG_ATTEMPT_COUNT:int = 3;
    private const SERVER_STATUS_OVERLOADED:String = "overloaded";
    private const SERVER_STATUS_UNAVAILABLE:String = "unavailable";
    private const PARAM_RESOURCES_ROOT_URL:String = "resources";
    private const RESOURCES_ROOT:String = "resources";

    private var configLoader:URLLoader;
    private var listener:ServerConfigLoaderListener;
    private var params:LauncherParams;
    private var configURL:String;
    private var loadConfigAttempt:int = 1;
    private var retryLoadConfigTimeoutId:int = -1;

    public function ServerConfigLoader(param1:LauncherParams, param2:ServerConfigLoaderListener) {
      super();
      this.params = param1;
      this.listener = param2;
    }

    public function loadServerConfiguration() : void {
      var local1:URL = new URL(this.params.urlLoader,this.params.isStrictUseHttp());
      this.configURL = this.params.getParameter(PARAM_CONFIG_URL);
      if(this.configURL.indexOf("://") == -1) {
        this.configURL = local1.scheme + "://" + this.configURL;
      }
      this.log(this.configURL);
      resourcesRootURL = this.makeResourcesRootURL(local1);
      this.startLoadServerConfigurationWithNotify();
    }

    private function startLoadServerConfigurationWithNotify() : void {
      this.loadConfigAttempt = 1;
      this.startLoadServerConfiguration();
      this.listener.onServerConfigLoadingStart();
    }

    private function startLoadServerConfiguration() : void {
      this.configLoader = new URLLoader();
      this.configLoader.addEventListener(Event.COMPLETE,this.onServerConfigLoadingComplete);
      this.configLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onServerConfigLoadingError);
      this.configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onServerConfigLoadingError);
      this.configLoader.addEventListener(ProgressEvent.PROGRESS,this.onServerConfigLoadingProgress);
      this.configLoader.load(new URLRequest(this.configURL + "?rnd=" + Math.random()));
    }

    private function stopLoadServerConfiguration() : void {
      this.configLoader.close();
      this.configLoader.removeEventListener(Event.COMPLETE,this.onServerConfigLoadingComplete);
      this.configLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onServerConfigLoadingError);
      this.configLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onServerConfigLoadingError);
      this.configLoader.removeEventListener(ProgressEvent.PROGRESS,this.onServerConfigLoadingProgress);
      this.configLoader = null;
    }

    private function onServerConfigLoadingProgress(param1:ProgressEvent) : void {
      this.listener.onServerConfigLoadingProgress(param1.bytesLoaded,param1.bytesTotal);
    }

    private function onServerConfigLoadingComplete(param1:Event) : void {
      this.clearReloadInterval();
      this.listener.onServerConfigLoadingComplete();
      var local2:XML = XML(this.configLoader.data);
      this.configLoader = null;
      var local3:Namespace = local2.namespace();
      var local4:String = local2.local3::status.toString();
      switch(local4) {
        case this.SERVER_STATUS_OVERLOADED:
          this.listener.onServerOverloaded();
          return;
        case this.SERVER_STATUS_UNAVAILABLE:
          this.listener.onServerUnavailable();
          return;
        default:
          this.initConnectionParams(local2);
          return;
      }
    }

    private function onServerConfigLoadingError(param1:ErrorEvent) : void {
      this.logLoadingErrorToServer(param1);
      this.clearReloadInterval();
      if(this.loadConfigAttempt >= this.LOAD_CONFIG_ATTEMPT_COUNT) {
        this.listener.onServerConfigLoadingError(param1.text);
      } else {
        this.stopLoadServerConfiguration();
        this.retryLoadConfigTimeoutId = setTimeout(this.reloadConfig,Math.random() * 1000 + 1000);
      }
    }

    private function clearReloadInterval() : void {
      if(this.retryLoadConfigTimeoutId != -1) {
        clearInterval(this.retryLoadConfigTimeoutId);
      }
    }

    private function reloadConfig() : void {
      ++this.loadConfigAttempt;
      this.startLoadServerConfiguration();
    }

    private function initConnectionParams(param1:XML) : void {
      var local5:XML = null;
      var local6:* = false;
      var local7:ConnectionParameters = null;
      var local2:Namespace = param1.namespace();
      var local3:String = param1.local2::server.@address;
      this.log("Server address: " + local3);
      var local4:Vector.<int> = new Vector.<int>();
      for each(local5 in param1.local2::server.local2::ports.local2::port) {
        local4.push(int(local5));
      }
      this.log("Ports: " + local4.join(", "));
      local6 = "secure" == param1.local2::server.@mode;
      local7 = new ConnectionParameters(local3,local4,resourcesRootURL,local6);
      this.listener.onServerConfigParsed(local7);
    }

    private function makeResourcesRootURL(param1:URL) : String {
      var local3:String = null;
      var local2:* = this.params.getParameter(this.PARAM_RESOURCES_ROOT_URL);
      if(local2 == null || local2.length == 0) {
        local3 = param1.path.substring(0,param1.path.lastIndexOf("/") + 1);
        local2 = local3 + this.RESOURCES_ROOT;
        return param1.getRoot() + local2 + "/";
      }
      if(local2.indexOf("http") == -1) {
        local2 = param1.scheme + "://" + local2;
      }
      if(local2.lastIndexOf("/") != local2.length - 1) {
        local2 += "/";
      }
      return local2;
    }

    private function log(param1:String) : void {
      this.listener.log("Loading server configuration from " + param1);
    }

    private function logLoadingErrorToServer(param1:ErrorEvent) : void {
      ServerLoggingService(OSGi.getInstance().getService(ServerLoggingService)).sendDataToServer(this.getGelfString(param1.errorID.toString()));
    }

    private function getGelfString(param1:String) : String {
      return "{\"short_message\":\"Config loading error\", \"host\":\"client_errors\",\"_configUrl\":\"" + this.configURL + "\", \"_error_id\":\"" + param1 + "\"}";
    }
  }
}
