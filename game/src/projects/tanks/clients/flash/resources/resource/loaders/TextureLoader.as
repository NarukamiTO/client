package projects.tanks.clients.flash.resources.resource.loaders {
  import alternativa.engine3d.loaders.events.LoaderEvent;
  import alternativa.engine3d.loaders.events.LoaderProgressEvent;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.resource.SafeURLLoader;

  [Event(name="loaderProgress",type="alternativa.engine3d.loaders.events.LoaderProgressEvent")]
  [Event(name="partComplete",type="alternativa.engine3d.loaders.events.LoaderEvent")]
  [Event(name="partOpen",type="alternativa.engine3d.loaders.events.LoaderEvent")]
  [Event(name="ioError",type="flash.events.IOErrorEvent")]
  [Event(name="complete",type="flash.events.Event")]
  [Event(name="open",type="flash.events.Event")]
  public class TextureLoader extends EventDispatcher {
    private static const IDLE:int = 0;
    private static const LOADING_DIFFUSE_MAP:int = 1;
    private static const LOADING_OPACITY_MAP:int = 2;

    public var diffuseData:ByteArray;
    public var opacityData:ByteArray;

    private var state:int = 0;
    private var urlLoader:SafeURLLoader;
    private var diffuseTextureUrl:String;
    private var opacityTextureUrl:String;

    public function TextureLoader() {
      super();
    }

    public function load(param1:String, param2:String = null) : void {
      this.unload();
      this.diffuseTextureUrl = param1;
      this.opacityTextureUrl = param2;
      this.loadPart(LOADING_DIFFUSE_MAP,param1);
    }

    public function reload() : void {
      switch(this.state) {
        case LOADING_DIFFUSE_MAP:
          this.destroyLoader();
          this.loadPart(LOADING_DIFFUSE_MAP,this.diffuseTextureUrl);
          break;
        case LOADING_OPACITY_MAP:
          this.destroyLoader();
          this.loadPart(LOADING_OPACITY_MAP,this.opacityTextureUrl);
          break;
        default:
          throw new Error("Wrong loader state: " + this.state);
      }
    }

    public function close() : void {
      if(this.state == IDLE) {
        return;
      }
      this.state = IDLE;
      this.urlLoader.close();
      this.cleanup();
    }

    public function unload() : void {
      this.close();
      this.diffuseData = null;
      this.opacityData = null;
    }

    private function cleanup() : void {
      this.destroyLoader();
      this.diffuseTextureUrl = null;
      this.opacityTextureUrl = null;
    }

    private function loadPart(param1:int, param2:String) : void {
      this.state = param1;
      this.createLoader();
      this.urlLoader.load(new URLRequest(param2));
    }

    private function onPartLoadingOpen(param1:Event) : void {
      if(this.diffuseData == null && hasEventListener(Event.OPEN)) {
        dispatchEvent(new Event(Event.OPEN));
      }
      if(hasEventListener(LoaderEvent.PART_OPEN)) {
        dispatchEvent(new LoaderEvent(LoaderEvent.PART_OPEN,2,this.state == LOADING_DIFFUSE_MAP ? 0 : 1));
      }
    }

    private function onPartLoadingProgress(param1:ProgressEvent) : void {
      var local2:int = 0;
      var local3:Number = NaN;
      if(hasEventListener(LoaderProgressEvent.LOADER_PROGRESS)) {
        local2 = this.state == LOADING_DIFFUSE_MAP ? 0 : 1;
        local3 = 0.5 * (local2 + param1.bytesLoaded / param1.bytesTotal);
        dispatchEvent(new LoaderProgressEvent(LoaderProgressEvent.LOADER_PROGRESS,2,local2,local3,param1.bytesLoaded,param1.bytesTotal));
      }
    }

    private function onPartLoadingComplete(param1:Event) : void {
      switch(this.state) {
        case LOADING_DIFFUSE_MAP:
          this.diffuseData = this.urlLoader.data;
          this.destroyLoader();
          this.dispatchPartComplete(0);
          if(Boolean(this.opacityTextureUrl)) {
            this.loadPart(LOADING_OPACITY_MAP,this.opacityTextureUrl);
          } else {
            this.complete();
          }
          break;
        case LOADING_OPACITY_MAP:
          this.opacityData = this.urlLoader.data;
          this.destroyLoader();
          this.dispatchPartComplete(1);
          this.complete();
      }
    }

    private function dispatchPartComplete(param1:int) : void {
      if(hasEventListener(LoaderEvent.PART_COMPLETE)) {
        dispatchEvent(new LoaderEvent(LoaderEvent.PART_COMPLETE,2,param1));
      }
    }

    private function onLoadingError(param1:ErrorEvent) : void {
      this.state = IDLE;
      this.cleanup();
      dispatchEvent(param1);
    }

    private function complete() : void {
      this.state = IDLE;
      this.cleanup();
      if(hasEventListener(Event.COMPLETE)) {
        dispatchEvent(new Event(Event.COMPLETE));
      }
    }

    private function createLoader() : void {
      this.urlLoader = new SafeURLLoader();
      this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
      this.urlLoader.addEventListener(Event.OPEN,this.onPartLoadingOpen);
      this.urlLoader.addEventListener(ProgressEvent.PROGRESS,this.onPartLoadingProgress);
      this.urlLoader.addEventListener(Event.COMPLETE,this.onPartLoadingComplete);
      this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
    }

    private function destroyLoader() : void {
      if(this.urlLoader != null) {
        this.urlLoader.close();
        this.urlLoader.removeEventListener(Event.OPEN,this.onPartLoadingOpen);
        this.urlLoader.removeEventListener(ProgressEvent.PROGRESS,this.onPartLoadingProgress);
        this.urlLoader.removeEventListener(Event.COMPLETE,this.onPartLoadingComplete);
        this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
        this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
        this.urlLoader = null;
      }
    }
  }
}
