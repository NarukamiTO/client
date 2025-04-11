package alternativa.tanks.models.user.acceptednotificator {
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.user.acceptednotificator.ClanUserAcceptedNotificatorModelBase;
  import projects.tanks.client.clans.user.acceptednotificator.IClanUserAcceptedNotificatorModelBase;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class ClanUserAcceptedNotificatorModel extends ClanUserAcceptedNotificatorModelBase implements IClanUserAcceptedNotificatorModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var clanPanelNotificationService:ClanPanelNotificationService;

    private var clanId:Long;

    public function ClanUserAcceptedNotificatorModel() {
      super();
    }

    public function onAdding(param1:Long) : void {
      this.clanId = param1;
      clanPanelNotificationService.add();
    }

    public function onRemoved(param1:Long) : void {
      this.clanId = null;
      clanPanelNotificationService.remove();
    }

    public function objectLoaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onLoadedLayout));
      if(getInitParam().objects.length > 0) {
        this.clanId = getInitParam().objects[0];
      }
    }

    private function removeNotification() : void {
      if(this.clanId != null) {
        server.removeNotification(this.clanId);
      }
    }

    private function onLoadedLayout(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state == LayoutState.CLAN) {
        this.removeNotification();
      }
    }

    private function isServiceSpace() : Boolean {
      return IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace();
    }

    public function objectUnloaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onLoadedLayout));
    }
  }
}
