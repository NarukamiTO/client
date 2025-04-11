package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class AccountLoginPressed extends Event {
    public static const EVENT_TYPE:String = "AccountLoginPressed.EVENT_TYPE";

    public function AccountLoginPressed() {
      super(EVENT_TYPE);
    }
  }
}
