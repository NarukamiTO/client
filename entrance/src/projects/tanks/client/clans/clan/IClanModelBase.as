package projects.tanks.client.clans.clan {
  import alternativa.types.Long;

  public interface IClanModelBase {
    function alreadyInAccepted(param1:String) : void;
    function alreadyInClan(param1:String) : void;
    function alreadyInClanIncoming(param1:String, param2:Long) : void;
    function alreadyInClanOutgoing(param1:String) : void;
    function alreadyInUserOutgoing(param1:String, param2:Long) : void;
    function maxMembers() : void;
    function userExist() : void;
    function userLowRank() : void;
    function userNotExist() : void;
  }
}
