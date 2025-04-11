package alternativa {
  import alternativa.launcher.ServerConfigLoader;
  import alternativa.launcher.ServerConfigLoaderListener;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.osgi.service.launcherparams.LauncherParams;
  import alternativa.osgi.service.serverlog.ServerLoggingService;
  import alternativa.osgi.service.serverlog.ServerLoggingServiceImpl;
  import alternativa.startup.CacheURLLoader;
  import alternativa.startup.ConnectionParameters;
  import alternativa.startup.IClientConfigurator;
  import alternativa.startup.LibraryInfo;
  import alternativa.startup.StartupSettings;
  import alternativa.types.DummyListener;
  import alternativa.types.LogOutput;
  import flash.display.DisplayObjectContainer;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.utils.ByteArray;

  public class Launcher implements ServerConfigLoaderListener {
    private var container:DisplayObjectContainer;
    private var listener:ILauncherListener;
    private var osgi:OSGi;
    private var debugMode:Boolean;
    private var logOutput:LogOutput;
    private var libraryInfos:Vector.<LibraryInfo> = new Vector.<LibraryInfo>();
    private var loadingLibrary:LibraryInfo;
    private var logStrings:Vector.<String> = new Vector.<String>();
    private var connectionParams:ConnectionParameters;
    private var params:LauncherParams;
    private var configLoader:ServerConfigLoader;

    public function Launcher(param1:DisplayObjectContainer, param2:LauncherParams, param3:ILauncherListener = null) {
      super();
      if(param1 == null) {
        throw new ArgumentError("Parameter container is null");
      }
      if(param2 == null) {
        throw new ArgumentError("Parameter params is null");
      }
      this.osgi = OSGi.getInstance();
      this.osgi.registerService(Launcher,this);
      this.osgi.registerService(ServerLoggingService,new ServerLoggingServiceImpl(param2));
      this.debugMode = param2.isDebug;
      this.container = param1;
      this.listener = param3 || new DummyListener(this.logOutput);
      this.params = param2;
      if(this.debugMode) {
        this.logOutput = new LogOutput();
        param1.addChild(this.logOutput);
      }
      this.log("Debug mode: " + this.debugMode);
    }

    public static function findClass(param1:String) : Class {
      return Class(ApplicationDomain.currentDomain.getDefinition(param1));
    }

    public function start() : void {
      this.configLoader = new ServerConfigLoader(this.params,this);
      this.configLoader.loadServerConfiguration();
    }

    public function onServerConfigLoadingStart() : void {
      this.listener.onConfigLoadingStart();
    }

    public function onServerUnavailable() : void {
      this.listener.onServerUnavailable();
    }

    public function onServerOverloaded() : void {
      this.listener.onServerOverloaded();
    }

    public function onServerConfigParsed(param1:ConnectionParameters) : void {
      this.connectionParams = param1;
      this.listener.onLibrariesLoadingStart();
      this.loadLibrariesManifest();
    }

    private function getLibsUrl() : String {
      var local1:String = this.connectionParams.resourcesRootURL;
      var local2:int = int(local1.indexOf("resources/"));
      var local3:String = local2 == -1 ? local1 : local1.substr(0,local2);
      return local3 + "libs/";
    }

    private function loadLibrariesManifest() : void {
      var local1:String = this.getLibsUrl() + "manifest.json?rand=" + Math.random();
      var local2:URLRequest = new URLRequest(local1);
      local2.method = URLRequestMethod.GET;
      var local3:URLLoader = new URLLoader();
      local3.addEventListener(Event.COMPLETE,this.onLibrariesManifestLoaded);
      local3.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingManifestError);
      local3.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingManifestError);
      local3.load(local2);
    }

    private function onLibrariesManifestLoaded(param1:Event) : void {
      var key:String = null;
      var event:Event = param1;
      var result:Object = JSON.parse(unescape(event.target.data));
      var rootPath:String = this.getLibsUrl();
      this.libraryInfos = new Vector.<LibraryInfo>();
      for(key in result) {
        this.libraryInfos.push(new LibraryInfo(key,rootPath + result[key]));
      }
      this.listener.onLibrariesLoadingStart();
      this.loadLibrary("entrance.swf",function():void {
        listener.onLibrariesLoadingComplete(params,function():void {
          connectToServer();
          initLibrary("EntranceActivator");
          listener.onLibrariesInitialized();
          if(debugMode) {
            logOutput.parent.removeChild(logOutput);
          }
        });
      });
    }

    private function onLoadingManifestError(param1:ErrorEvent) : void {
      this.listener.onLibraryLoadingError("Loading manifest error: url = " + this.getLibsUrl() + "manifest.json, error=#" + param1.errorID);
    }

    public function loadLibrary(param1:String, param2:Function) : void {
      var local3:* = undefined;
      var local4:URLRequest = null;
      var local5:CacheURLLoader = null;
      for each(local3 in this.libraryInfos) {
        if(local3.name == param1) {
          this.loadingLibrary = local3;
          break;
        }
      }
      local3.loadingCallback = param2;
      this.log("Loading library " + local3.name + " from " + local3.url);
      local4 = new URLRequest(local3.url);
      local5 = new CacheURLLoader();
      local5.dataFormat = URLLoaderDataFormat.BINARY;
      local5.addEventListener(Event.COMPLETE,this.byteArrayLoadComplete);
      local5.addEventListener(IOErrorEvent.IO_ERROR,this.onLibraryLoadingError);
      local5.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLibraryLoadingError);
      local5.load(local4);
    }

    private function byteArrayLoadComplete(param1:Event) : void {
      var local2:ByteArray = URLLoader(param1.target).data as ByteArray;
      var local3:ByteArray = new ByteArray();
      local3.writeBytes(local2,local2.position,local2.bytesAvailable);
      var local4:Loader = new Loader();
      this.loadingLibrary.loader = local4;
      var local5:LoaderInfo = local4.contentLoaderInfo;
      local5.addEventListener(Event.COMPLETE,this.onLibraryLoadingComplete);
      local5.addEventListener(IOErrorEvent.IO_ERROR,this.onLibraryLoadingError);
      local5.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLibraryLoadingError);
      var local6:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
      if(StartupSettings.isDesktop) {
        local6.allowCodeImport = true;
      }
      local4.loadBytes(local3,local6);
    }

    public function onServerConfigLoadingError(param1:String) : void {
      this.log(param1);
      this.listener.onConfigLoadingError(param1);
    }

    public function onServerConfigLoadingProgress(param1:uint, param2:uint) : void {
      this.listener.onConfigLoadingProgress(param1,param2);
    }

    public function onServerConfigLoadingComplete() : void {
      this.listener.onConfigLoadingComplete();
    }

    public function initLibrary(param1:String) : void {
      var local2:Class = findClass(param1);
      IBundleActivator(new local2()).start(OSGi.getInstance());
    }

    private function connectToServer() : void {
      var local1:Class = findClass("alternativa.ClientConfigurator");
      IClientConfigurator(new local1()).start(this.container,this.params,this.connectionParams,this.logStrings);
      this.connectionParams = null;
    }

    private function onLibraryLoadingComplete(param1:Event) : void {
      var local2:LoaderInfo = LoaderInfo(param1.target);
      local2.removeEventListener(Event.COMPLETE,this.onLibraryLoadingComplete);
      local2.removeEventListener(IOErrorEvent.IO_ERROR,this.onLibraryLoadingError);
      local2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLibraryLoadingError);
      var local3:LibraryInfo = this.loadingLibrary;
      this.loadingLibrary = null;
      local3.loadingCallback();
      local3.loadingCallback = null;
    }

    private function onLibraryLoadingError(param1:IOErrorEvent) : void {
      this.log(param1.text);
      this.listener.onLibraryLoadingError(param1.text);
    }

    public function log(param1:String) : void {
      this.logStrings.push(param1);
      if(this.debugMode) {
        this.logOutput.addLine(param1);
      }
    }
  }
}
