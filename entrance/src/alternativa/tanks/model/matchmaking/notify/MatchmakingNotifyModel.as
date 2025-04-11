package alternativa.tanks.model.matchmaking.notify {
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.model.matchmaking.MatchmakingQueue;
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import projects.tanks.client.battleselect.model.matchmaking.notify.IMatchmakingNotifyModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.notify.MatchmakingNotifyModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.flash.commons.services.notification.INotificationService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class MatchmakingNotifyModel extends MatchmakingNotifyModelBase implements IMatchmakingNotifyModelBase {
    [Inject]
    public static var matchmakingFormService:MatchmakingFormService;

    [Inject]
    public static var loaderService:ILoaderWindowService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var notificationService:INotificationService;

    public function MatchmakingNotifyModel() {
      super();
    }

    public function userRegistrationSuccessful(param1:int, param2:MatchmakingMode) : void {
      MatchmakingQueue(object.adapt(MatchmakingQueue)).registrationSuccessful();
      matchmakingFormService.showRegistrationWindow(param1,param2);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.onBeginLayoutSwitch);
    }

    private function onBeginLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state == LayoutState.BATTLE) {
        matchmakingFormService.hideRegistrationWindow();
      }
    }

    public function registrationCancelled() : void {
      MatchmakingQueue(object.adapt(MatchmakingQueue)).registrationCancelled();
      matchmakingFormService.hideRegistrationWindow();
    }

    public function registrationTimeout() : void {
      matchmakingFormService.hideRegistrationWindow();
      notificationService.addNotification(new MatchmakingTimeoutNotification());
    }
  }
}
