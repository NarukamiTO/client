package controls {
  import flash.display.MovieClip;

  [Embed(source="/_assets/assets.swf", symbol="symbol1004")]
  public class InventoryIcon extends MovieClip {
    public static const MEDIC:int = 1;
    public static const ARMOR:int = 2;
    public static const FIRE:int = 3;
    public static const NOS:int = 4;
    public static const MINE:int = 5;
    public static const REM:int = 6;
    public static const EMPTY:int = 7;

    public function InventoryIcon(param1:int = 1, param2:Boolean = false) {
      super();
      gotoAndStop(param1 + (param2 ? 7 : 0));
    }
  }
}
