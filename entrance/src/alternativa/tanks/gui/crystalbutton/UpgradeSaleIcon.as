package alternativa.tanks.gui.crystalbutton {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class UpgradeSaleIcon {
    private static const bitmapSale:Class = UpgradeSaleIcon_bitmapSale;
    private static const saleBd:BitmapData = new bitmapSale().bitmapData;

    public function UpgradeSaleIcon() {
      super();
    }

    public static function createInstance() : Bitmap {
      return new Bitmap(saleBd);
    }
  }
}
