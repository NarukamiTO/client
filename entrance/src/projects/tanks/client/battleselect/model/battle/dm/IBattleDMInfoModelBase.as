package projects.tanks.client.battleselect.model.battle.dm {
  import alternativa.types.Long;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public interface IBattleDMInfoModelBase {
    function addUser(param1:BattleInfoUser) : void;
    function removeUser(param1:Long) : void;
    function updateUserScore(param1:Long, param2:int) : void;
  }
}
