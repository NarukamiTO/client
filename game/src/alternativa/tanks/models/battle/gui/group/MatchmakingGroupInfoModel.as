package alternativa.tanks.models.battle.gui.group {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.battle.gui.group.IMatchmakingGroupInfoModelBase;
  import projects.tanks.client.battlefield.models.battle.gui.group.MatchmakingGroupInfoModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.group.IGroupInfoService;

  [ModelInfo]
  public class MatchmakingGroupInfoModel extends MatchmakingGroupInfoModelBase implements IMatchmakingGroupInfoModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var groupInfoService:IGroupInfoService;

    public function MatchmakingGroupInfoModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:* = undefined;
      groupInfoService.setHasGroups(getInitParam().hasGroups);
      for each(local1 in getInitParam().groupUserIds) {
        groupInfoService.addGroupUser(local1);
      }
    }

    public function objectUnloaded() : void {
      groupInfoService.setHasGroups(false);
    }
  }
}
