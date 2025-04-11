package platform.client.fp10.core.registry {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.ISpace;

  public interface SpaceRegistry {
    function addSpace(param1:ISpace) : void;
    function removeSpace(param1:ISpace) : void;
    function get spaces() : Vector.<ISpace>;
    function getSpace(param1:Long) : ISpace;
    function get currentSpace() : ISpace;
    function set currentSpace(param1:ISpace) : void;
  }
}
