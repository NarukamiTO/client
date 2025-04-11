package alternativa.tanks.gui.icons {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class PremiumIcon {
    private static const premiumIconClass:Class = PremiumIcon_premiumIconClass;
    private static const premiumBd:BitmapData = new premiumIconClass().bitmapData;
    private static const smallPremiumIconClass:Class = PremiumIcon_smallPremiumIconClass;
    private static const smallPremiumBd:BitmapData = new smallPremiumIconClass().bitmapData;

    public function PremiumIcon() {
      super();
    }

    public static function createInstance() : Bitmap {
      return new Bitmap(premiumBd);
    }

    public static function createSmallInstance() : Bitmap {
      return new Bitmap(smallPremiumBd);
    }
  }
}
