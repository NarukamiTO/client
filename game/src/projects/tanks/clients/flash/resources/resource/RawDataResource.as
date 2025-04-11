package projects.tanks.clients.flash.resources.resource {
  import alternativa.startup.CacheURLLoader;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceFlags;
  import platform.client.fp10.core.resource.ResourceInfo;
  import platform.client.fp10.core.resource.ResourceStatus;

  public class RawDataResource extends Resource {
    public static const TYPE:int = 400;

    private static const FILE_NAME:String = "data.bin";

    private var loader:CacheURLLoader;
    private var _data:ByteArray;
    private var _dataParsed:Vector.<Number> = new Vector.<Number>();

    public function RawDataResource(param1:ResourceInfo) {
      super(param1);
    }

    override public function get description() : String {
      return "ByteArray";
    }

    override public function toString() : String {
      return "[RawDataResource id=" + id + "]";
    }

    override public function load(param1:String, param2:IResourceLoadingListener) : void {
      super.load(param1,param2);
      this.doLoad();
    }

    override protected function doReload() : void {
      if(isLoading) {
        clearFlags(ResourceFlags.IS_LOADING);
        this.loader.close();
      }
      this.doLoad();
    }

    private function doLoad() : void {
      this.loader = new CacheURLLoader();
      this.loader.dataFormat = URLLoaderDataFormat.BINARY;
      this.loader.addEventListener(Event.OPEN,this.onLoadingOpen);
      this.loader.addEventListener(Event.COMPLETE,this.onLoadComplete);
      this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadIOError);
      this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadError);
      this.loader.addEventListener(ProgressEvent.PROGRESS,this.onLoadProgress);
      this.loader.load(new URLRequest(baseUrl + FILE_NAME));
      startTimeoutTracking();
      status = ResourceStatus.REQUESTED;
    }

    private function onLoadingOpen(param1:Event) : void {
      setFlags(ResourceFlags.IS_LOADING);
      updateLastActivityTime();
      listener.onResourceLoadingStart(this);
    }

    private function onLoadComplete(param1:Event) : void {
      clearFlags(ResourceFlags.IS_LOADING);
      this.loader.removeEventListener(Event.OPEN,this.onLoadingOpen);
      this.loader.removeEventListener(Event.COMPLETE,this.onLoadComplete);
      this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadIOError);
      this.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadError);
      this.loader.removeEventListener(ProgressEvent.PROGRESS,this.onLoadProgress);
      this._data = this.loader.data as ByteArray;
      var local2:ParserWav = new ParserWav();
      this._dataParsed = local2.parse(this._data,20,false);
      completeLoading();
    }

    private function onLoadIOError(param1:IOErrorEvent) : void {
      listener.onResourceLoadingFatalError(this,param1.toString());
    }

    private function onLoadError(param1:SecurityErrorEvent) : void {
      listener.onResourceLoadingFatalError(this,param1.toString());
    }

    private function onLoadProgress(param1:ProgressEvent) : void {
      updateLastActivityTime();
    }

    public function get data() : ByteArray {
      return this._data;
    }

    public function get dataParsed() : Vector.<Number> {
      return this._dataParsed;
    }
  }
}
