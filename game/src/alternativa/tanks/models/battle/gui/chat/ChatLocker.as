package alternativa.tanks.models.battle.gui.chat {
  import alternativa.tanks.services.battleinput.BattleInputLockEvent;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import platform.client.fp10.core.type.AutoClosable;

  public class ChatLocker implements AutoClosable {
    [Inject]
    public static var battleInputLockService:BattleInputService;

    private var chat:BattleChat;

    public function ChatLocker(param1:BattleChat) {
      super();
      this.chat = param1;
      battleInputLockService.addEventListener(BattleInputLockEvent.CHAT_LOCKED,this.onChatLocked);
      battleInputLockService.addEventListener(BattleInputLockEvent.CHAT_UNLOCKED,this.onChatUnlocked);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      battleInputLockService.removeEventListener(BattleInputLockEvent.CHAT_LOCKED,this.onChatLocked);
      battleInputLockService.removeEventListener(BattleInputLockEvent.CHAT_UNLOCKED,this.onChatUnlocked);
      this.chat = null;
    }

    private function onChatLocked(param1:BattleInputLockEvent) : void {
      this.chat.closeChat();
      this.chat.locked = true;
    }

    private function onChatUnlocked(param1:BattleInputLockEvent) : void {
      this.chat.locked = false;
    }
  }
}
