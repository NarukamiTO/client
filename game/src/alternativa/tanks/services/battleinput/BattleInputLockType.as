package alternativa.tanks.services.battleinput {
  public class BattleInputLockType {
    public static const CHAT:BattleInputLockType = new BattleInputLockType(1);
    public static const MODAL_DIALOG:BattleInputLockType = new BattleInputLockType(2);
    public static const FREE_CAMERA:BattleInputLockType = new BattleInputLockType(4);
    public static const INACTIVE_BATTLE:BattleInputLockType = new BattleInputLockType(8);

    private var mask:int;

    public function BattleInputLockType(param1:int) {
      super();
      this.mask = param1;
    }

    public function getMask() : int {
      return this.mask;
    }
  }
}
