package utils.resource {
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;

  public class ResourceLoadingWrapper implements IResourceLoadingListener {
    private var listener:IResourceLoadingComplete;

    public function ResourceLoadingWrapper(param1:IResourceLoadingComplete) {
      super();
      this.listener = param1;
    }

    public function onResourceLoadingStart(param1:Resource) : void {
    }

    public function onResourceLoadingProgress(param1:Resource, param2:int) : void {
    }

    public function onResourceLoadingComplete(param1:Resource) : void {
      this.listener.onLoadingComplete(param1);
    }

    public function onResourceLoadingError(param1:Resource, param2:String) : void {
      throw new Error("Ошибка загрузки ресурса (id: " + param1.id + ")");
    }

    public function onResourceLoadingFatalError(param1:Resource, param2:String) : void {
      throw new Error("Ошибка загрузки ресурса (id: " + param1.id + ")");
    }
  }
}
