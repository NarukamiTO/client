package alternativa.tanks.gui.chat {
  import flash.events.Event;

  public class CautionExternalLinkWindowEvent extends Event {
    public static const CLOSING:String = "CautionExternalLinkWindowClosingEvent";

    public function CautionExternalLinkWindowEvent(param1:String) {
      super(param1,true);
    }
  }
}
