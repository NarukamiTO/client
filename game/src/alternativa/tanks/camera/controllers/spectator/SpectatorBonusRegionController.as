package alternativa.tanks.camera.controllers.spectator {
  import alternativa.tanks.services.bonusregion.IBonusRegionService;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;

  public class SpectatorBonusRegionController implements KeyboardHandler {
    [Inject]
    public static var bonusRegionService:IBonusRegionService;

    public function SpectatorBonusRegionController() {
      super();
    }

    public function handleKeyDown(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.QUOTE) {
        bonusRegionService.toggleRegionsVisible();
      }
    }

    public function handleKeyUp(param1:KeyboardEvent) : void {
    }
  }
}
