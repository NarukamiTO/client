package platform.client.fp10.core.resource {
  public interface IResourceLoader {
    function loadResource(param1:Resource, param2:IResourceLoadingListener, param3:int) : void;
    function removeResourceListener(param1:Resource, param2:IResourceLoadingListener) : void;
    function addResourceListener(param1:Resource, param2:IResourceLoadingListener) : void;
  }
}
