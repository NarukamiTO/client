package platform.client.fp10.core.registry {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameClass;
  import platform.client.fp10.core.type.impl.GameClass;

  public interface GameTypeRegistry {
    function createClass(param1:Long, param2:Vector.<Long>) : GameClass;
    function destroyClass(param1:Long) : void;
    function getClass(param1:Long) : IGameClass;
    function get classes() : Dictionary;
  }
}
