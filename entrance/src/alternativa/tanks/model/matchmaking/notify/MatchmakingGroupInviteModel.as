package alternativa.tanks.model.matchmaking.notify {
  import alternativa.tanks.model.matchmaking.invitewindow.InviteWindowService;
  import alternativa.tanks.view.mainview.groupinvite.GroupInviteWindow;
  import alternativa.tanks.view.matchmaking.group.invite.GroupInviteNotification;
  import alternativa.tanks.view.matchmaking.group.invite.ResponseGroupInviteNotification;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.invite.IMatchmakingGroupInviteModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.invite.MatchmakingGroupInviteModelBase;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite.GroupInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite.GroupInviteServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupMembersEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;

  [ModelInfo]
  public class MatchmakingGroupInviteModel extends MatchmakingGroupInviteModelBase implements IMatchmakingGroupInviteModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var notificationService:INotificationService;

    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    [Inject]
    public static var inviteService:GroupInviteService;

    [Inject]
    public static var groupInviteWindowService:InviteWindowService;

    public function MatchmakingGroupInviteModel() {
      super();
    }

    public function objectLoaded() : void {
      matchmakingGroupService.addEventListener(MatchmakingGroupMembersEvent.INVITE,getFunctionWrapper(this.onInviteToGroup));
      inviteService.addEventListener(GroupInviteServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
      inviteService.addEventListener(GroupInviteServiceEvent.REJECT,getFunctionWrapper(this.onReject));
    }

    public function objectUnloaded() : void {
      matchmakingGroupService.removeEventListener(MatchmakingGroupMembersEvent.INVITE,getFunctionWrapper(this.onInviteToGroup));
      inviteService.removeEventListener(GroupInviteServiceEvent.ACCEPT,getFunctionWrapper(this.onAccept));
      inviteService.removeEventListener(GroupInviteServiceEvent.REJECT,getFunctionWrapper(this.onReject));
    }

    private function onInviteToGroup(param1:MatchmakingGroupMembersEvent) : void {
      server.sendInvite(param1.getUserId());
    }

    private function onAccept(param1:GroupInviteServiceEvent) : void {
      server.accept(param1.sender);
    }

    private function onReject(param1:GroupInviteServiceEvent) : void {
      server.reject(param1.sender);
    }

    public function sendInvite(param1:Long) : void {
      notificationService.addNotification(new GroupInviteNotification(param1));
    }

    public function accepted(param1:Long) : void {
      var local2:GroupInviteWindow = groupInviteWindowService.getInviteWindow();
      if(local2 != null) {
        local2.removeUser(param1);
      }
      notificationService.addNotification(new ResponseGroupInviteNotification(param1,TanksLocale.TEXT_GROUP_INVITE_RESPONSE_ACCEPT));
    }

    public function rejected(param1:Long) : void {
      notificationService.addNotification(new ResponseGroupInviteNotification(param1,TanksLocale.TEXT_GROUP_INVITE_RESPONSE_DECLINE));
    }

    public function rejectInvitationToGroupDisabled(param1:Long) : void {
      notificationService.addNotification(new ResponseGroupInviteNotification(param1,TanksLocale.TEXT_GROUP_INVITE_RESPONSE_INVITATIONS_DISABLED));
    }

    public function rejectUserAlreadyInGroup(param1:Long) : void {
      notificationService.addNotification(new ResponseGroupInviteNotification(param1,TanksLocale.TEXT_GROUP_INVITE_RESPONSE_USER_IN_OTHER_GROUP));
    }

    public function rejectUserAlreadyInBattle(param1:Long) : void {
      notificationService.addNotification(new ResponseGroupInviteNotification(param1,TanksLocale.TEXT_GROUP_INVITE_RESPONSE_USER_IN_BATTLE));
    }

    public function rejectUserOffline(param1:Long) : void {
      notificationService.addNotification(new ResponseGroupInviteNotification(param1,TanksLocale.TEXT_GROUP_INVITE_RESPONSE_USER_OFFLINE));
    }
  }
}
