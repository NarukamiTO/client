package assets.icons {
  import flash.display.MovieClip;

  [Embed(source="/_assets/assets.swf", symbol="symbol1135")]
  public class BattleInfoIcons extends MovieClip {
    public static const TIME_LIMIT:int = 1;
    public static const KILL_LIMIT:int = 2;
    public static const FRIENDLY_FIRE:int = 3;
    public static const AUTO_BALANCE:int = 4;
    public static const MONEY:int = 5;
    public static const PLAYERS:int = 6;
    public static const CTF:int = 7;
    public static const PAYD:int = 8;
    public static const INVENTORY_BONUS:int = 9;
    public static const TEAM_SCORE:int = 10;
    public static const TEAM_SCORE_BIG:int = 11;
    public static const UPGRADES:int = 12;
    public static const PRO_BATTLE:int = 13;
    public static const CRYSTAL_BONUS:int = 14;
    public static const REARMOR:int = 15;
    public static const DEPENDENT_COOLDOWN:int = 16;
    public static const TDM:int = 17;
    public static const FORMAT:int = 18;
    public static const AUTO_COMPLETION:int = 19;

    public function BattleInfoIcons() {
      super();
      this.type = TIME_LIMIT;
    }

    public function set type(param1:int) : void {
      gotoAndStop(param1);
    }
  }
}
