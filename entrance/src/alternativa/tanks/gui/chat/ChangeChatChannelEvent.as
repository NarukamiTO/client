package alternativa.tanks.gui.chat {
  import flash.events.Event;

  public class ChangeChatChannelEvent extends Event {
    public static const CHANGE_CHANNEL:String = "ChangeChatChannelEvent.CHANGE_CHANNEL";

    public var channel:String;

    public function ChangeChatChannelEvent(param1:String) {
      this.channel = param1;
      super(CHANGE_CHANNEL,true);
    }
  }
}
