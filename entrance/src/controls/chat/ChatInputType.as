package controls.chat {
  public class ChatInputType {
    public static const BLUE:ChatInputType = new ChatInputType(0);
    public static const RED:ChatInputType = new ChatInputType(1);
    public static const STANDART:ChatInputType = new ChatInputType(2);
    public static const YELLOW:ChatInputType = new ChatInputType(3);

    private var value:int;

    public function ChatInputType(param1:int) {
      super();
      this.value = param1;
    }
  }
}
