package forms.userlabel {
  import flash.events.Event;

  public class ChatUpdateEvent extends Event {
    public static const UPDATE:String = "ChatUpdateEvent.UPDATE";

    public function ChatUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }
  }
}
