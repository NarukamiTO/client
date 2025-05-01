package platform.client.fp10.core.resource {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.utils.LoaderUtils;
  import flash.utils.ByteArray;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;

  public class ResourceLoader implements IResourceLoader, IResourceLoadingListener, IResourceSerializationListener {
    [Inject]
    public static var localStorage:IResourceLocalStorage;

    [Inject]
    public static var networkSerice:INetworkService;

    private var logger:Logger;
    private var localStorageInternal:IResourceLocalStorageInternal;
    private var maxParallelLoadings:int = 4;
    private var numLoadingsInProgress:int;
    private var resourceQueue:PriorityQueue;
    private var resourceEntries:Dictionary;

    public function ResourceLoader(param1:OSGi) {
      super();
      var local2:LogService = LogService(param1.getService(LogService));
      this.logger = local2.getLogger(ResourceLogChannel.NAME);
      this.resourceQueue = new PriorityQueue();
      this.resourceEntries = new Dictionary();
      this.localStorageInternal = IResourceLocalStorageInternal(param1.getService(IResourceLocalStorageInternal));
    }

    public function loadResource(param1:Resource, param2:IResourceLoadingListener, param3:int) : void {
      this.addResourceListener(param1,param2);
      if(!param1.isLoading) {
        param1.setFlags(ResourceFlags.IS_LOADING);
        param1.status = ResourceStatus.QUEUED;
        this.resourceQueue.putData(param1,param3);
        this.loadResources();
      }
    }

    public function removeResourceListener(param1:Resource, param2:IResourceLoadingListener) : void {
      var local3:ResourceEntry = this.resourceEntries[param1];
      if(local3 != null) {
        local3.removeListener(param2);
      }
    }

    public function addResourceListener(param1:Resource, param2:IResourceLoadingListener) : void {
      var local3:ResourceEntry = this.resourceEntries[param1];
      if(local3 == null) {
        local3 = new ResourceEntry(param1,param2);
        this.resourceEntries[param1] = local3;
      } else {
        local3.addListener(param2);
      }
    }

    public function onResourceLoadingStart(param1:Resource) : void {
      var local3:IResourceLoadingListener = null;
      var local2:ResourceEntry = this.resourceEntries[param1];
      local2.loadingStarted = true;
      for each(local3 in local2.listeners) {
        local3.onResourceLoadingStart(param1);
      }
    }

    public function onResourceLoadingComplete(param1:Resource) : void {
      var listener:IResourceLoadingListener = null;
      var resource:Resource = param1;
      var entry:ResourceEntry = this.processLoadedResource(resource);
      if(entry != null) {
        for each(listener in entry.listeners) {
          try {
            listener.onResourceLoadingComplete(resource);
          }
          catch(e:Error) {
            logger.error("ResourceLoader::onResourceLoadingComplete() loadingComplete listener invocation error: %1",[e.getStackTrace()]);
          }
        }
      }
      this.loadResources();
    }

    public function onResourceLoadingError(param1:Resource, param2:String) : void {
      var entry:ResourceEntry;
      var listener:IResourceLoadingListener = null;
      var resource:Resource = param1;
      var errorDescription:String = param2;
      resource.setFlags(ResourceFlags.DUMMY_DATA);
      entry = this.processLoadedResource(resource);
      try {
        for each(listener in entry.listeners) {
          listener.onResourceLoadingError(resource,errorDescription);
        }
      }
      catch(e:Error) {
        logger.error("ResourceLoader::onResourceLoadingError() %1 %2",[e.getStackTrace(),resource.id]);
      }
      this.loadResources();
    }

    public function onResourceLoadingFatalError(param1:Resource, param2:String) : void {
      var local4:IResourceLoadingListener = null;
      var local3:ResourceEntry = this.removeResourceFromLoading(param1);
      this.loadResources();
      for each(local4 in local3.listeners) {
        local4.onResourceLoadingFatalError(param1,param2);
      }
    }

    public function onSerializationComplete(param1:Resource, param2:ByteArray) : void {
      this.localStorageInternal.setResourceData(param1.id,param1.version.low,param2,param1.description,param1.classifier);
    }

    private function loadResources() : void {
      var local1:Resource = null;
      while(this.resourceQueue.size > 0 && this.numLoadingsInProgress < this.maxParallelLoadings) {
        local1 = Resource(this.resourceQueue.getData());
        ++this.numLoadingsInProgress;
        if(local1.isLoaded) {
          this.onResourceLoadingComplete(local1);
        } else if(localStorage != null && Boolean(localStorage.enabled)) {
          this.loadResourceFromLocalStorage(local1);
        } else {
          this.loadResourceFromNetwork(local1);
        }
      }
    }

    private function loadResourceFromLocalStorage(param1:Resource) : void {
      var local2:ByteArray = this.localStorageInternal.getResourceData(param1.id,param1.version.low,param1.classifier);
      param1.setFlags(ResourceFlags.LOCAL);
      if(local2 == null || !param1.loadBytes(local2,this)) {
        this.loadResourceFromNetwork(param1);
      }
    }

    private function loadResourceFromNetwork(param1:Resource) : void {
      param1.clearFlags(ResourceFlags.LOCAL);
      var local2:String = this.getResourceUrl(param1);
      param1.load(local2,this);
    }

    protected function getResourceUrl(param1:Resource) : String {
      return networkSerice.resourcesRootUrl + LoaderUtils.getResourcePath(param1.id.toByteArray(),param1.version.toByteArray());
    }

    private function processLoadedResource(param1:Resource) : ResourceEntry {
      param1.status = ResourceStatus.LOADED;
      var local2:ResourceEntry = this.removeResourceFromLoading(param1);
      if(!param1.hasAnyFlags(ResourceFlags.LOCAL | ResourceFlags.DUMMY_DATA)) {
        this.storeResourceLocally(param1);
      }
      return local2;
    }

    private function storeResourceLocally(param1:Resource) : void {
      if(localStorage != null && Boolean(localStorage.enabled)) {
        param1.serialize(this);
      }
    }

    private function removeResourceFromLoading(param1:Resource) : ResourceEntry {
      param1.clearFlags(ResourceFlags.IS_LOADING);
      --this.numLoadingsInProgress;
      var local2:ResourceEntry = this.resourceEntries[param1];
      delete this.resourceEntries[param1];
      return local2;
    }
  }
}

import platform.client.fp10.core.resource.IResourceLoadingListener;
import platform.client.fp10.core.resource.Resource;
class ResourceEntry {
  public var resource:Resource;
  public var listeners:Vector.<IResourceLoadingListener>;
  public var loadingStarted:Boolean;

  public function ResourceEntry(param1:Resource, param2:IResourceLoadingListener) {
    super();
    this.resource = param1;
    this.listeners = new Vector.<IResourceLoadingListener>(1);
    this.listeners[0] = param2;
  }

  public function addListener(param1:IResourceLoadingListener) : void {
    if(this.listeners.indexOf(param1) < 0) {
      this.listeners.push(param1);
      if(this.loadingStarted) {
        param1.onResourceLoadingStart(this.resource);
      }
    }
  }

  public function removeListener(param1:IResourceLoadingListener) : void {
    var local2:int = int(this.listeners.indexOf(param1));
    if(local2 >= 0) {
      this.listeners.splice(local2,1);
    }
  }
}

class QueueItem {
  public var data:Object;
  public var priority:int;
  public var next:QueueItem;
  public var prev:QueueItem;

  public function QueueItem(param1:Object, param2:int) {
    super();
    this.data = param1;
    this.priority = param2;
  }
}

class PriorityQueue {
  private var head:QueueItem;
  private var tail:QueueItem;
  private var _size:int;

  public function PriorityQueue() {
    super();
    this.head = new QueueItem(null,0);
    this.tail = new QueueItem(null,0);
    this.head.next = this.tail;
    this.tail.prev = this.head;
  }

  public function get size() : int {
    return this._size;
  }

  public function putData(param1:Object, param2:int) : void {
    var local3:QueueItem = this.tail.prev;
    while(local3 != this.head && local3.priority < param2) {
      local3 = local3.prev;
    }
    var local4:QueueItem = new QueueItem(param1,param2);
    local4.next = local3.next;
    local4.prev = local3;
    local4.next.prev = local4;
    local3.next = local4;
    ++this._size;
  }

  public function getData() : Object {
    if(this._size == 0) {
      return null;
    }
    var local1:QueueItem = this.head.next;
    local1.next.prev = local1.prev;
    local1.prev.next = local1.next;
    local1.next = null;
    local1.prev = null;
    --this._size;
    return local1.data;
  }
}
