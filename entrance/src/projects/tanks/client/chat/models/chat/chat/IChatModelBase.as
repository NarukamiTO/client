package projects.tanks.client.chat.models.chat.chat {
  import projects.tanks.client.chat.types.ChatMessage;

  public interface IChatModelBase {
    function cleanUsersMessages(param1:String) : void;
    function showMessages(param1:Vector.<ChatMessage>) : void;
    function updateTypingSpeedAntifloodParams(param1:int, param2:int) : void;
  }
}
