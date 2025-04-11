package alternativa.tanks.models.foreignclan {
  import flash.events.Event;

  public class ForeignClanEvent extends Event {
    public static const SEND_REQUEST:String = "ForeignClanEvent.SEND_REQUEST";
    public static const ACCEPT_REQUEST:String = "ForeignClanEvent.ACCEPT_REQUEST";
    public static const REVOKE_REQUEST:String = "ForeignClanEvent.REJECT_REQUEST";

    public function ForeignClanEvent(param1:String) {
      super(param1,true,false);
    }
  }
}
