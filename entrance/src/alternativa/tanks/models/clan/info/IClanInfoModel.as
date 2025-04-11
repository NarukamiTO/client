package alternativa.tanks.models.clan.info {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  [ModelInterface]
  public interface IClanInfoModel {
    function getClanName() : String;
    function getClanTag() : String;
    function getDescription() : String;
    function getClanFlag() : ClanFlag;
    function getRankIndexForAddClan() : int;
    function incomingRequestEnabled() : Boolean;
    function getCreatorId() : Long;
    function getCreateTime() : Long;
    function getUsersCount() : int;
  }
}
