package projects.tanks.clients.fp10.TanksLauncher {
  import alternativa.ILauncherListener;
  import alternativa.Launcher;
  import alternativa.launcher.ServerConfigLoader;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.launcherparams.LauncherParams;
  import alternativa.startup.StartupSettings;
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageQuality;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  import flash.external.ExternalInterface;
  import flash.net.SharedObject;
  import projects.tanks.clients.fp10.TanksLauncher.background.Background;
  import projects.tanks.clients.fp10.TanksLauncher.service.LocaleService;
  import projects.tanks.clients.fp10.TanksLauncher.service.StatisticsCollectionService;
  import projects.tanks.clients.fp10.TanksLauncher.service.YandexMetricaService;
  import projects.tanks.clients.tankslauncershared.dishonestprogressbar.DishonestProgressBar;

  public class TanksLauncher extends Sprite implements ILauncherListener {
    public static const LOG_CHANNEL:String = "TanksLauncher";

    private static const LAST_SERVER:String = "LAST_SERVER";
    private static const ENTRANCE_MODEL_OBJECT_LOADED_EVENT:String = "EntranceModel.objectLoaded";
    private static const REGISTRATION_LOAD_START:String = "RegistrationLoad:start";

    private var _debugProgressBar:DebugProgressBar;
    private var _dishonestProgressBar:DishonestProgressBar;
    private var _background:Background;
    private var _statisticsCollectionService:StatisticsCollectionService;
    private var _launcher:Launcher;

    public function TanksLauncher() {
      super();
      if(!StartupSettings.isDesktop) {
        SecuritySettings.apply();
      }
      if(ExternalInterface.available) {
        ExternalInterface.call("gameLaunched");
      }
      addEventListener(Event.ADDED_TO_STAGE,this.init);
    }

    private function init(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.init);
      new IncludedLibrary();
      LocaleService.updateCurrentLocale(loaderInfo.parameters["lang"]);
      this.configureStage();
      this.createBackground();
      this.createDebugProgressBar();
      this.createDishonestProgressBar();
      this.createStatisticsCollectionService();
      this.createLauncher();
      this.startDownload();
    }

    private function configureStage() : void {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.quality = StageQuality.LOW;
      stage.stageFocusRect = false;
      if(StartupSettings.isDesktop) {
        StartupSettings.preLauncher = Sprite(parent.parent);
      }
      mouseEnabled = false;
      tabEnabled = false;
    }

    private function createBackground() : void {
      this._background = new Background();
      stage.addChild(this._background);
    }

    private function createDebugProgressBar() : void {
      this._debugProgressBar = new DebugProgressBar();
      stage.addChild(this._debugProgressBar);
      this._debugProgressBar.align();
      this._debugProgressBar.visible = Boolean(loaderInfo.parameters["debug"]);
    }

    private function createDishonestProgressBar() : void {
      this._dishonestProgressBar = new DishonestProgressBar(LocaleService.currentLocale,this.progressBarFinished);
      stage.addChild(this._dishonestProgressBar);
    }

    private function progressBarFinished() : void {
      this.removeFromStageBackground();
      this.removeFromStageDishonestProgressBar();
      this._statisticsCollectionService.finish();
    }

    private function removeFromStageBackground() : void {
      if(stage.contains(this._background)) {
        stage.removeChild(this._background);
      }
    }

    private function removeFromStageDishonestProgressBar() : void {
      if(stage.contains(this._dishonestProgressBar)) {
        stage.removeChild(this._dishonestProgressBar);
      }
    }

    private function createStatisticsCollectionService() : void {
      this._statisticsCollectionService = new StatisticsCollectionService();
    }

    private function createLauncher() : void {
      var local1:LauncherParams = new LauncherParams(loaderInfo,true);
      this.patchConfigUrl(local1);
      this._launcher = new Launcher(this,local1,this);
    }

    private function patchConfigUrl(param1:LauncherParams) : void {
      var local3:String = null;
      var local4:RegExp = null;
      var local2:int = this.getAndResetLastServerNumber();
      if(local2 != -1) {
        local3 = param1.getParameter(ServerConfigLoader.PARAM_CONFIG_URL);
        local4 = /([a-z]{1,5})[1-9][0-9]{0,8}\./g;
        local3 = local3.replace(local4,"$1__" + local2 + ".").replace("__","");
        param1.setParameter(ServerConfigLoader.PARAM_CONFIG_URL,local3);
      }
    }

    private function getAndResetLastServerNumber() : int {
      var local1:SharedObject = SharedObject.getLocal("launcherStorage");
      var local2:Object = !!local1.data.hasOwnProperty(LAST_SERVER) ? local1.data[LAST_SERVER] : null;
      if(local2 != null) {
        delete local1.data[LAST_SERVER];
      }
      return local2 == null ? -1 : int(local2);
    }

    private function startDownload() : void {
      stage.addEventListener(ENTRANCE_MODEL_OBJECT_LOADED_EVENT,this.onEntranceModelObjectLoaded);
      YandexMetricaService.reachGoalIfPlayerWasInTutorial(REGISTRATION_LOAD_START);
      this._launcher.start();
      this._dishonestProgressBar.start();
      this._statisticsCollectionService.start();
    }

    private function onEntranceModelObjectLoaded(param1:Event) : void {
      stage.removeEventListener(ENTRANCE_MODEL_OBJECT_LOADED_EVENT,this.onEntranceModelObjectLoaded);
      this._dishonestProgressBar.forciblyFinish();
    }

    public function onConfigLoadingStart() : void {
      this._debugProgressBar.text = "Config: ";
    }

    public function onConfigLoadingComplete() : void {
      this._debugProgressBar.text = null;
    }

    public function onConfigLoadingProgress(param1:uint, param2:uint) : void {
      this._debugProgressBar.setProgress(param1,param2);
    }

    public function onLibrariesLoadingStart() : void {
      this._debugProgressBar.text = "Base libs: ";
    }

    public function onLibrariesLoadingComplete(param1:ILauncherParams, param2:Function) : void {
      var params:ILauncherParams = param1;
      var callback:Function = param2;
      var osgi:OSGi = OSGi.getInstance();
      new (Launcher.findClass("alternativa.protocol.osgi.ProtocolActivator"))().start(osgi);
      new (Launcher.findClass("platform.clients.fp10.libraries.alternativaprotocolflash.Activator"))().start(osgi);
      new (Launcher.findClass("platform.client.core.general.resourcelocale.osgi.Activator"))().start(osgi);
      this.loadLocalization(params,function():void {
        _debugProgressBar.text = null;
        _debugProgressBar.parent.removeChild(_debugProgressBar);
        _debugProgressBar = null;
        callback();
      });
    }

    private function loadLocalization(param1:ILauncherParams, param2:Function) : void {
      var local3:Class = Launcher.findClass("platform.client.fp10.core.resource.types.LocalizationLoader");
      var local4:* = new local3(param1);
      local4.load(param2);
    }

    public function onConfigLoadingError(param1:String) : void {
      this.handleLoadingError("Server configuration loading error: " + param1,SmartErrorHandler.NOTAVAILABLE_ERROR);
    }

    public function onLibraryLoadingError(param1:String) : void {
      this.handleLoadingError("Library loading error: " + param1,SmartErrorHandler.NOTAVAILABLE_ERROR);
    }

    public function onServerUnavailable() : void {
      this.handleLoadingError("Server is unavailable",SmartErrorHandler.NOTAVAILABLE_ERROR);
    }

    public function onServerOverloaded() : void {
      this.handleLoadingError("Server is overloaded",SmartErrorHandler.OVERLOADED_ERROR);
    }

    public function onLibrariesInitialized() : void {
    }

    private function handleLoadingError(param1:String, param2:String) : void {
      var local3:SmartErrorHandler = new SmartErrorHandler(param1,param2);
      stage.addChild(local3);
      local3.handleLoadingError();
      this._dishonestProgressBar.stop();
      this.removeFromStageDishonestProgressBar();
      this._statisticsCollectionService.handleLoadingError(param1);
    }
  }
}
