package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  import flash.ui.Keyboard;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenStateService;

  public class AlertUtils {
    [Inject]
    public static var fullscreenStateService:FullscreenStateService;

    public function AlertUtils() {
      super();
    }

    public static function isConfirmationKey(param1:uint) : Boolean {
      return param1 == Keyboard.ENTER;
    }

    public static function isCancelKey(param1:uint) : Boolean {
      return param1 == Keyboard.ESCAPE && !fullscreenStateService.isFullscreen();
    }
  }
}
