package projects.tanks.clients.flash.resources.resource.loaders {
  import alternativa.engine3d.loaders.events.LoaderEvent;
  import alternativa.engine3d.loaders.events.LoaderProgressEvent;
  import alternativa.proplib.utils.TextureByteDataMap;
  import alternativa.utils.textureutils.TextureByteData;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.utils.ByteArray;
  import projects.tanks.clients.flash.resources.resource.loaders.events.BatchTextureLoaderErrorEvent;

  [Event(name="loaderProgress",type="alternativa.engine3d.loaders.events.LoaderProgressEvent")]
  [Event(name="partComplete",type="alternativa.engine3d.loaders.events.LoaderEvent")]
  [Event(name="partOpen",type="alternativa.engine3d.loaders.events.LoaderEvent")]
  [Event(name="loaderError",type="projects.tanks.clients.flash.resources.resource.loaders.events.BatchTextureLoaderErrorEvent")]
  [Event(name="complete",type="flash.events.Event")]
  [Event(name="open",type="flash.events.Event")]
  public class BatchTextureLoader extends EventDispatcher {
    private static var redSquareClass:Class = BatchTextureLoader_redSquareClass;
    private static var redSquareData:ByteArray = new redSquareClass();

    private static const IDLE:int = 0;
    private static const LOADING:int = 1;

    private var state:int = 0;
    private var textureLoader:TextureLoader;
    private var baseURL:String;
    private var batch:Object;
    private var textureNames:Vector.<String>;
    private var textureIndex:int;
    private var numTextures:int;
    private var _textures:TextureByteDataMap;
    private var loadingOpened:Boolean;

    public function BatchTextureLoader(param1:Object) {
      var local2:String = null;
      super();
      if(param1 == null) {
        throw ArgumentError("Parameter batch cannot be null");
      }
      this.batch = param1;
      this.textureNames = new Vector.<String>();
      for(local2 in param1) {
        this.textureNames.push(local2);
      }
      this.numTextures = this.textureNames.length;
    }

    public function get textures() : TextureByteDataMap {
      return this._textures;
    }

    public function close() : void {
      if(this.state == LOADING) {
        this.textureLoader.close();
        this.cleanup();
        this._textures = null;
        this.state = IDLE;
      }
    }

    public function unload() : void {
      this._textures = null;
    }

    public function load(param1:String) : void {
      if(param1 == null) {
        throw ArgumentError("Parameter baseURL cannot be null");
      }
      this.baseURL = param1;
      if(this.textureLoader == null) {
        this.textureLoader = new TextureLoader();
        this.textureLoader.addEventListener(Event.OPEN,this.onTextureLoadingOpen);
        this.textureLoader.addEventListener(LoaderProgressEvent.LOADER_PROGRESS,this.onProgress);
        this.textureLoader.addEventListener(Event.COMPLETE,this.onTextureLoadingComplete);
        this.textureLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
        this.textureLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      } else {
        this.close();
      }
      this._textures = new TextureByteDataMap();
      this.loadingOpened = false;
      this.state = LOADING;
      this.textureIndex = 0;
      this.loadCurrentTexture();
    }

    public function reload() : void {
      if(this.state == IDLE) {
        throw new Error("Wrong method invocation");
      }
      this.textureLoader.reload();
    }

    private function loadCurrentTexture() : void {
      var local1:TextureInfo = this.batch[this.textureNames[this.textureIndex]];
      var local2:String = Boolean(local1.opacityMapFileName) ? this.baseURL + local1.opacityMapFileName : null;
      this.textureLoader.load(this.baseURL + local1.diffuseMapFileName,local2);
    }

    private function onTextureLoadingOpen(param1:Event) : void {
      if(!this.loadingOpened) {
        this.loadingOpened = true;
        if(hasEventListener(Event.OPEN)) {
          dispatchEvent(new Event(Event.OPEN));
        }
      }
      if(hasEventListener(LoaderEvent.PART_OPEN)) {
        dispatchEvent(new LoaderEvent(LoaderEvent.PART_OPEN,this.numTextures,this.textureIndex));
      }
    }

    private function onProgress(param1:LoaderProgressEvent) : void {
      var local2:Number = NaN;
      if(hasEventListener(LoaderProgressEvent.LOADER_PROGRESS)) {
        local2 = (this.textureIndex + param1.totalProgress) / this.numTextures;
        dispatchEvent(new LoaderProgressEvent(LoaderProgressEvent.LOADER_PROGRESS,this.numTextures,this.textureIndex,local2,param1.bytesLoaded,param1.bytesTotal));
      }
    }

    private function onTextureLoadingComplete(param1:Event) : void {
      this._textures.putValue(this.textureNames[this.textureIndex],new TextureByteData(this.textureLoader.diffuseData,this.textureLoader.opacityData));
      this.tryNextTexure();
    }

    private function onLoadingError(param1:ErrorEvent) : void {
      var local2:String = this.textureNames[this.textureIndex];
      this._textures.putValue(local2,new TextureByteData(this.textureLoader.diffuseData || redSquareData));
      dispatchEvent(new BatchTextureLoaderErrorEvent(BatchTextureLoaderErrorEvent.LOADER_ERROR,local2,param1.text));
      this.tryNextTexure();
    }

    private function tryNextTexure() : void {
      if(this.state == IDLE) {
        return;
      }
      if(hasEventListener(LoaderEvent.PART_COMPLETE)) {
        dispatchEvent(new LoaderEvent(LoaderEvent.PART_COMPLETE,this.numTextures,this.textureIndex));
      }
      if(++this.textureIndex == this.numTextures) {
        this.cleanup();
        this.state = IDLE;
        if(hasEventListener(Event.COMPLETE)) {
          dispatchEvent(new Event(Event.COMPLETE));
        }
      } else {
        this.loadCurrentTexture();
      }
    }

    private function cleanup() : void {
      this.textureNames = null;
    }
  }
}
