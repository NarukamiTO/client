package alternativa.tanks.camera.controllers.spectator {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.camera.CameraBookmark;
  import alternativa.tanks.models.battle.battlefield.SpectatorFogToggleSupport;
  import alternativa.tanks.services.battleinput.BattleInputLockEvent;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import flash.events.KeyboardEvent;
  import platform.client.fp10.core.type.AutoClosable;

  public class SpectatorSupport implements AutoClosable, BookmarkListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleInputService:BattleInputService;

    private const cameraController:SpectatorCameraController = new SpectatorCameraController();
    private const playerCamera:PlayerCamera = new PlayerCamera(this.cameraController);
    private const bookmarksHandler:BookmarksHandler = new BookmarksHandler();

    private var keyboardHandlers:Vector.<KeyboardHandler>;

    public function SpectatorSupport() {
      super();
      this.keyboardHandlers = Vector.<KeyboardHandler>([this.playerCamera,this.bookmarksHandler,new SpectatorBonusRegionController(),new SpectatorFogToggleSupport()]);
      display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      battleService.setCameraController(this.cameraController);
      battleInputService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
      battleInputService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
      if(battleInputService.isInputLocked()) {
        this.cameraController.deactivateInputListeners();
      }
      this.bookmarksHandler.setListener(this);
    }

    private function onInputLocked(param1:BattleInputLockEvent) : void {
      this.cameraController.deactivateInputListeners();
    }

    private function onInputUnlocked(param1:BattleInputLockEvent) : void {
      this.cameraController.activateInputListeners();
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      var local2:KeyboardHandler = null;
      for each(local2 in this.keyboardHandlers) {
        local2.handleKeyDown(param1);
      }
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      var local2:KeyboardHandler = null;
      for each(local2 in this.keyboardHandlers) {
        local2.handleKeyUp(param1);
      }
    }

    public function onBookmarkSelected(param1:CameraBookmark) : void {
      this.playerCamera.unfocus();
      this.cameraController.setCameraState(param1.position,param1.eulerAnlges);
    }

    public function close() : void {
      display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      battleInputService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
      battleInputService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
      this.playerCamera.close();
    }
  }
}
