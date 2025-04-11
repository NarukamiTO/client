package projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.invite {
  import alternativa.types.Long;

  public interface IMatchmakingGroupInviteModelBase {
    function accepted(param1:Long) : void;
    function rejectInvitationToGroupDisabled(param1:Long) : void;
    function rejectUserAlreadyInGroup(param1:Long) : void;
    function rejectUserOffline(param1:Long) : void;
    function rejected(param1:Long) : void;
    function sendInvite(param1:Long) : void;
  }
}
