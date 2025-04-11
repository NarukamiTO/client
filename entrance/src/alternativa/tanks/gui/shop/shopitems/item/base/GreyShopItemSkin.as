package alternativa.tanks.gui.shop.shopitems.item.base {
  public class GreyShopItemSkin extends ButtonItemSkin {
    private static const normalStateClass:Class = GreyShopItemSkin_normalStateClass;
    private static const overStateClass:Class = GreyShopItemSkin_overStateClass;

    public function GreyShopItemSkin() {
      super();
      normalState = new normalStateClass().bitmapData;
      overState = new overStateClass().bitmapData;
    }
  }
}
