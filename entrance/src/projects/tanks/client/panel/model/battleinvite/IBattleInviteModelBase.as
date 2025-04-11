package projects.tanks.client.panel.model.battleinvite {
  import alternativa.types.Long;

  public interface IBattleInviteModelBase {
    function accepted(param1:Long) : void;
    function notify(param1:Long, param2:BattleInviteMessage) : void;
    function rejected(param1:Long) : void;
    function rejectedBattleNotFound(param1:Long) : void;
    function rejectedInvitationToBattleDisabled(param1:Long) : void;
    function rejectedPanelNotLoaded(param1:Long) : void;
    function rejectedUserAlreadyInBattle(param1:Long) : void;
    function rejectedUserInMatchBattle(param1:Long) : void;
    function rejectedUserOffline(param1:Long) : void;
  }
}
