package alternativa.tanks.models.user {
  import alternativa.tanks.gui.notinclan.NotInClanPanel;
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.tanks.service.panel.IPanelView;
  import forms.events.MainButtonBarEvents;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.user.ClanUserLoaderModelBase;
  import projects.tanks.client.clans.user.IClanUserLoaderModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import services.buttonbar.IButtonBarService;

  [ModelInfo]
  public class ClanUserLoaderModel extends ClanUserLoaderModelBase implements IClanUserLoaderModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var clanUserService:ClanUserService;

    [Inject]
    public static var buttonBarService:IButtonBarService;

    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    [Inject]
    public static var panelView:IPanelView;

    public function ClanUserLoaderModel() {
      super();
    }

    public function objectLoadedPost() : void {
      if(IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace()) {
        buttonBarService.addEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
        clanUserService.addEventListener(ClanUserServiceEvent.HIDE_CLAN_WINDOW,getFunctionWrapper(this.onCloseNotInClanWindow));
      }
    }

    private function onCloseNotInClanWindow(param1:ClanUserServiceEvent) : void {
      server.hideClan();
      panelView.getPanel().buttonBar.clanButton.enable = true;
    }

    private function onButtonBarButtonClick(param1:MainButtonBarEvents) : void {
      if(param1.typeButton == MainButtonBarEvents.CLAN && !clanUserInfoService.clanMember) {
        panelView.getPanel().buttonBar.clanButton.enable = false;
        modalLoaderService.show();
        server.showClan();
      }
    }

    public function showWindow() : void {
      modalLoaderService.hideForcibly();
      var local1:NotInClanPanel = new NotInClanPanel(object);
      clanService.notInClanPanel = local1;
    }

    public function objectUnloaded() : void {
      buttonBarService.removeEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
      clanUserService.removeEventListener(ClanUserServiceEvent.HIDE_CLAN_WINDOW,getFunctionWrapper(this.onCloseNotInClanWindow));
      if(clanService.notInClanPanel != null) {
        clanService.notInClanPanel.destroy();
      }
    }
  }
}
