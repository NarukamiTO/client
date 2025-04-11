package alternativa.tanks.model.matchmaking.view {
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import alternativa.tanks.view.mainview.HolidayParams;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.matchmaking.modes.MatchmakingModeRank;
  import projects.tanks.client.battleselect.model.matchmaking.view.IMatchmakingLayoutModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.view.MatchmakingLayoutModelBase;

  [ModelInfo]
  public class MatchmakingLayoutModel extends MatchmakingLayoutModelBase implements IMatchmakingLayoutModelBase, ObjectUnloadListener {
    [Inject]
    public static var matchmakingFormService:MatchmakingFormService;

    public function MatchmakingLayoutModel() {
      super();
    }

    public function showMatchmakingView() : void {
      var local2:MatchmakingModeRank = null;
      var local3:HolidayParams = null;
      var local1:Dictionary = new Dictionary();
      for each(local2 in getInitParam().matchmakingModeRanks) {
        local1[local2.matchmakingMode] = local2.rank;
      }
      local3 = getInitParam().holidayEnabled ? new HolidayParams(getInitParam()) : null;
      matchmakingFormService.showMatchmakingLayout(local1,local3,getInitParam().minRankForProBattle);
    }

    public function hideMatchmakingView() : void {
      matchmakingFormService.hideMatchmakingLayout();
    }

    public function objectUnloaded() : void {
      matchmakingFormService.hideMatchmakingLayout();
    }
  }
}
