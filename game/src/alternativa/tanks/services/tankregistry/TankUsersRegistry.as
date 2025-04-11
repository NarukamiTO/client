package alternativa.tanks.services.tankregistry {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;

  public interface TankUsersRegistry {
    function addUser(param1:IGameObject) : void;
    function removeUser(param1:IGameObject) : void;
    function getUserCount() : int;
    function getUsers() : Vector.<IGameObject>;
    function getUser(param1:Long) : IGameObject;
    function getLocalUser() : IGameObject;
    function existLocalUser() : Boolean;
  }
}
