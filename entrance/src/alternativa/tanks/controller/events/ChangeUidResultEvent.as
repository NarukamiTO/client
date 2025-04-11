package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class ChangeUidResultEvent extends Event {
    public static const PASSWORD_IS_INCORRECT:String = "ChangeUidResultEvent.PASSWORD_IS_INCORRECT";

    public function ChangeUidResultEvent(param1:String) {
      super(param1);
    }
  }
}
