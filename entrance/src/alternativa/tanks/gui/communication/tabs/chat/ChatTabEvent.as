package alternativa.tanks.gui.communication.tabs.chat {
  import flash.events.Event;

  public class ChatTabEvent extends Event {
    public static const HIDE_CHAT:String = "ChatTabEvent.HIDE_CHAT";
    public static const SHOW_CHAT:String = "ChatTabEvent.SHOW_CHAT";

    public function ChatTabEvent(param1:String) {
      super(param1,true);
    }
  }
}
