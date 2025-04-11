package alternativa.tanks.models.inventory {
  public class InventoryLock {
    public static const PLAYER_INACTIVE:int = 1;
    public static const FORCED:int = 2;
    public static const GUI:int = 4;
    public static const BOSS_STATE:int = 8;

    public function InventoryLock() {
      super();
    }
  }
}
