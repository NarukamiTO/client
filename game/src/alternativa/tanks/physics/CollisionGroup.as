package alternativa.tanks.physics {
  public class CollisionGroup {
    public static const TANK:int = 1;
    public static const ACTIVE_TRACK:int = 2;
    public static const INACTIVE_TRACK:int = 4;
    public static const WEAPON:int = 8;
    public static const STATIC:int = 16;
    public static const BONUS_WITH_TANK:int = 64;

    public function CollisionGroup() {
      super();
    }
  }
}
