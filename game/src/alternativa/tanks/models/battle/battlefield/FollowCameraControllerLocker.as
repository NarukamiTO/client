package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.camera.FollowCameraController;
  import alternativa.tanks.services.battleinput.BattleInputLockEvent;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import platform.client.fp10.core.type.AutoClosable;

  public class FollowCameraControllerLocker implements AutoClosable {
    [Inject]
    public static var battleInputLockService:BattleInputService;

    private var controller:FollowCameraController;

    public function FollowCameraControllerLocker(param1:FollowCameraController) {
      super();
      this.controller = param1;
      battleInputLockService.addEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
      battleInputLockService.addEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
    }

    private function onInputLocked(param1:BattleInputLockEvent) : void {
      this.controller.inputLocked = true;
    }

    private function onInputUnlocked(param1:BattleInputLockEvent) : void {
      this.controller.inputLocked = false;
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.controller = null;
      battleInputLockService.removeEventListener(BattleInputLockEvent.INPUT_LOCKED,this.onInputLocked);
      battleInputLockService.removeEventListener(BattleInputLockEvent.INPUT_UNLOCKED,this.onInputUnlocked);
    }
  }
}
