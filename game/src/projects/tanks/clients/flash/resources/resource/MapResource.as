package projects.tanks.clients.flash.resources.resource {
  import alternativa.proplib.PropLibRegistry;
  import alternativa.types.Long;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.IResourceSerializationListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceInfo;
  import platform.client.fp10.core.resource.ResourceStatus;
  import platform.client.fp10.core.resource.SafeURLLoader;

  public class MapResource extends Resource {
    [Inject]
    public static var resourceRegistry:ResourceRegistry;

    public static const TYPE:int = 7;

    private static const BINARY_HEADER:Vector.<int> = Vector.<int>([77,65,80,1]);
    private static const LOADING_STATE_IDLE:int = 0;
    private static const LOADING_STATE_INFO:int = 1;
    private static const LOADING_STATE_PROPLIB_INFO:int = LOADING_STATE_INFO + 1;
    private static const LOADING_STATE_MAP:int = LOADING_STATE_INFO + 2;
    private static const LIBS_FILE_NAME:String = "proplibs.xml";
    private static const MAP_FILE_NAME:String = "map.xml";

    public var libRegistry:PropLibRegistry;
    public var proplibsData:ByteArray;
    public var mapData:ByteArray;
    public var libIds:Vector.<Long>;

    private var loader:SafeURLLoader;
    private var loadingState:int = -1;

    public function MapResource(param1:ResourceInfo) {
      super(param1);
    }

    override public function get description() : String {
      return "Map";
    }

    override public function load(param1:String, param2:IResourceLoadingListener) : void {
      super.load(param1,param2);
      this.loadProplibsInfo();
    }

    private function loadProplibsInfo() : void {
      this.createUrlLoader(this.onPropLibsInfoLoadingOpen,this.onPropLibsInfoLoadingComplete);
      this.loader.load(new URLRequest(baseUrl + LIBS_FILE_NAME));
      this.loadingState = LOADING_STATE_PROPLIB_INFO;
      status = ResourceStatus.REQUESTED;
      startTimeoutTracking();
    }

    override public function close() : void {
      if(this.loadingState != LOADING_STATE_IDLE) {
        this.loader.close();
      }
      this.destroyLoader();
      this.proplibsData = null;
      this.mapData = null;
    }

    override protected function doReload() : void {
      switch(this.loadingState) {
        case LOADING_STATE_PROPLIB_INFO:
          this.loader.close();
          this.destroyLoader();
          this.loadProplibsInfo();
          break;
        case LOADING_STATE_MAP:
          this.loader.close();
          this.destroyLoader();
          this.loadMap();
      }
    }

    override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean {
      this.listener = param2;
      if(param1 == null || param1.length < BINARY_HEADER.length) {
        return false;
      }
      var local3:int = 0;
      while(local3 < BINARY_HEADER.length) {
        if(param1.readUnsignedByte() != BINARY_HEADER[local3]) {
          return false;
        }
        local3++;
      }
      var local4:int = param1.readInt();
      this.proplibsData = new ByteArray();
      param1.readBytes(this.proplibsData,0,local4);
      local4 = param1.readInt();
      this.mapData = new ByteArray();
      param1.readBytes(this.mapData,0,local4);
      this.buildMap();
      setTimeout(completeLoading,0);
      return true;
    }

    override public function serialize(param1:IResourceSerializationListener) : void {
      var local2:ByteArray = new ByteArray();
      var local3:int = 0;
      while(local3 < BINARY_HEADER.length) {
        local2.writeByte(BINARY_HEADER[local3]);
        local3++;
      }
      local2.writeInt(this.proplibsData.length);
      local2.writeBytes(this.proplibsData);
      local2.writeInt(length);
      local2.writeBytes(this.mapData);
      param1.onSerializationComplete(this,local2);
    }

    private function onPropLibsInfoLoadingOpen(param1:Event) : void {
      updateLastActivityTime();
    }

    private function onPropLibsInfoLoadingComplete(param1:Event) : void {
      this.proplibsData = this.loader.data;
      this.destroyLoader();
      this.loadMap();
    }

    private function parsePropLibsInfo(param1:XML) : void {
      var local2:XML = null;
      var local3:int = 0;
      var local4:Long = null;
      var local5:PropLibResource = null;
      this.libRegistry = new PropLibRegistry();
      this.libIds = new Vector.<Long>();
      for each(local2 in param1.library) {
        local3 = int("0x" + local2.attribute("resource-id").toString());
        local4 = Long.getLong(0,local3);
        this.libIds.push(local4);
        local5 = PropLibResource(resourceRegistry.getResource(local4));
        if(local5 == null) {
          throw new Error("Prop library resource [id=" + local4 + "] not found");
        }
        this.libRegistry.addLibrary(local5.lib);
      }
    }

    private function loadMap() : void {
      this.createUrlLoader(this.onMapLoadingOpen,this.onMapLoadingComplete);
      this.loader.load(new URLRequest(baseUrl + MAP_FILE_NAME));
      this.loadingState = LOADING_STATE_MAP;
      startTimeoutTracking();
    }

    private function onMapLoadingOpen(param1:Event) : void {
      updateLastActivityTime();
    }

    private function onMapLoadingComplete(param1:Event) : void {
      this.mapData = this.loader.data;
      this.destroyLoader();
      this.buildMap();
      completeLoading();
    }

    private function buildMap() : void {
      try {
        this.parsePropLibsInfo(XML(this.proplibsData.toString()));
      }
      catch(e:Error) {
        listener.onResourceLoadingFatalError(this,e.message + " " + e.getStackTrace());
      }
    }

    private function onLoadingError(param1:ErrorEvent) : void {
      listener.onResourceLoadingFatalError(this,param1.text);
    }

    private function createUrlLoader(param1:Function, param2:Function) : void {
      this.loader = new SafeURLLoader();
      this.loader.dataFormat = URLLoaderDataFormat.BINARY;
      this.loader.addEventListener(Event.OPEN,param1);
      this.loader.addEventListener(Event.COMPLETE,param2);
      this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
    }

    private function destroyLoader() : void {
      if(this.loader == null) {
        return;
      }
      this.loader.removeEventListener(Event.OPEN,this.onPropLibsInfoLoadingOpen);
      this.loader.removeEventListener(Event.COMPLETE,this.onPropLibsInfoLoadingComplete);
      this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      this.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      this.loader = null;
    }
  }
}
