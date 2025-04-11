package projects.tanks.clients.fp10.Prelauncher {
  import flash.desktop.NativeApplication;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.NativeWindow;
  import flash.display.NativeWindowInitOptions;
  import flash.display.Screen;
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageDisplayState;
  import flash.display.StageQuality;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.MouseEvent;
  import flash.events.NativeWindowBoundsEvent;
  import flash.events.NativeWindowDisplayStateEvent;
  import flash.events.SecurityErrorEvent;
  import flash.filesystem.File;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.utils.ByteArray;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import projects.tanks.clients.fp10.Prelauncher.controls.LocalizedControl;
  import projects.tanks.clients.fp10.Prelauncher.controls.background.Background;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.BottomPanel;
  import projects.tanks.clients.fp10.Prelauncher.controls.buttons.ExitButton;
  import projects.tanks.clients.fp10.Prelauncher.controls.buttons.StartButton;
  import projects.tanks.clients.fp10.Prelauncher.controls.logo.Logo;
  import projects.tanks.clients.fp10.Prelauncher.controls.selector.LocaleSelectionEvent;
  import projects.tanks.clients.fp10.Prelauncher.controls.selector.LocalizationSelector;
  import projects.tanks.clients.fp10.Prelauncher.controls.toppanel.TopPanel;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.serverslist.ServerNode;
  import projects.tanks.clients.fp10.Prelauncher.serverslist.ServersListEvent;
  import projects.tanks.clients.fp10.Prelauncher.serverslist.ServersListLoader;
  import projects.tanks.clients.fp10.Prelauncher.steam.SteamRenderer;
  import projects.tanks.clients.fp10.Prelauncher.storage.DisplayState;
  import projects.tanks.clients.fp10.Prelauncher.storage.Storage;

  [SWF(width="1000",height="600",backgroundColor="#000000",frameRate="40")]
  public class Prelauncher extends Sprite {
    private var guiLayer:Sprite;
    private var tanksLauncherLoader:Loader;
    private var selector:LocalizationSelector;
    private var steamRenderer:SteamRenderer = new SteamRenderer();
    private var airParameters:Object;

    protected var swf:String;
    protected var defaultLocale:Locale;
    protected var canChangeLocale:Boolean = true;
    protected var resources:String;
    protected var serverPrefix:String;
    protected var balancerUrl:String;
    protected var configUrl:String;

    public var displayStateTimeout:int = 0;

    private var battleServer:int;
    private var window:NativeWindow;

    public function Prelauncher() {
      super();
      this.defaultLocale = LocalesFactory.getLocale(loaderInfo.parameters["lang"] || Locales.RU);
      this.swf = loaderInfo.parameters["swf"] || "http://tankionline.com/AlternativaLoader.swf";
      this.configUrl = loaderInfo.parameters["config"] || "cNUMBER.eu.tankionline.com/config.xml";
      this.resources = loaderInfo.parameters["resources"] || "s.eu.tankionline.com";
      this.balancerUrl = loaderInfo.parameters["balancer"] || "http://tankionline.com/s/status.js";
      this.serverPrefix = loaderInfo.parameters["prefix"] || "main.c";
      this.canChangeLocale = loaderInfo.parameters["lang"] != Locales.CN;
      addEventListener(Event.ADDED_TO_STAGE,this.init);
    }

    private static function exitPressed(e:MouseEvent) : void {
      NativeApplication.nativeApplication.exit();
    }

    private static function serverNodeByNumber(serversList:Vector.<ServerNode>, number:int) : ServerNode {
      var node:ServerNode = null;
      for each(node in serversList) {
        if(node.serverNumber == number) {
          return node;
        }
      }
      return null;
    }

    private static function getMinElement(serversList:Vector.<ServerNode>) : ServerNode {
      var node:ServerNode = null;
      var server:ServerNode = serversList[0];
      for each(node in serversList) {
        if(server.usersOnline > node.usersOnline) {
          server = node;
        }
      }
      return server;
    }

    private static function pointIsVisibleOnScreens(point:Point, screens:Array) : Boolean {
      var screen:Screen = null;
      for each(screen in screens) {
        if(point.x + 100 < screen.bounds.x + screen.bounds.width && point.y + 100 < screen.bounds.y + screen.bounds.height) {
          return true;
        }
      }
      return false;
    }

    private function init(e:Event = null) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.init);
      stage.addEventListener(MouseEvent.CLICK,this.mouseClick);
      Locale.current = Storage.getLastSessionLocale(this.defaultLocale);
      this.configureStage();
      this.createGUI();
      if(this.isSteamClient()) {
        this.addSteamRenderer();
      }
      this.battleServer = Storage.getLastBattleServer();
      if(this.battleServer != -1 && this.configUrl.indexOf("NUMBER") >= 0) {
        this.configUrl = this.configUrl.replace("NUMBER",this.battleServer);
      }
    }

    private function addSteamRenderer() : void {
      this.guiLayer.addChild(this.steamRenderer);
    }

    private function setCenterPosition() : void {
      var appBounds:Rectangle = stage.nativeWindow.bounds;
      var screen:Screen = Screen.getScreensForRectangle(appBounds)[0];
      stage.stageWidth = 1000;
      stage.stageHeight = 600;
      stage.nativeWindow.maxSize = new Point(stage.nativeWindow.width,stage.nativeWindow.height);
      stage.nativeWindow.minSize = new Point(stage.nativeWindow.width,stage.nativeWindow.height);
      stage.nativeWindow.x = (screen.bounds.width - stage.nativeWindow.width) / 2;
      stage.nativeWindow.y = (screen.bounds.height - stage.nativeWindow.height) / 2;
    }

    private function configureStage() : void {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.quality = StageQuality.BEST;
      stage.displayState = StageDisplayState.NORMAL;
      stage.stageWidth = 1000;
      stage.stageHeight = 600;
      this.setCenterPosition();
    }

    private function createGUI() : void {
      this.guiLayer = new Sprite();
      var start:StartButton = new StartButton(this.startPressed);
      var exit:ExitButton = new ExitButton(exitPressed);
      var logo:Logo = new Logo();
      var background:Background = new Background();
      var topLine:TopPanel = new TopPanel();
      var bottomPanel:BottomPanel = new BottomPanel();
      this.selector = new LocalizationSelector();
      this.guiLayer.addEventListener(LocaleSelectionEvent.SELECTION,this.switchLocale,false,0,true);
      this.guiLayer.addChild(background);
      this.guiLayer.addChild(logo);
      this.guiLayer.addChild(exit);
      this.guiLayer.addChild(start);
      this.guiLayer.addChild(topLine);
      this.guiLayer.addChild(bottomPanel);
      addChild(this.guiLayer);
      if(this.canChangeLocale) {
        topLine.addAlignRight(this.selector);
      }
      var ev:LocaleSelectionEvent = new LocaleSelectionEvent(LocaleSelectionEvent.SELECTION,false,false);
      ev.locale = Locale.current;
      this.switchLocale(ev);
    }

    private function switchLocale(e:LocaleSelectionEvent) : void {
      var child:DisplayObject = null;
      Locale.current = e.locale;
      for(var i:int = 0; i < this.guiLayer.numChildren; i++) {
        child = this.guiLayer.getChildAt(i);
        if(child is LocalizedControl) {
          (child as LocalizedControl).switchLocale(e.locale);
        }
      }
    }

    public function get version() : String {
      return "1.0";
    }

    private function startPressed(e:MouseEvent = null) : void {
      stage.nativeWindow.visible = false;
      Storage.lastSessionLocale = Locales.list.indexOf(Locale.current.name);
      var serversListLoader:ServersListLoader = new ServersListLoader(this.balancerUrl,this.serverPrefix);
      serversListLoader.addEventListener(ServersListEvent.ERROR,this.onBalancerConnectError,false,0,true);
      serversListLoader.addEventListener(ServersListEvent.LOADED,this.onServersListLoaded,false,0,true);
      serversListLoader.loadServersList();
    }

    private function onServersListLoaded(e:ServersListEvent) : void {
      var storedServerNode:ServerNode = null;
      var recommendedServerNode:ServerNode = null;
      var serverNumber:int = 0;
      if(e.serversList.length <= 0) {
        this.onBalancerConnectError();
        return;
      }
      var config:String = this.configUrl;
      if(config.indexOf("NUMBER") >= 0) {
        storedServerNode = serverNodeByNumber(e.serversList,this.battleServer);
        recommendedServerNode = getMinElement(e.serversList);
        serverNumber = storedServerNode == null ? recommendedServerNode.serverNumber : storedServerNode.serverNumber;
        config = config.replace("NUMBER",serverNumber);
      }
      this.airParameters = {};
      this.airParameters["config"] = config;
      this.airParameters["resources"] = this.resources;
      this.airParameters["lang"] = Locale.current.name;
      this.airParameters["debug"] = loaderInfo.parameters["debug"] || "";
      this.airParameters["partnerId"] = loaderInfo.parameters["partnerId"] || "";
      var urlReq:URLRequest = new URLRequest(this.swf + "?rand=" + Math.random());
      var urlLoader:URLLoader = new URLLoader();
      urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
      urlLoader.addEventListener(Event.COMPLETE,this.byteArrayLoadComplete);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      urlLoader.load(urlReq);
    }

    private function isSteamClient() : Boolean {
      return loaderInfo.parameters["partnerId"] == "steam";
    }

    private function onBalancerConnectError(event:Event = null) : void {
      Alert.showMessage("Can not connect to balancer!");
      stage.nativeWindow.visible = true;
    }

    private function onLoadingError(event:Event) : void {
      Alert.showMessage("Connection error!");
      stage.nativeWindow.visible = true;
    }

    private function byteArrayLoadComplete(event:Event) : void {
      var bytes:ByteArray = URLLoader(event.target).data as ByteArray;
      this.tanksLauncherLoader = new Loader();
      var loaderContext:LoaderContext = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
      loaderContext.parameters = this.airParameters;
      var loaderInfo:LoaderInfo = this.tanksLauncherLoader.contentLoaderInfo;
      loaderInfo.addEventListener(Event.COMPLETE,this.onLauncherLoadingComplete,false,0,true);
      loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError,false,0,true);
      loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError,false,0,true);
      loaderContext.allowCodeImport = true;
      this.tanksLauncherLoader.loadBytes(bytes,loaderContext);
    }

    private function mouseClick(e:MouseEvent) : void {
      if(this.canChangeLocale && !(e.target == this.selector || e.target.parent != null && e.target.parent == this.selector)) {
        this.selector.closeList();
      }
    }

    private function onLauncherLoadingComplete(event:Event) : void {
      var options:NativeWindowInitOptions = new NativeWindowInitOptions();
      options.renderMode = "direct";
      options.maximizable = true;
      this.window = new NativeWindow(options);
      this.window.minSize = new Point(1024,768);
      this.window.maxSize = new Point(4095,2880);
      if(this.isSteamClient()) {
        this.window.stage.addChild(this.steamRenderer);
      }
      this.window.stage.addChild(new LauncherContainer(this.tanksLauncherLoader,this));
      this.window.stage.stageWidth = 1024;
      this.window.stage.stageHeight = 768;
      this.window.addEventListener(Event.CLOSING,this.onClosing);
      this.window.addEventListener(NativeWindowBoundsEvent.MOVE,this.onWindowMoveOrResize);
      this.window.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onWindowMoveOrResize);
      this.window.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onDisplayStateChange);
      this.loadDisplayState();
    }

    private function onClosing(event:Event) : void {
      NativeApplication.nativeApplication.exit();
    }

    private function onDisplayStateChange(event:NativeWindowDisplayStateEvent) : void {
      this.saveDisplayStateDelayed();
    }

    private function onWindowMoveOrResize(event:NativeWindowBoundsEvent) : void {
      this.saveDisplayStateDelayed();
    }

    private function saveDisplayStateDelayed() : void {
      if(this.displayStateTimeout != 0) {
        clearTimeout(this.displayStateTimeout);
      }
      this.displayStateTimeout = setTimeout(this.saveDisplayState,100);
    }

    private function loadDisplayState() : void {
      this.displayStateTimeout = 0;
      var displayState:DisplayState = Storage.getDisplayState();
      var origin:Point = new Point(displayState.x,displayState.y);
      var size:Point = new Point(displayState.width,displayState.height);
      var maximized:Boolean = displayState.fullscreen;
      if(pointIsVisibleOnScreens(origin,Screen.screens)) {
        this.window.y = origin.y;
        this.window.x = origin.x;
        if(maximized) {
          this.setDefaultWindowSize();
          this.window.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        } else {
          this.window.width = size.x;
          this.window.height = size.y;
        }
      } else {
        this.setDefaultWindowSize();
      }
      this.window.visible = true;
    }

    private function setDefaultWindowSize() : void {
      this.window.x = 100;
      this.window.y = 100;
      this.window.width = 1024;
      this.window.height = 768;
    }

    private function saveDisplayState() : void {
      this.displayStateTimeout = 0;
      Storage.setDisplayState(this.window.x,this.window.y,this.window.width,this.window.height,this.window.stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE);
    }

    public function isUserFromTutorial() : Boolean {
      var tutorialFile:File = File.documentsDirectory.resolvePath("tu.dat");
      if(tutorialFile.exists) {
        return this.deleteTutorialFile(tutorialFile);
      }
      return false;
    }

    private function deleteTutorialFile(tutorialFile:File) : Boolean {
      try {
        tutorialFile.deleteFile();
        return true;
      }
      catch(e:Error) {
      }
      return false;
    }

    public function closeLauncher() : void {
      NativeApplication.nativeApplication.exit();
    }

    public function get serverStored() : Boolean {
      if(this.battleServer != -1) {
        this.battleServer = -1;
        return true;
      }
      return false;
    }
  }
}
