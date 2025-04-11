package alternativa.tanks.models.clan.membersdata {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  public interface ClanMembersDataService {
    function getKills(param1:Long) : int;
    function getScore(param1:Long) : int;
    function getDeaths(param1:Long) : int;
    function getKillDeathRatio(param1:Long) : Number;
    function getDateInClanInSec(param1:Long) : int;
    function getPermission(param1:Long) : ClanPermission;
    function setData(param1:UserData) : void;
    function getLastVisitDateInSec(param1:Long) : Long;
    function getClanMemberData(param1:Long) : Object;
  }
}
