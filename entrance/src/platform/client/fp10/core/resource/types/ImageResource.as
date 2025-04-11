package platform.client.fp10.core.resource.types {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Loader;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import mx.graphics.codec.PNGEncoder;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.IResourceSerializationListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceFlags;
  import platform.client.fp10.core.resource.ResourceInfo;
  import platform.client.fp10.core.resource.SafeURLLoader;
  import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;

  public class ImageResource extends Resource {
    [Inject]
    public static var resourceLocalStorage:IResourceLocalStorage;

    private static const IMAGE_FILE:String = "image.tnk";
    private static const BINARY_VERSION:int = 1;

    private var loader:SafeURLLoader;
    private var _data:BitmapData;

    public function ImageResource(param1:ResourceInfo) {
      super(param1);
    }

    public function get data() : BitmapData {
      return this._data;
    }

    override public function get description() : String {
      return "Image";
    }

    override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean {
      if(param1.bytesAvailable < 2 || param1.readByte() != BINARY_VERSION) {
        return false;
      }
      this.listener = param2;
      var local3:int = param1.readInt();
      var local4:ByteArray = new ByteArray();
      param1.readBytes(local4,param1.position,local3);
      this.loadImage(param1);
      return true;
    }

    override public function serialize(param1:IResourceSerializationListener) : void {
      var local2:ByteArray = new ByteArray();
      local2.writeByte(BINARY_VERSION);
      var local3:ByteArray = new PNGEncoder().encode(this._data);
      local2.writeInt(local3.length);
      local2.writeBytes(local3);
      param1.onSerializationComplete(this,local2);
    }

    override public function load(param1:String, param2:IResourceLoadingListener) : void {
      super.load(param1,param2);
      this.loadImageBytes();
    }

    override protected function doReload() : void {
      this.loader.close();
      this.loadImageBytes();
    }

    override protected function createDummyData() : Boolean {
      this._data = new StubBitmapData(16711680);
      return true;
    }

    protected function getImageFileName() : String {
      return IMAGE_FILE;
    }

    private function loadImageBytes() : void {
      this.loader = this.createLoader();
      this.loader.load(new URLRequest(baseUrl + this.getImageFileName()));
      startTimeoutTracking();
      status = "Image requested";
    }

    private function onLoadingComplete(param1:Event) : void {
      stopTimeoutTracking();
      this.loadImage(param1.target.data);
    }

    private function loadImage(param1:ByteArray) : void {
      var local2:Loader = new Loader();
      local2.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeLoadImage);
      local2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      local2.loadBytes(param1);
    }

    private function completeLoadImage(param1:Event) : void {
      this._data = Bitmap(param1.target.content).bitmapData;
      this.completeLoading();
    }

    override protected function completeLoading() : void {
      super.completeLoading();
      this.loader = null;
      baseUrl = null;
    }

    private function onLoadingOpen(param1:Event) : void {
      updateLastActivityTime();
      listener.onResourceLoadingStart(this);
    }

    private function onLoadingError(param1:ErrorEvent) : void {
      stopTimeoutTracking();
      this._data = new StubBitmapData(16711680);
      setFlags(ResourceFlags.LOADED);
      baseUrl = null;
      listener.onResourceLoadingError(this,param1.toString());
    }

    private function onLoadingProgress(param1:ProgressEvent) : void {
      updateLastActivityTime();
    }

    private function createLoader() : SafeURLLoader {
      var local1:SafeURLLoader = new SafeURLLoader();
      local1.dataFormat = URLLoaderDataFormat.BINARY;
      local1.addEventListener(Event.OPEN,this.onLoadingOpen);
      local1.addEventListener(ProgressEvent.PROGRESS,this.onLoadingProgress);
      local1.addEventListener(Event.COMPLETE,this.onLoadingComplete);
      local1.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      local1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      return local1;
    }
  }
}
