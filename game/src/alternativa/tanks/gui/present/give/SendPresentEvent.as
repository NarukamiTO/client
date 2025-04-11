package alternativa.tanks.gui.present.give {
  import flash.events.Event;

  public class SendPresentEvent extends Event {
    public static var SEND_PRESENT:String = "SendPresentEvent.SEND_PRESENT";

    public var uid:String;
    public var text:String;

    public function SendPresentEvent(param1:String, param2:String, param3:String) {
      super(param1);
      this.uid = param2;
      this.text = param3;
    }
  }
}
