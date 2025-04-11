package alternativa.tanks.gui.communication.tabs.chat {
  import flash.events.Event;

  public class ChatTabViewEvent extends Event {
    public static const CHAT_TAB_CREATED:String = "ChatTabViewEvent.CHAT_TAB_CREATED";

    public function ChatTabViewEvent(param1:String) {
      super(param1,true);
    }
  }
}
