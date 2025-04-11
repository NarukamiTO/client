package projects.tanks.clients.fp10.libraries.tanksservices.model.reconnect {
  import alternativa.launcher.ServerConfigLoader;
  import alternativa.launcher.ServerConfigLoaderListener;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.launcherparams.LauncherParams;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.osgi.service.network.NetworkService;
  import alternativa.protocol.IProtocol;
  import alternativa.startup.ConnectionParameters;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.types.Long;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.connection.ConnectionConnectParameters;
  import platform.client.fp10.core.network.connection.ConnectionInitializers;
  import platform.client.fp10.core.network.connection.IConnection;
  import platform.client.fp10.core.network.connection.protection.PrimitiveProtectionContext;
  import platform.client.fp10.core.protocol.codec.ControlRootCodec;
  import platform.client.fp10.core.service.transport.ITransportService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.LobbyLayoutServiceBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.LobbyLayoutServiceEvents;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;

  public class ReconnectLauncher implements ServerConfigLoaderListener {
    [Inject]
    public static var protocol:IProtocol;

    [Inject]
    public static var transportService:ITransportService;

    [Inject]
    public static var networkService:INetworkService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var lobbyLayoutService:LobbyLayoutServiceBase;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var launcherParams:ILauncherParams;

    [Inject]
    public static var dispatcherService:IDialogWindowsDispatcherService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    private var callback:ReconnectCallback;
    private var connectionParameters:ConnectionParameters;
    private var configLoader:ServerConfigLoader;

    public function ReconnectLauncher(param1:String, param2:ReconnectCallback) {
      super();
      this.callback = param2;
      launcherParams.setParameter(ServerConfigLoader.PARAM_CONFIG_URL,param1);
      this.configLoader = new ServerConfigLoader(LauncherParams(launcherParams),this);
    }

    public function onServerConfigLoadingComplete() : void {
      this.hideLobbyLoader();
    }

    public function onServerConfigLoadingStart() : void {
    }

    public function onServerConfigLoadingProgress(param1:uint, param2:uint) : void {
    }

    public function onServerUnavailable() : void {
      this.onCanNotConnectToServer();
    }

    public function onServerOverloaded() : void {
      this.onCanNotConnectToServer();
    }

    public function onServerConfigLoadingError(param1:String) : void {
      this.onCanNotConnectToServer();
    }

    public function log(param1:String) : void {
    }

    public function start() : void {
      this.configLoader.loadServerConfiguration();
      this.showLobbyLoader();
    }

    public function startWithParams(param1:ConnectionParameters) : void {
      this.connectionParameters = param1;
      this.startReconnect();
    }

    public function onServerConfigParsed(param1:ConnectionParameters) : void {
      this.connectionParameters = param1;
      if(Boolean(lobbyLayoutService.inBattle()) && !battleInfoService.isSpectatorMode() && Boolean(battleInfoService.running)) {
        this.showExitFromBattleAlert();
      } else {
        this.startReconnect();
      }
    }

    private function showExitFromBattleAlert() : void {
      var local1:String = this.getTextForExitFromBattleAlert();
      var local2:Array = [localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES),localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_NO)];
      alertService.showAlert(local1,Vector.<String>(local2));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleDialogButtonPressed);
    }

    private function getTextForExitFromBattleAlert() : String {
      var local1:Boolean = Boolean(battleInfoService.hasCurrentSelectionBattleId()) && !battleInfoService.isAvailableSelectionBattle();
      var local2:String = local1 ? TanksLocale.TEXT_ALERT_GO_TO_BATTLE_IS_UNAVAILABLE_RANK_FUND : TanksLocale.TEXT_FRIENDS_EXIT_FROM_BATTLE_ALERT;
      if(!userInfoService.isOffer()) {
        return localeService.getText(local2);
      }
      return localeService.getText(local2) + "\n" + localeService.getText(TanksLocale.TEXT_POSTFIX_OFFER_EXIT_BATTLE);
    }

    private function onQuitBattleDialogButtonPressed(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onQuitBattleDialogButtonPressed);
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES)) {
        lobbyLayoutService.exitFromBattleWithoutNotify();
        lobbyLayoutService.addEventListener(LobbyLayoutServiceEvents.END_LAYOUT_SWITCH,this.onEndLayout);
      } else {
        this.hideLobbyLoader();
        this.callback.onReconnectCancel();
      }
    }

    private function onEndLayout(param1:Event) : void {
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvents.END_LAYOUT_SWITCH,this.onEndLayout);
      setTimeout(this.startReconnect,0);
    }

    private function startReconnect() : void {
      this.callback.onReconnectStarted();
      var local1:IConnection = transportService.controlConnection;
      local1.close(ConnectionCloseStatus.CLOSED_BY_CLIENT);
      var local2:OSGi = OSGi.getInstance();
      local2.unregisterService(INetworkService);
      local2.registerService(INetworkService,new NetworkService(this.connectionParameters));
      var local3:IConnection = this.createConnection();
      var local4:ConnectionConnectParameters = new ConnectionConnectParameters(this.connectionParameters.serverAddress,this.connectionParameters.serverPorts);
      local3.connect(local4);
    }

    private function createConnection() : IConnection {
      var local1:ConnectionInitializers = new ConnectionInitializers(protocol,new ControlRootCodec(),transportService.controlCommandHandler,networkService.secure,Long.ZERO,PrimitiveProtectionContext.INSTANCE);
      return transportService.createConnection(local1);
    }

    private function onCanNotConnectToServer() : void {
      this.hideLobbyLoader();
      this.callback.onReconnectError();
    }

    private function showLobbyLoader() : void {
      loaderWindowService.show();
      dispatcherService.open();
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,KeyUpListenerPriority.CHANGE_SERVER);
    }

    private function hideLobbyLoader() : void {
      display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      modalLoaderService.hideForcibly();
      loaderWindowService.hideForcibly();
      dispatcherService.close();
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      param1.stopImmediatePropagation();
    }
  }
}
