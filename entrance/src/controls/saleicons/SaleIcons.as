package controls.saleicons {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class SaleIcons {
    private static const saleRedLabelClass:Class = SaleIcons_saleRedLabelClass;
    private static const saleRedLabel:BitmapData = new saleRedLabelClass().bitmapData;

    public function SaleIcons() {
      super();
    }

    public static function createSaleRedLabelInstance() : Bitmap {
      return new Bitmap(saleRedLabel);
    }
  }
}
