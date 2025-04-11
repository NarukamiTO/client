package projects.tanks.client.clans.user {
  import platform.client.fp10.core.type.IGameObject;

  public interface IClanUserModelBase {
    function alreadyInAccepted(param1:String) : void;
    function alreadyInClan() : void;
    function alreadyInClanOutgoing(param1:String, param2:IGameObject) : void;
    function alreadyInIncoming(param1:String, param2:IGameObject) : void;
    function alreadyInOutgoing(param1:String) : void;
    function clanBlocked() : void;
    function clanExist() : void;
    function clanIncomingRequestDisabled() : void;
    function clanNotExist() : void;
    function creatorLeaveOfClanIfEmptyClan() : void;
    function joinClan() : void;
    function leftClan(param1:int) : void;
    function removeClanBonuses() : void;
    function showAlertFullClan() : void;
    function updateStatusBonusesClan(param1:Boolean) : void;
    function userLowRank() : void;
  }
}
