package alternativa.tanks.models.battle.battlefield {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.camera.FollowCameraController;
  import alternativa.tanks.camera.FreeCameraController;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import flash.events.KeyboardEvent;
  import platform.client.fp10.core.type.AutoClosable;

  public class FreeCameraSupport implements AutoClosable {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleInputService:BattleInputService;

    [Inject]
    public static var battleService:BattleService;

    private var followCameraController:FollowCameraController;
    private var freeCameraController:FreeCameraController;

    public function FreeCameraSupport(param1:FollowCameraController) {
      super();
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
    }

    private function toggleFreeCamera() : void {
    }

    [Obfuscation(rename="false")]
    public function close() : void {
    }
  }
}
