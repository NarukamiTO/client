package alternativa.tanks.service.device {
  import flash.events.Event;

  public class UpdateDevicesEvent extends Event {
    public static const EVENT:String = "UpdateDevicesEvent";

    public function UpdateDevicesEvent() {
      super(EVENT);
    }
  }
}
