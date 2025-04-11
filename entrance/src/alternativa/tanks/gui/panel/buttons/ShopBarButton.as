package alternativa.tanks.gui.panel.buttons {
  import alternativa.tanks.gui.shop.components.notification.ShopNotificationIndicator;
  import flash.display.Bitmap;

  public class ShopBarButton extends MainPanelOrangeWideButton {
    private static const shopCrystals:Class = ShopBarButton_shopCrystals;
    private static const shopCrystalsIcon:Bitmap = new shopCrystals();

    public function ShopBarButton() {
      super(shopCrystalsIcon,1,2);
      var local1:ShopNotificationIndicator = new ShopNotificationIndicator();
      addChild(local1);
      local1.x = width - int(local1.width / 2) - 2;
      local1.y = -4;
    }
  }
}
