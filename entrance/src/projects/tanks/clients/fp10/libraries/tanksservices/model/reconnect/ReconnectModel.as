package projects.tanks.clients.fp10.libraries.tanksservices.model.reconnect {
  import alternativa.launcher.ServerConfigLoader;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.startup.ConnectionParameters;
  import flash.events.Event;
  import mx.utils.StringUtil;
  import platform.client.fp10.core.logging.serverlog.ServerLogTarget;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.connection.ControlConnectionSender;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.tanksservices.model.reconnect.IReconnectModelBase;
  import projects.tanks.client.tanksservices.model.reconnect.ReconnectCC;
  import projects.tanks.client.tanksservices.model.reconnect.ReconnectModelBase;
  import projects.tanks.client.tanksservices.model.reconnect.RemoteEndpointData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.gpu.GPUDetector;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.events.TanksAddressEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerServiceImpl;

  [ModelInfo]
  public class ReconnectModel extends ReconnectModelBase implements IReconnectModelBase, ReconnectService, ObjectLoadListener, ObjectUnloadListener, ReconnectCallback {
    [Inject]
    public static var launcherParams:ILauncherParams;

    [Inject]
    public static var addressService:TanksAddressService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var logService:LogService;

    private static const LOG_CHANNEL:String = "reconnect";

    private var configUrlTemplate:String;
    private var configURL:String;
    private var serviceObject:IGameObject;
    private var singleHash:String;
    private var config:ReconnectCC;
    private var logger:Logger;

    public function ReconnectModel() {
      super();
      logService.addLogTarget(new ServerLogTarget(new ControlConnectionSender(),LOG_CHANNEL + ":e"));
      this.logger = logService.getLogger(LOG_CHANNEL);
    }

    public function objectLoaded() : void {
      addressService.addEventListener(TanksAddressEvent.TRY_CHANGE_SERVER,this.onTryChangeServer);
      this.config = getInitParam();
      this.serviceObject = object;
      this.configUrlTemplate = this.config.configUrlTemplate;
      var local1:OSGi = OSGi.getInstance();
      local1.registerService(ServerNumberToLocaleServerService,new ServerNumberToLocaleServerServiceImpl());
      local1.registerService(ReconnectService,this);
      addressService.init(this.config.serverNumber);
      this.runDetectGPUCapabilities();
    }

    public function objectUnloaded() : void {
      var local1:OSGi = OSGi.getInstance();
      local1.unregisterService(ReconnectService);
      local1.unregisterService(ServerNumberToLocaleServerService);
    }

    private function onTryChangeServer(param1:Event) : void {
      this.tryToChangeServer(addressService.getServerNumber());
    }

    public function getCurrentServerNumber() : int {
      return this.config.serverNumber;
    }

    private function runDetectGPUCapabilities() : void {
      GPUDetector(object.adapt(GPUDetector)).detectGPUCapabilities();
    }

    private function tryToChangeServer(param1:int) : void {
      this.reconnect(this.getConfigUrl(param1));
    }

    private function reconnect(param1:String) : void {
      this.configURL = param1;
      this.singleHash = null;
      Model.object = this.serviceObject;
      server.wantToReconnect();
      Model.popObject();
    }

    public function onReconnectStarted() : void {
      if(Boolean(this.singleHash)) {
        launcherParams.setParameter("singleUseHash",this.singleHash);
      }
      addressService.dispatchEvent(new TanksAddressEvent(TanksAddressEvent.SERVER_CHANGED));
    }

    public function onReconnectCancel() : void {
      addressService.back();
    }

    public function onReconnectError() : void {
      addressService.back();
      alertService.showOkAlert(localeService.getText(TanksLocale.TEXT_SELECTED_SERVER_UNAVAILABLE));
      this.logger.error("Reconnect error: " + this.configURL);
    }

    public function setSingleEntranceHash(param1:String) : void {
      this.singleHash = param1;
    }

    public function serverReadyToReconnect() : void {
      new ReconnectLauncher(this.configURL,this).start();
    }

    private function getConfigUrl(param1:int) : String {
      return StringUtil.substitute(this.configUrlTemplate,param1);
    }

    public function reconnectFast(param1:RemoteEndpointData) : void {
      var local2:ConnectionParameters = new ConnectionParameters(param1.host,param1.ports.slice(),ServerConfigLoader.resourcesRootURL,false);
      new ReconnectLauncher("dummyUrl",this).startWithParams(local2);
    }
  }
}
