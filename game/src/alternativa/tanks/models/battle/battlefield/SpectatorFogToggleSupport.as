package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.camera.controllers.spectator.KeyboardHandler;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;

  public class SpectatorFogToggleSupport implements KeyboardHandler {
    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var battleService:BattleService;

    private static const FOG_TOGGLE_KEY:uint = Keyboard.F8;

    public function SpectatorFogToggleSupport() {
      super();
    }

    public function handleKeyDown(param1:KeyboardEvent) : void {
      if(param1.keyCode == FOG_TOGGLE_KEY && !battleInputService.isInputLocked()) {
        battleService.getBattleScene3D().toggleFog();
      }
    }

    public function handleKeyUp(param1:KeyboardEvent) : void {
    }
  }
}
