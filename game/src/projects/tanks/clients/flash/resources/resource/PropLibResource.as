package projects.tanks.clients.flash.resources.resource {
  import alternativa.engine3d.objects.Mesh;
  import alternativa.proplib.PropLibrary;
  import alternativa.proplib.objects.PropObject;
  import alternativa.proplib.types.PropData;
  import alternativa.proplib.types.PropGroup;
  import alternativa.proplib.utils.ByteArrayMap;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.IResourceSerializationListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceInfo;
  import platform.client.fp10.core.resource.ResourceStatus;
  import platform.client.fp10.core.resource.SafeURLLoader;
  import platform.client.fp10.core.resource.tara.TARAParser;
  import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;

  public class PropLibResource extends Resource {
    [Inject]
    public static var resourceLocalStorage:IResourceLocalStorage;

    private static const PROP_LIB_FILE_NAME:String = "library.tara";

    public static const TYPE:int = 8;

    private var loader:SafeURLLoader;

    public var taraData:ByteArray;
    public var lib:PropLibrary;

    public function PropLibResource(param1:ResourceInfo) {
      super(param1);
    }

    private static function prepareMeshes(param1:PropGroup) : void {
      var local2:PropGroup = null;
      var local3:PropData = null;
      var local4:PropObject = null;
      if(param1.groups != null) {
        for each(local2 in param1.groups) {
          prepareMeshes(local2);
        }
      }
      if(param1.props != null) {
        for each(local3 in param1.props) {
          local4 = local3.getDefaultState().getDefaultObject();
          if(local4.object is Mesh) {
            Mesh(local4.object).calculateVerticesNormalsByAngle(ResourceParams.ANGLE_THRESHOLD,0.01);
          }
        }
      }
    }

    override public function get description() : String {
      return "Props library";
    }

    override public function load(param1:String, param2:IResourceLoadingListener) : void {
      super.load(param1,param2);
      this.doLoad();
    }

    private function doLoad() : void {
      this.loader = new SafeURLLoader();
      this.loader.dataFormat = URLLoaderDataFormat.BINARY;
      this.loader.addEventListener(Event.OPEN,this.onLoadingOpen);
      this.loader.addEventListener(ProgressEvent.PROGRESS,this.onLoadingProgress);
      this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      this.loader.addEventListener(Event.COMPLETE,this.onLoadingComplete);
      this.loader.load(new URLRequest(baseUrl + PROP_LIB_FILE_NAME));
      status = ResourceStatus.REQUESTED;
      startTimeoutTracking();
    }

    override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean {
      this.listener = param2;
      this.createLibrary(param1);
      setTimeout(completeLoading,0);
      return true;
    }

    override public function close() : void {
      this.loader.close();
      this.destroyLoader();
    }

    override public function serialize(param1:IResourceSerializationListener) : void {
      var local2:ByteArray = null;
      if(this.taraData != null) {
        local2 = new ByteArray();
        local2.writeBytes(this.taraData);
        param1.onSerializationComplete(this,local2);
        this.taraData = null;
      }
    }

    override protected function doReload() : void {
      this.loader.close();
      this.destroyLoader();
      this.doLoad();
    }

    private function destroyLoader() : void {
      this.loader.removeEventListener(Event.OPEN,this.onLoadingOpen);
      this.loader.removeEventListener(ProgressEvent.PROGRESS,this.onLoadingProgress);
      this.loader.removeEventListener(Event.COMPLETE,this.onLoadingComplete);
      this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadingError);
      this.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadingError);
      this.loader = null;
    }

    private function onLoadingOpen(param1:Event) : void {
      updateLastActivityTime();
      listener.onResourceLoadingStart(this);
    }

    private function onLoadingComplete(param1:Event) : void {
      stopTimeoutTracking();
      this.taraData = this.loader.data;
      this.destroyLoader();
      this.createLibrary(this.taraData);
      completeLoading();
    }

    private function onLoadingProgress(param1:ProgressEvent) : void {
      updateLastActivityTime();
    }

    private function onLoadingError(param1:ErrorEvent) : void {
      stopTimeoutTracking();
      listener.onResourceLoadingFatalError(this,param1.toString());
    }

    private function createLibrary(param1:ByteArray) : void {
      var data:ByteArray = param1;
      try {
        this.lib = new PropLibrary(new ByteArrayMap(new TARAParser(data).data));
        prepareMeshes(this.lib.rootGroup);
      }
      catch(e:Error) {
        throw new Error("PropLibResource: not parsed" + " id:" + id + " baseUrl:" + baseUrl + " error: " + e.getStackTrace());
      }
    }
  }
}
