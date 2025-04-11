package alternativa.tanks.gui.icons {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class CrystalIcon {
    private static const bitmapCrystal:Class = CrystalIcon_bitmapCrystal;
    private static const crystalBd:BitmapData = new bitmapCrystal().bitmapData;
    private static const smallCrystal:Class = CrystalIcon_smallCrystal;
    private static const smallBitmapData:BitmapData = new smallCrystal().bitmapData;

    public function CrystalIcon() {
      super();
    }

    public static function createInstance() : Bitmap {
      return new Bitmap(crystalBd);
    }

    public static function createSmallInstance() : Bitmap {
      return new Bitmap(smallBitmapData);
    }
  }
}
