package alternativa.tanks.models.foreignclan {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.clans.panel.foreignclan.ForeignClanData;

  public interface ForeignClanService extends IEventDispatcher {
    function showForeignClan(param1:ForeignClanData) : void;
    function sendRequest() : void;
    function acceptRequest() : void;
    function revokeRequest() : void;
    function userSmallRankForAddClan() : void;
    function onJoinClan(param1:String) : void;
    function destroyWindow() : void;
    function alreadyInClanOutgoing() : void;
    function alreadyInIncoming() : void;
    function clanBlocked(param1:String) : void;
    function resetWindow() : void;
    function isShowForeignClan() : Boolean;
  }
}
