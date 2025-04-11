package platform.client.fp10.core.type {
  import alternativa.types.Long;
  import platform.client.fp10.core.network.ICommandSender;

  public interface ISpace {
    function get id() : Long;
    function get commandSender() : ICommandSender;
    function getObject(param1:Long) : IGameObject;
    function get rootObject() : IGameObject;
    function createObject(param1:Long, param2:IGameClass, param3:String) : IGameObject;
    function destroyObject(param1:Long) : void;
    function get objects() : Vector.<IGameObject>;
    function close() : void;
    function addEventListener(param1:ISpaceListener) : void;
    function removeEventListener(param1:ISpaceListener) : void;
  }
}
