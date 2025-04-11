package alternativa.tanks.gui.shop.shopitems.item.kits {
  import flash.display.BitmapData;

  public class SpecialKitIcons {
    private static const crystalClass:Class = SpecialKitIcons_crystalClass;

    public static const crystal:BitmapData = new crystalClass().bitmapData;

    private static const premiumClass:Class = SpecialKitIcons_premiumClass;

    public static const premium:BitmapData = new premiumClass().bitmapData;

    private static const premiumSmallClass:Class = SpecialKitIcons_premiumSmallClass;

    public static const premiumSmall:BitmapData = new premiumSmallClass().bitmapData;

    private static const suppliesClass:Class = SpecialKitIcons_suppliesClass;

    public static const supplies:BitmapData = new suppliesClass().bitmapData;

    private static const goldClass:Class = SpecialKitIcons_goldClass;

    public static const gold:BitmapData = new goldClass().bitmapData;

    public function SpecialKitIcons() {
      super();
    }
  }
}
