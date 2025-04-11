package platform.client.fp10.core.registry {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.ILockableResource;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.Resource;

  public interface ResourceRegistry {
    function registerTypeClasses(param1:int, param2:Class) : void;
    function getResourceClass(param1:int) : Class;
    function isTypeClassRegistered(param1:int) : Boolean;
    function registerResource(param1:Resource) : void;
    function unregisterResource(param1:Long) : void;
    function getResource(param1:Long) : Resource;
    function get resources() : Vector.<Resource>;
    function loadLazyResource(param1:Resource, param2:IResourceLoadingListener) : void;
    function removeLazyListener(param1:Resource, param2:IResourceLoadingListener) : void;
    function addLazyListener(param1:Resource, param2:IResourceLoadingListener) : void;
    function onPacketLoadingStart() : void;
    function onPacketLoadingStop() : void;
    function isLocked() : Boolean;
    function addLockedResource(param1:ILockableResource) : void;
    function stopLoadingResources() : void;
    function continueLoadingResources() : void;
    function isRegistered(param1:Long) : Boolean;
  }
}
