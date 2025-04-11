package projects.tanks.clients.flash.commons.services.stagequality {
  import alternativa.osgi.service.display.IDisplay;
  import flash.display.StageQuality;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class StageQualityService implements IStageQualityService {
    [Inject]
    public static var display:IDisplay;

    private var _lobbyLayoutService:ILobbyLayoutService;

    public function StageQualityService(param1:ILobbyLayoutService) {
      super();
      this._lobbyLayoutService = param1;
      this._lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.onEndLayoutSwitch);
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      this.updateStageQuality(param1.state);
    }

    private function updateStageQuality(param1:LayoutState) : void {
      if(GPUCapabilities.gpuEnabled) {
        this.updateGPU(param1);
      } else {
        this.updateCPU(param1);
      }
    }

    private function updateGPU(param1:LayoutState) : void {
      if(param1 == LayoutState.BATTLE_SELECT || param1 == LayoutState.MATCHMAKING) {
        display.stage.quality = StageQuality.LOW;
      } else {
        display.stage.quality = StageQuality.MEDIUM;
      }
    }

    private function updateCPU(param1:LayoutState) : void {
      if(param1 == LayoutState.BATTLE) {
        display.stage.quality = StageQuality.LOW;
      } else if(param1 == LayoutState.BATTLE_SELECT) {
        display.stage.quality = StageQuality.MEDIUM;
      } else if(param1 == LayoutState.MATCHMAKING) {
        display.stage.quality = StageQuality.LOW;
      } else if(param1 == LayoutState.GARAGE) {
        if(this._lobbyLayoutService.inBattle()) {
          display.stage.quality = StageQuality.LOW;
        } else {
          display.stage.quality = StageQuality.MEDIUM;
        }
      }
    }
  }
}
