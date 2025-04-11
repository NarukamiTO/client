package alternativa.tanks.display.usertitle {
  public class TitleConfigFlags {
    public static const LABEL:int = 1;
    public static const HEALTH:int = 2;
    public static const WEAPON:int = 4;
    public static const EFFECTS:int = 8;
    public static const FORCE_HEALTH:int = 16;
    public static const ANY_HEALTH:int = HEALTH | FORCE_HEALTH;

    public function TitleConfigFlags() {
      super();
    }
  }
}
