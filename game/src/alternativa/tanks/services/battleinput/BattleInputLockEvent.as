package alternativa.tanks.services.battleinput {
  import flash.events.Event;

  public class BattleInputLockEvent extends Event {
    public static const CHAT_LOCKED:String = "BattleInputLockEvent.CHAT_LOCKED";
    public static const CHAT_UNLOCKED:String = "BattleInputLockEvent.CHAT_UNLOCKED";
    public static const INPUT_LOCKED:String = "BattleInputLockEvent.INPUT_LOCKED";
    public static const INPUT_UNLOCKED:String = "BattleInputLockEvent.INPUT_UNLOCKED";

    public function BattleInputLockEvent(param1:String) {
      super(param1);
    }
  }
}
