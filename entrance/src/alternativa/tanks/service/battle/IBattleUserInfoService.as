package alternativa.tanks.service.battle {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;

  public interface IBattleUserInfoService {
    function getBattle(param1:Long) : IGameObject;
    function connect(param1:Long, param2:IGameObject) : void;
    function disconnect(param1:Long) : void;
    function userInBattle(param1:Long) : Boolean;
    function deleteBattleItem(param1:IGameObject) : void;
  }
}
