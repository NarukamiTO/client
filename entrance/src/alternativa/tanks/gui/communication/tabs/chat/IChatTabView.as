package alternativa.tanks.gui.communication.tabs.chat {
  import flash.events.IEventDispatcher;

  public interface IChatTabView extends IEventDispatcher {
    function getChatTab() : ChatTab;
    function setChatTab(param1:ChatTab) : void;
    function clear() : void;
  }
}
