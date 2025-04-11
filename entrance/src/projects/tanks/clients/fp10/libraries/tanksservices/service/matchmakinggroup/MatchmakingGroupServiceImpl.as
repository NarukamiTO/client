package projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;

  public class MatchmakingGroupServiceImpl extends EventDispatcher implements MatchmakingGroupService {
    private var inMatchmaking:Boolean = false;
    private var usersInGroup:Vector.<Long> = new Vector.<Long>();

    public function MatchmakingGroupServiceImpl() {
      super();
    }

    public function isGroupInviteEnabled() : Boolean {
      return this.inMatchmaking;
    }

    public function enableGroupInvite() : void {
      this.inMatchmaking = true;
    }

    public function disableGroupInvite() : void {
      this.inMatchmaking = false;
    }

    public function inviteUserToGroup(param1:Long) : void {
      dispatchEvent(new MatchmakingGroupMembersEvent(MatchmakingGroupMembersEvent.INVITE,param1));
    }

    public function removeUserFromGroup(param1:Long) : void {
      dispatchEvent(new MatchmakingGroupMembersEvent(MatchmakingGroupMembersEvent.REMOVE,param1));
    }

    public function addUser(param1:Long) : void {
      this.usersInGroup.push(param1);
    }

    public function removeUser(param1:Long) : void {
      this.usersInGroup.splice(this.usersInGroup.indexOf(param1),1);
    }

    public function removeUsers() : void {
      this.usersInGroup = new Vector.<Long>();
    }

    public function isUserInGroup(param1:Long) : Boolean {
      return this.usersInGroup.indexOf(param1) >= 0;
    }
  }
}
