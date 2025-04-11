package alternativa.tanks.gui.device {
  import flash.events.Event;

  public class DevicesLoadedEvent extends Event {
    public static const DEVICES_LOADED:String = "DEVICES_LOADED";

    public function DevicesLoadedEvent() {
      super(DEVICES_LOADED);
    }
  }
}
