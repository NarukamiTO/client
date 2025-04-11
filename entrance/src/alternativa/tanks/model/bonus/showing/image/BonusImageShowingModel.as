package alternativa.tanks.model.bonus.showing.image {
  import alternativa.tanks.gui.CongratulationsWindowConfiscate;
  import alternativa.tanks.gui.CongratulationsWindowPresent;
  import alternativa.tanks.gui.IDestroyWindow;
  import alternativa.tanks.model.bonus.showing.info.BonusInfo;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.panel.model.bonus.showing.image.BonusImageShowingModelBase;
  import projects.tanks.client.panel.model.bonus.showing.image.IBonusImageShowingModelBase;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class BonusImageShowingModel extends BonusImageShowingModelBase implements IBonusImageShowingModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    public function BonusImageShowingModel() {
      super();
    }

    public function objectLoadedPost() : void {
      if(Boolean(lobbyLayoutService.isSwitchInProgress()) || lobbyLayoutService.getCurrentState() == LayoutState.BATTLE) {
        this.showCongratulationsWindowLater();
      } else {
        this.createCongratulationsWindow();
      }
    }

    private function showCongratulationsWindowLater() : void {
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state != LayoutState.BATTLE) {
        lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
        this.createCongratulationsWindow();
      }
    }

    private function createCongratulationsWindow() : void {
      var local2:IDestroyWindow = null;
      var local1:BonusInfo = BonusInfo(object.adapt(BonusInfo));
      if(local1.getImage() == null) {
        local2 = new CongratulationsWindowPresent(null,getInitParam().image,local1.getTopText(),local1.getBottomText(),object);
      } else {
        local2 = new CongratulationsWindowConfiscate(object,getInitParam().image.data,local1.getImage().data,local1.getTopText(),local1.getBottomText());
      }
      putData(IDestroyWindow,local2);
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
