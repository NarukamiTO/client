package alternativa.startup {
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.media.Sound;
  import flash.media.SoundLoaderContext;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import flash.utils.getDefinitionByName;

  public class SoundCacheLoader extends Sound {
    private var encodedUrl:String;
    private var cacheDirectory:Object;
    private var context:SoundLoaderContext;
    private var FileClass:Class;
    private var FileStreamClass:Class;
    private var FileModeClass:Class;

    public function SoundCacheLoader() {
      super();
      if(StartupSettings.isDesktop) {
        this.FileClass = getDefinitionByName("flash.filesystem.File") as Class;
        this.FileStreamClass = getDefinitionByName("flash.filesystem.FileStream") as Class;
        this.FileModeClass = getDefinitionByName("flash.filesystem.FileMode") as Class;
        this.cacheDirectory = this.FileClass.applicationStorageDirectory.resolvePath("cache");
        if(!this.cacheDirectory.exists) {
          this.cacheDirectory.createDirectory();
        } else if(!this.cacheDirectory.isDirectory) {
          throw new Error("Cannot create directory." + this.cacheDirectory.nativePath + " is already exists.");
        }
      }
    }

    override public function load(param1:URLRequest, param2:SoundLoaderContext = null) : void {
      if(!StartupSettings.isDesktop || param1 == null) {
        super.load(param1,param2);
        return;
      }
      this.context = param2;
      this.encodedUrl = URLEncoder.encode(param1.url);
      var local3:Object = this.cacheDirectory.resolvePath(this.encodedUrl);
      if(local3.exists) {
        super.load(new URLRequest(local3.url),param2);
        return;
      }
      var local4:URLLoader = new URLLoader();
      local4.dataFormat = URLLoaderDataFormat.BINARY;
      local4.addEventListener(Event.COMPLETE,this.onBytesLoaded,false,0,true);
      local4.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,true);
      local4.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,0,true);
      local4.load(param1);
    }

    private function onIOError(param1:Event) : void {
      dispatchEvent(new IOErrorEvent("SoundCacheLoader: IOError!"));
    }

    private function onSecurityError(param1:Event) : void {
      dispatchEvent(new SecurityErrorEvent("SoundCacheLoader: Security error!"));
    }

    private function onBytesLoaded(param1:Event) : void {
      var e:Event = param1;
      var bytes:ByteArray = URLLoader(e.target).data as ByteArray;
      var file:Object = new this.FileClass(this.cacheDirectory.resolvePath(this.encodedUrl).nativePath);
      var fileStream:Object = new this.FileStreamClass();
      try {
        fileStream.open(file,this.FileModeClass.WRITE);
        fileStream.writeBytes(bytes);
        fileStream.close();
      }
      catch(e:Error) {
        dispatchEvent(new IOErrorEvent("SoundCacheLoader error! " + e.message + "url: " + encodedUrl));
      }
      super.load(new URLRequest(file.url),this.context);
    }
  }
}
