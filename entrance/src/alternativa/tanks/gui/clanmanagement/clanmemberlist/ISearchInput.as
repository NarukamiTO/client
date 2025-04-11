package alternativa.tanks.gui.clanmanagement.clanmemberlist {
  import alternativa.types.Long;

  public interface ISearchInput {
    function onUidExist() : void;
    function onUidNotExist() : void;
    function onAlreadyInAccepted(param1:String) : void;
    function onAlreadyInOutgoing(param1:String) : void;
    function onAlreadyInIncoming(param1:Long, param2:String) : void;
    function onUserLowRank(param1:String) : void;
    function onAlreadyInClan(param1:String) : void;
    function onRestrictionOnJoin(param1:String) : void;
    function clanBlocked(param1:String) : void;
    function incomingRequestDisabled(param1:String) : void;
  }
}
