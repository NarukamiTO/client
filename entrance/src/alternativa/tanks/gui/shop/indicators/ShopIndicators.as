package alternativa.tanks.gui.shop.indicators {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class ShopIndicators {
    private static var iconNotificationNewItemsClass:Class = ShopIndicators_iconNotificationNewItemsClass;

    public static var newItems:BitmapData = Bitmap(new iconNotificationNewItemsClass()).bitmapData;

    private static var iconNotificationDiscountClass:Class = ShopIndicators_iconNotificationDiscountClass;

    public static var discounts:BitmapData = Bitmap(new iconNotificationDiscountClass()).bitmapData;

    public function ShopIndicators() {
      super();
    }
  }
}
