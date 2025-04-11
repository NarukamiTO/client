package alternativa.tanks.gui.shop.shopitems.item.base {
  public class RedShopItemSkin extends ButtonItemSkin {
    private static const normalStateClass:Class = RedShopItemSkin_normalStateClass;
    private static const overStateClass:Class = RedShopItemSkin_overStateClass;

    public function RedShopItemSkin() {
      super();
      normalState = new normalStateClass().bitmapData;
      overState = new overStateClass().bitmapData;
    }
  }
}
