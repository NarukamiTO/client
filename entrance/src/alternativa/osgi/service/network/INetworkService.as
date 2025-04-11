package alternativa.osgi.service.network {
  public interface INetworkService {
    function get controlServerAddress() : String;
    function get controlServerPorts() : Vector.<int>;
    function get resourcesRootUrl() : String;
    function get secure() : Boolean;
    function getLastPort(param1:String) : int;
    function saveLastPort(param1:String, param2:int) : void;
  }
}
