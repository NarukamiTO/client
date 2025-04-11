package projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface MatchmakingGroupService extends IEventDispatcher {
    function isGroupInviteEnabled() : Boolean;
    function enableGroupInvite() : void;
    function disableGroupInvite() : void;
    function inviteUserToGroup(param1:Long) : void;
    function removeUserFromGroup(param1:Long) : void;
    function addUser(param1:Long) : void;
    function removeUser(param1:Long) : void;
    function removeUsers() : void;
    function isUserInGroup(param1:Long) : Boolean;
  }
}
