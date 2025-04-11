package alternativa.tanks.gui.communication.tabs.clanchat {
  import flash.events.Event;

  public class ClanChatViewEvent extends Event {
    public static const CLAN_CHAT_ADDED:String = "ClanChatViewEvent.CLAN_CHAT_ADDED";
    public static const UPDATE_CLAN_CHAT_VIEW:String = "ClanChatViewEvent.UPDATE_CLAN_CHAT_VIEW";

    public function ClanChatViewEvent(param1:String) {
      super(param1,true);
    }
  }
}
