package alternativa.tanks.gui.shop.shopitems.item.base {
  public class GreenShopItemSkin extends ButtonItemSkin {
    private static const normalStateClass:Class = GreenShopItemSkin_normalStateClass;
    private static const overStateClass:Class = GreenShopItemSkin_overStateClass;

    public function GreenShopItemSkin() {
      super();
      normalState = new normalStateClass().bitmapData;
      overState = new overStateClass().bitmapData;
    }
  }
}
