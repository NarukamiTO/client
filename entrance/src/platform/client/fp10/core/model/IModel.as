package platform.client.fp10.core.model {
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;

  public interface IModel {
    function invoke(param1:Long, param2:ProtocolBuffer) : void;
    function get id() : Long;
    function putInitParams(param1:Object) : void;
    function clearInitParams() : void;
    function getData(param1:Class) : Object;
    function putData(param1:Class, param2:Object) : void;
    function clearData(param1:Class) : Object;
  }
}
