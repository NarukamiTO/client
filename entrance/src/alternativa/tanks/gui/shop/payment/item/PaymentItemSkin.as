package alternativa.tanks.gui.shop.payment.item {
  import alternativa.tanks.gui.shop.shopitems.item.base.ButtonItemSkin;

  public class PaymentItemSkin extends ButtonItemSkin {
    private static const normalStateClass:Class = PaymentItemSkin_normalStateClass;
    private static const overStateClass:Class = PaymentItemSkin_overStateClass;

    public static const SKIN:PaymentItemSkin = new PaymentItemSkin();

    public function PaymentItemSkin() {
      super();
      normalState = new normalStateClass().bitmapData;
      overState = new overStateClass().bitmapData;
    }
  }
}
