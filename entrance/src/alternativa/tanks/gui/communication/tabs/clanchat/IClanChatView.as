package alternativa.tanks.gui.communication.tabs.clanchat {
  import flash.events.IEventDispatcher;

  public interface IClanChatView extends IEventDispatcher {
    function setClanChat(param1:ClanChatTab) : void;
    function getClanChat() : ClanChatTab;
    function clear() : void;
    function updateClanChatView() : void;
  }
}
