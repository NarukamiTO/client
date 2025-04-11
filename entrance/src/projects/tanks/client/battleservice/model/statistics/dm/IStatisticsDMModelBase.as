package projects.tanks.client.battleservice.model.statistics.dm {
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserStat;

  public interface IStatisticsDMModelBase {
    function changeUserStat(param1:UserStat) : void;
    function refreshUsersStat(param1:Vector.<UserStat>) : void;
    function userConnect(param1:Long, param2:Vector.<UserInfo>) : void;
    function userDisconnect(param1:Long) : void;
  }
}
