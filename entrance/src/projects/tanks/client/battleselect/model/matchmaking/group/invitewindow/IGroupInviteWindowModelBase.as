package projects.tanks.client.battleselect.model.matchmaking.group.invitewindow {
  import alternativa.types.Long;

  public interface IGroupInviteWindowModelBase {
    function setAvailableToInviteUsers(param1:Vector.<MatchMakingUserInfo>) : void;
    function show(param1:Vector.<Long>, param2:Vector.<Long>) : void;
  }
}
