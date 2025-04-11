package alternativa.tanks.battle.objects.tank {
  public class TankControlLockBits {
    public static const DEAD:int = 1;
    public static const SHAFT:int = 2;
    public static const ERROR:int = 4;
    public static const PAUSE:int = 8;
    public static const DISABLED:int = 16;
    public static const CLIENT:int = 32;
    public static const STUN:int = 64;
    public static const DEBUFF:int = 128;
    public static const ALL:int = 16777215;

    public function TankControlLockBits() {
      super();
    }
  }
}
