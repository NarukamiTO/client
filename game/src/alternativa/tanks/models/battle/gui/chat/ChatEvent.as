package alternativa.tanks.models.battle.gui.chat {
  public class ChatEvent {
    public static const OPEN:int = 1;
    public static const CLOSE:int = 2;

    private var type:int;

    public function ChatEvent(param1:int) {
      super();
      this.type = param1;
    }

    public function getType() : int {
      return this.type;
    }
  }
}
