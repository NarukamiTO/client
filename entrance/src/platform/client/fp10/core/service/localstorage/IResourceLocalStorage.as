package platform.client.fp10.core.service.localstorage {
  public interface IResourceLocalStorage {
    function get enabled() : Boolean;
    function set enabled(param1:Boolean) : void;
    function clear() : void;
  }
}
