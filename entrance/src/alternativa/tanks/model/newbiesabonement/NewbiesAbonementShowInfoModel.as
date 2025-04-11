package alternativa.tanks.model.newbiesabonement {
  import alternativa.tanks.gui.IDestroyWindow;
  import alternativa.tanks.gui.newbiesabonement.NewbiesAbonementInfoWindow;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.panel.model.newbiesabonement.INewbiesAbonementShowInfoModelBase;
  import projects.tanks.client.panel.model.newbiesabonement.NewbiesAbonementShowInfoModelBase;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class NewbiesAbonementShowInfoModel extends NewbiesAbonementShowInfoModelBase implements INewbiesAbonementShowInfoModelBase, ObjectUnloadListener {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private static const MILLISECONDS_IN_SECOND:int = 1000;

    private var expiredDateNewbiesAbonement:Date;
    private var crystalBonusInPersent:int;
    private var scoreBonusInPercent:int;

    public function NewbiesAbonementShowInfoModel() {
      super();
    }

    public function showInfoWindow(param1:int, param2:int, param3:int) : void {
      this.expiredDateNewbiesAbonement = new Date(new Date().getTime() + param1 * MILLISECONDS_IN_SECOND);
      this.crystalBonusInPersent = param2;
      this.scoreBonusInPercent = param3;
      if(lobbyLayoutService.isSwitchInProgress() || lobbyLayoutService.getCurrentState() == LayoutState.BATTLE) {
        this.showNewbiesInfoWindowLater();
      } else {
        this.showNewbiesInfoWindow();
      }
    }

    private function showNewbiesInfoWindowLater() : void {
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state != LayoutState.BATTLE) {
        lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
        this.showNewbiesInfoWindow();
      }
    }

    private function showNewbiesInfoWindow() : void {
      var local1:IDestroyWindow = null;
      local1 = new NewbiesAbonementInfoWindow(this.expiredDateNewbiesAbonement,this.crystalBonusInPersent,this.scoreBonusInPercent);
      putData(IDestroyWindow,local1);
    }

    public function objectUnloaded() : void {
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
      var local1:IDestroyWindow = IDestroyWindow(getData(IDestroyWindow));
      if(local1 != null) {
        local1.destroy();
      }
    }
  }
}
