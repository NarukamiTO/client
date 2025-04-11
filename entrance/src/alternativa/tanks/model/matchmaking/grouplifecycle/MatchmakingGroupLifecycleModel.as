package alternativa.tanks.model.matchmaking.grouplifecycle {
  import alternativa.tanks.controllers.mainview.MatchmakingGroupEvent;
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.IMatchmakingGroupLifecycleModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.grouplifecycle.MatchmakingGroupLifecycleModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupMembersEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;

  [ModelInfo]
  public class MatchmakingGroupLifecycleModel extends MatchmakingGroupLifecycleModelBase implements IMatchmakingGroupLifecycleModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var matchmakingFormService:MatchmakingFormService;

    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    public function MatchmakingGroupLifecycleModel() {
      super();
    }

    public function objectLoaded() : void {
      matchmakingFormService.addEventListener(MatchmakingGroupEvent.CREATE,getFunctionWrapper(this.onCreateGroup));
      matchmakingFormService.addEventListener(MatchmakingGroupEvent.LEAVE,getFunctionWrapper(this.onLeaveGroup));
      matchmakingGroupService.addEventListener(MatchmakingGroupMembersEvent.REMOVE,getFunctionWrapper(this.onRemoveUser));
    }

    public function objectUnloaded() : void {
      matchmakingFormService.removeEventListener(MatchmakingGroupEvent.CREATE,getFunctionWrapper(this.onCreateGroup));
      matchmakingFormService.removeEventListener(MatchmakingGroupEvent.LEAVE,getFunctionWrapper(this.onLeaveGroup));
      matchmakingGroupService.removeEventListener(MatchmakingGroupMembersEvent.REMOVE,getFunctionWrapper(this.onRemoveUser));
    }

    private function onCreateGroup(param1:MatchmakingGroupEvent) : void {
      server.createGroup();
    }

    private function onLeaveGroup(param1:MatchmakingGroupEvent) : void {
      server.leaveGroup();
    }

    private function onRemoveUser(param1:MatchmakingGroupMembersEvent) : void {
      server.removeUser(param1.getUserId());
    }
  }
}
