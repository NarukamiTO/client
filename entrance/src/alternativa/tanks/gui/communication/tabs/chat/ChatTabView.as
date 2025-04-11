package alternativa.tanks.gui.communication.tabs.chat {
  import flash.events.EventDispatcher;

  public class ChatTabView extends EventDispatcher implements IChatTabView {
    private var chatTab:ChatTab;

    public function ChatTabView() {
      super();
    }

    public function getChatTab() : ChatTab {
      return this.chatTab;
    }

    public function setChatTab(param1:ChatTab) : void {
      this.chatTab = param1;
      dispatchEvent(new ChatTabViewEvent(ChatTabViewEvent.CHAT_TAB_CREATED));
    }

    public function clear() : void {
      this.chatTab = null;
    }
  }
}
