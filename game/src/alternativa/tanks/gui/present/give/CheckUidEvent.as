package alternativa.tanks.gui.present.give {
  import flash.events.Event;

  public class CheckUidEvent extends Event {
    public static var CHECK_UID:String = "CheckUidEvent.CHECK_UID";

    public var uid:String;

    public function CheckUidEvent(param1:String) {
      super(CHECK_UID);
      this.uid = param1;
    }
  }
}
