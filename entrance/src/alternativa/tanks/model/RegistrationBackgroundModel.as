package alternativa.tanks.model {
  import alternativa.tanks.controller.events.RegistrationBackgroundLoadedEvent;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import org.robotlegs.mvcs.Actor;

  public class RegistrationBackgroundModel extends Actor {
    private var _backgroundImage:Bitmap;

    public function RegistrationBackgroundModel() {
      super();
    }

    public function get backgroundImage() : Bitmap {
      return this._backgroundImage;
    }

    public function set rgbData(param1:BitmapData) : void {
      this._backgroundImage = new Bitmap(param1);
      dispatch(new RegistrationBackgroundLoadedEvent(this._backgroundImage));
    }
  }
}
