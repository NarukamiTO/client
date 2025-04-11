package forms.premium {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class PremiumItemLock {
    private static const premiumItemLockClass:Class = PremiumItemLock_premiumItemLockClass;
    private static const premiumItemLock:BitmapData = new premiumItemLockClass().bitmapData;

    public function PremiumItemLock() {
      super();
    }

    public static function createInstance() : Bitmap {
      return new Bitmap(premiumItemLock);
    }
  }
}
