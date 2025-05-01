package projects.tanks.clients.fp10.StandaloneLoader {
  import flash.desktop.NativeApplication;
  import flash.display.Bitmap;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Screen;
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.utils.ByteArray;

  [SWF(width="256",height="256",backgroundColor="#000000",frameRate="40")]
  public class StandaloneLoader extends Sprite {
    private var logo:Class = StandaloneLoader_logo;
    private var logoBmp:Bitmap;
    private var guiLayer:Sprite;
    private var prelauncher:Loader;
    private var locale:String;

    protected var prelauncherSwf:String;

    public function StandaloneLoader() {
      super();
      addEventListener(Event.ADDED_TO_STAGE,this.init);
    }

    private function init(e:Event = null) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.init);
      this.prelauncherSwf = loaderInfo.parameters["prelauncher"] || "http://tankionline.com/Prelauncher.swf";
      this.locale = loaderInfo.parameters["locale"] || "ru";
      LocalizedTexts.setLocale(this.locale);
      this.configureStage();
      this.createGUI();
      this.loadStandalone();
    }

    private function configureStage() : void {
      stage.align = StageAlign.TOP_LEFT;
      var size:int = 256;
      stage.stageWidth = size;
      stage.stageHeight = size;
      stage.nativeWindow.maxSize = new Point(stage.nativeWindow.width,stage.nativeWindow.height);
      stage.nativeWindow.minSize = new Point(stage.nativeWindow.width,stage.nativeWindow.height);
      this.setCenterPosition();
    }

    private function createGUI() : void {
      this.guiLayer = new Sprite();
      this.logoBmp = new this.logo() as Bitmap;
      this.guiLayer.addChild(this.logoBmp);
      this.logoBmp.scaleX = 0.5;
      this.logoBmp.scaleY = 0.5;
      this.logoBmp.x = -(this.logoBmp.bitmapData.width * this.logoBmp.scaleX - stage.stageWidth) / 2;
      this.logoBmp.y = -(this.logoBmp.bitmapData.height * this.logoBmp.scaleY - stage.stageHeight) / 2;
      stage.addChild(this.guiLayer);
    }

    private function removeGUI() : void {
      stage.removeChild(this.guiLayer);
    }

    private function get version() : String {
      var xml:XML = NativeApplication.nativeApplication.applicationDescriptor;
      var ns:Namespace = xml.namespace();
      return xml.ns::versionNumber;
    }

    private function loadStandalone() : void {
      if(this.prelauncherSwf.indexOf("file") < 0) {
        this.prelauncherSwf += "?rand=" + Math.random().toString();
      }
      var urlReq:URLRequest = new URLRequest(this.prelauncherSwf);
      var urlLoader:URLLoader = new URLLoader();
      urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
      urlLoader.addEventListener(Event.COMPLETE,this.byteArrayLoadComplete);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      urlLoader.load(urlReq);
    }

    private function onLoadingError(event:Event) : void {
      Alert.showMessage(LocalizedTexts.CONNECTION_ERROR);
    }

    private function isNewVersionAvailable(version:String) : Boolean {
      if(this.version != version) {
        Alert.showMessage(LocalizedTexts.NEW_VERSION_AVAILABLE(version,this.version));
      }
      return this.version == version;
    }

    private function byteArrayLoadComplete(event:Event) : void {
      var bytes:ByteArray = URLLoader(event.target).data as ByteArray;
      this.prelauncher = new Loader();
      var loaderInfo:LoaderInfo = this.prelauncher.contentLoaderInfo;
      loaderInfo.addEventListener(Event.COMPLETE,this.onLauncherLoadingComplete);
      loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      loaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
      loaderContext.allowCodeImport = true;
      loaderContext.parameters = this.loaderInfo.parameters;
      this.prelauncher.loadBytes(bytes,loaderContext);
    }

    private function setCenterPosition() : void {
      var appBounds:Rectangle = stage.nativeWindow.bounds;
      var screen:Screen = Screen.getScreensForRectangle(appBounds)[0];
      stage.nativeWindow.x = (screen.bounds.width - stage.nativeWindow.width) / 2;
      stage.nativeWindow.y = (screen.bounds.height - stage.nativeWindow.height) / 2;
    }

    private function onLauncherLoadingComplete(event:Event) : void {
      this.removeGUI();
      if(this.isNewVersionAvailable(this.prelauncher.getChildAt(0)["version"])) {
        stage.nativeWindow.maxSize = new Point(1050,650);
        stage.nativeWindow.minSize = new Point(stage.nativeWindow.width,stage.nativeWindow.height);
        stage.nativeWindow.width = 1000;
        stage.nativeWindow.height = 600;
        this.addChild(this.prelauncher.getChildAt(0));
        stage.stageWidth = 1000;
        stage.stageHeight = 600;
        stage.nativeWindow.maxSize = new Point(stage.nativeWindow.width,stage.nativeWindow.height);
        stage.nativeWindow.minSize = new Point(stage.nativeWindow.width,stage.nativeWindow.height);
        this.setCenterPosition();
      }
    }
  }
}
