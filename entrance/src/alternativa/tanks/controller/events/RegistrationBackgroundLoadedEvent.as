package alternativa.tanks.controller.events {
  import flash.display.Bitmap;
  import flash.events.Event;

  public class RegistrationBackgroundLoadedEvent extends Event {
    public static const LOADED:String = "RegistrationBackgroundLoadedEvent.LOADED";

    private var _backgroundImage:Bitmap;

    public function RegistrationBackgroundLoadedEvent(param1:Bitmap) {
      super(LOADED);
      this._backgroundImage = param1;
    }

    public function get backgroundImage() : Bitmap {
      return this._backgroundImage;
    }
  }
}
