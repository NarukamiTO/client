package platform.client.fp10.core.type {
  import alternativa.types.Long;

  public interface IGameObject {
    function get id() : Long;
    function get name() : String;
    function get gameClass() : IGameClass;
    function get space() : ISpace;
    function hasModel(param1:Class) : Boolean;
    function adapt(param1:Class) : Object;
    function event(param1:Class) : Object;
  }
}
