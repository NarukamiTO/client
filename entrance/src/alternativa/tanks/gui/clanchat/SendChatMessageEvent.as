package alternativa.tanks.gui.clanchat {
  import flash.events.Event;

  public class SendChatMessageEvent extends Event {
    public static const SEND_CHAT_MESSAGE:String = "SendChatMessageEvent.SEND_CHAT_MESSAGE";

    public var message:String;
    public var recipientUid:String;

    public function SendChatMessageEvent(param1:String, param2:String = "") {
      this.message = param1;
      this.recipientUid = param2;
      super(SEND_CHAT_MESSAGE,true);
    }
  }
}
