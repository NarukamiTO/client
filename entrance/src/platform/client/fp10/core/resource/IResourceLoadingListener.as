package platform.client.fp10.core.resource {
  public interface IResourceLoadingListener {
    function onResourceLoadingStart(param1:Resource) : void;
    function onResourceLoadingComplete(param1:Resource) : void;
    function onResourceLoadingError(param1:Resource, param2:String) : void;
    function onResourceLoadingFatalError(param1:Resource, param2:String) : void;
  }
}
