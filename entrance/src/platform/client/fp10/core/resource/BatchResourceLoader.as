package platform.client.fp10.core.resource {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import platform.client.fp10.core.registry.ResourceRegistry;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.errormessage.errors.ResourceError;
  import platform.client.fp10.core.type.AutoClosable;

  public class BatchResourceLoader implements IResourceLoadingListener, AutoClosable {
    [Inject]
    public static var logService:LogService;

    private static var logger:Logger;

    [Inject]
    public static var messageBoxService:IErrorMessageService;

    [Inject]
    public static var resourceLoader:IResourceLoader;

    [Inject]
    public static var resourceRegistry:ResourceRegistry;

    private var callback:Function;
    private var numLoadedResources:int;
    private var numResources:int;

    public function BatchResourceLoader(param1:Function) {
      super();
      if(param1 == null) {
        throw new ArgumentError("Parameter listener is null");
      }
      this.callback = param1;
    }

    private static function getLogger() : Logger {
      return logger || (logger = logService.getLogger(ResourceLogChannel.NAME));
    }

    public function load(param1:Vector.<Resource>) : void {
      var local2:Resource = null;
      if(param1 == null) {
        throw new ArgumentError("Parameter resources is null");
      }
      if(param1.length == 0) {
        throw new ArgumentError("Number of resources is zero");
      }
      ++this.numResources;
      for each(local2 in param1) {
        if(local2.isHasDependencies()) {
          local2.setBatchLoader(this);
        } else {
          this.loadResource(local2);
        }
      }
      this.onResourceLoadingComplete(null);
    }

    public function loadResource(param1:Resource) : void {
      ++this.numResources;
      resourceLoader.loadResource(param1,this,ResourcePriority.NORMAL);
    }

    public function onResourceLoadingStart(param1:Resource) : void {
    }

    public function onResourceLoadingComplete(param1:Resource) : void {
      ++this.numLoadedResources;
      if(this.numLoadedResources == this.numResources) {
        this.completeBatchLoading();
      }
    }

    public function onResourceLoadingError(param1:Resource, param2:String) : void {
      getLogger().error("resource: %1, error: %2",[param1,param2]);
      this.onResourceLoadingComplete(param1);
    }

    public function onResourceLoadingFatalError(param1:Resource, param2:String) : void {
      var local3:ResourceError = new ResourceError(param1,param2);
      getLogger().error(local3.getMessage());
      messageBoxService.showMessage(local3);
    }

    public function close() : void {
      this.numResources = -1;
      this.callback = null;
    }

    private function completeBatchLoading() : void {
      this.numResources = 0;
      this.callback.call();
    }
  }
}
