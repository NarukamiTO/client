package utils.resource {
  import platform.client.fp10.core.resource.Resource;

  public interface IResourceLoadingComplete {
    function onLoadingComplete(param1:Resource) : void;
  }
}
