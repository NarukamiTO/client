package assets.icons {
  import flash.display.MovieClip;

  [Embed(source="/_assets/assets.swf", symbol="symbol966")]
  public class CheckIcons extends MovieClip {
    public static const FRIENDLY_FIRE:int = 1;
    public static const INVITE_ONLY:int = 2;
    public static const AUTO_BALANCE:int = 3;
    public static const CHECK_SIGN:int = 4;

    public function CheckIcons() {
      super();
      this.type = CHECK_SIGN;
    }

    public function set type(param1:int) : void {
      gotoAndStop(param1);
    }
  }
}
