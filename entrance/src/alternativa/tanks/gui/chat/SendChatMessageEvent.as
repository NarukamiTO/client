package alternativa.tanks.gui.chat {
  import flash.events.Event;
  import projects.tanks.client.chat.models.chat.chat.ChatAddressMode;

  public class SendChatMessageEvent extends Event {
    public static const SEND_CHAT_MESSAGE:String = "SendChatMessageEvent.SEND_CHAT_MESSAGE";

    public var message:String;
    public var addressMode:ChatAddressMode;
    public var recipientUid:String;

    public function SendChatMessageEvent(param1:String, param2:ChatAddressMode, param3:String = "") {
      this.message = param1;
      this.addressMode = param2;
      this.recipientUid = param3;
      super(SEND_CHAT_MESSAGE,true);
    }
  }
}
