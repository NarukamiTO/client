package alternativa.tanks.model.matchmaking.spectator {
  import alternativa.tanks.service.battlelist.MatchmakingEvent;
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.matchmaking.spectator.IMatchmakingSpectatorEntranceModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.spectator.MatchmakingSpectatorEntranceModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;

  [ModelInfo]
  public class MatchmakingSpectatorEntranceModel extends MatchmakingSpectatorEntranceModelBase implements IMatchmakingSpectatorEntranceModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var matchmakingFormService:MatchmakingFormService;

    [Inject]
    public static var alertService:IAlertService;

    public function MatchmakingSpectatorEntranceModel() {
      super();
    }

    private function onEnter(param1:MatchmakingEvent) : * {
      server.enter(param1.getMode());
    }

    public function objectLoaded() : void {
      matchmakingFormService.addEventListener(MatchmakingEvent.ENTER_AS_SPECTATOR,getFunctionWrapper(this.onEnter));
    }

    public function objectUnloaded() : void {
      matchmakingFormService.removeEventListener(MatchmakingEvent.ENTER_AS_SPECTATOR,getFunctionWrapper(this.onEnter));
    }

    public function enterFailedNoSuitableBattles() : void {
      alertService.showOkAlert("There are no suitable battles");
    }
  }
}
