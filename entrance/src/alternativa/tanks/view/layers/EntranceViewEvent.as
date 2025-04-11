package alternativa.tanks.view.layers {
  import flash.events.Event;

  public class EntranceViewEvent extends Event {
    public static var SHOW:String = "EntranceViewEvent::Show";
    public static var HIDE:String = "EntranceViewEvent::Hide";

    public function EntranceViewEvent(param1:String) {
      super(param1);
    }
  }
}
