package alternativa.tanks.models.panel {
  import alternativa.tanks.models.service.ClanService;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import alternativa.tanks.service.panel.IPanelView;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.panel.loadingclan.ClanLoadingPanelModelBase;
  import projects.tanks.client.clans.panel.loadingclan.IClanLoadingPanelModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;
  import services.buttonbar.IButtonBarService;
  import services.contextmenu.ContextMenuServiceEvent;
  import services.contextmenu.IContextMenuService;

  [ModelInfo]
  public class ClanLoadingPanelModel extends ClanLoadingPanelModelBase implements IClanLoadingPanelModelBase, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var buttonBarService:IButtonBarService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var panel:IPanelView;

    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanPanelNotification:ClanPanelNotificationService;

    public function ClanLoadingPanelModel() {
      super();
    }

    public function objectLoaded() : void {
      contextMenuService.addEventListener(ContextMenuServiceEvent.SHOW_CLAN,getFunctionWrapper(this.onShowClan));
      userPropertiesService.addEventListener(UserPropertiesServiceEvent.UPDATE_RANK,getFunctionWrapper(this.updateRank));
      clanService.minRankForCreateClan = getInitParam().minRankForCreateClan;
      clanPanelNotification.clanButtonVisible = getInitParam().clanButtonVisible;
    }

    private function updateRank(param1:UserPropertiesServiceEvent) : void {
      clanPanelNotification.clanButtonVisible = userPropertiesService.rank >= getInitParam().minRankForCreateClan;
    }

    private function onShowClan(param1:ContextMenuServiceEvent) : void {
      server.showClan(param1.clanId);
    }

    public function objectUnloaded() : void {
      contextMenuService.removeEventListener(ContextMenuServiceEvent.SHOW_CLAN,getFunctionWrapper(this.onShowClan));
    }
  }
}
