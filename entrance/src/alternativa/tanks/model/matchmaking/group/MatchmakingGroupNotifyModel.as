package alternativa.tanks.model.matchmaking.group {
  import alternativa.tanks.service.matchmaking.MatchmakingGroupFormService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.IMatchmakingGroupNotifyModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingGroupNotifyModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MatchmakingUserData;
  import projects.tanks.client.battleselect.model.matchmaking.group.notify.MountItemsUserData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;

  [ModelInfo]
  public class MatchmakingGroupNotifyModel extends MatchmakingGroupNotifyModelBase implements IMatchmakingGroupNotifyModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var matchmakingFormService:MatchmakingGroupFormService;

    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    public function MatchmakingGroupNotifyModel() {
      super();
    }

    public function objectLoaded() : void {
      var local2:MatchmakingUserData = null;
      var local1:Boolean = false;
      for each(local2 in getInitParam().users) {
        if(local2.leader && local2.local) {
          local1 = true;
          break;
        }
      }
      if(local1) {
        matchmakingGroupService.enableGroupInvite();
      } else {
        matchmakingGroupService.disableGroupInvite();
      }
      matchmakingFormService.showGroupView(getInitParam().users,local1);
    }

    public function objectUnloaded() : void {
      matchmakingFormService.hideGroupView();
      matchmakingGroupService.disableGroupInvite();
    }

    public function addUser(param1:MatchmakingUserData) : void {
      matchmakingFormService.addUserToGroup(param1);
    }

    public function removeUser(param1:Long) : void {
      matchmakingFormService.removeUserFromGroup(param1);
    }

    public function userReady(param1:Long) : void {
      matchmakingFormService.showUserReady(param1);
    }

    public function userNotReady(param1:Long) : void {
      matchmakingFormService.showUserNotReady(param1);
    }

    public function userMountedItem(param1:MountItemsUserData) : void {
      matchmakingFormService.updateMountedItem(param1);
    }
  }
}
