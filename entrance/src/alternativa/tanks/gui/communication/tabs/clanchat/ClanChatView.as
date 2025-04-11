package alternativa.tanks.gui.communication.tabs.clanchat {
  import flash.events.EventDispatcher;

  public class ClanChatView extends EventDispatcher implements IClanChatView {
    private var clanChat:ClanChatTab;

    public function ClanChatView() {
      super();
    }

    public function setClanChat(param1:ClanChatTab) : void {
      this.clanChat = param1;
      dispatchEvent(new ClanChatViewEvent(ClanChatViewEvent.CLAN_CHAT_ADDED));
    }

    public function getClanChat() : ClanChatTab {
      return this.clanChat;
    }

    public function clear() : void {
      this.clanChat = null;
    }

    public function updateClanChatView() : void {
      dispatchEvent(new ClanChatViewEvent(ClanChatViewEvent.UPDATE_CLAN_CHAT_VIEW));
    }
  }
}
