package projects.tanks.client.chat.models.clanchat.clanchat {
  import projects.tanks.client.chat.types.ChatMessage;

  public interface IClanChatModelBase {
    function receiveMessage(param1:ChatMessage) : void;
    function showMessagesHistory(param1:Vector.<ChatMessage>) : void;
  }
}
