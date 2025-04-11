package alternativa.tanks.view.events {
  import flash.events.Event;

  public class InviteFormOkButtonEvent extends Event {
    public static const OK_BUTTON_CLICKED:String = "OK_BUTTON_CLICKED";

    public function InviteFormOkButtonEvent() {
      super(OK_BUTTON_CLICKED);
    }
  }
}
