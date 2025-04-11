package projects.tanks.client.clans.panel.foreignclan {
  public interface IForeignClanModelBase {
    function alreadyInClanOutgoing(param1:String) : void;
    function alreadyInIncoming(param1:String) : void;
    function clanBlocked(param1:String) : void;
    function onJoinClan(param1:String) : void;
    function showForeignClan(param1:ForeignClanData) : void;
    function userSmallRankForAddClan() : void;
  }
}
