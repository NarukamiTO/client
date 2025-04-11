package alternativa.tanks.controllers.mathmacking {
  import flash.events.Event;

  public class ShowGroupInviteWindowEvent extends Event {
    public static const TYPE:String = "ShowGroupInviteWindowEvent";

    public function ShowGroupInviteWindowEvent() {
      super(TYPE);
    }
  }
}
