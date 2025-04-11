package alternativa.tanks.services.battleinput {
  public final class MouseLockLockType {
    public static const BATTLE_STATS:MouseLockLockType = new MouseLockLockType(1);

    private var _bit:int;

    public function MouseLockLockType(param1:int) {
      super();
      this._bit = param1;
    }

    public function get bit() : int {
      return this._bit;
    }
  }
}
