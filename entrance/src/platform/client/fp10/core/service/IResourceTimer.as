package platform.client.fp10.core.service {
  import platform.client.fp10.core.resource.Resource;

  public interface IResourceTimer {
    function addResource(param1:Resource) : void;
    function removeResource(param1:Resource) : void;
    function getMaxReloadAttemts() : int;
  }
}
