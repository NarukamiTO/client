package alternativa.tanks.gui.communication.tabs.clanchat {
  import flash.events.Event;

  public class ClanChatTabNewMessageEvent extends Event {
    public static const NEW_MESSAGE:String = "ClanChatTabNewMessageEvent.NEW_MESSAGE";

    public function ClanChatTabNewMessageEvent() {
      super(NEW_MESSAGE,true);
    }
  }
}
