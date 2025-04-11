package alternativa.tanks.gui.shop.components.notification {
  import alternativa.tanks.gui.shop.indicators.ShopIndicators;
  import alternativa.tanks.model.payment.shop.notification.service.ShopNotificationEvent;
  import alternativa.tanks.model.payment.shop.notification.service.ShopNotifierService;
  import flash.display.Bitmap;
  import flash.display.Sprite;

  public class ShopNotificationIndicator extends Sprite {
    [Inject]
    public static var shopNotifierService:ShopNotifierService;

    private var newItemsIcon:Bitmap;
    private var discountsIcon:Bitmap;

    public function ShopNotificationIndicator() {
      super();
      this.newItemsIcon = new Bitmap(ShopIndicators.newItems);
      this.newItemsIcon.visible = false;
      addChild(this.newItemsIcon);
      this.discountsIcon = new Bitmap(ShopIndicators.discounts);
      this.discountsIcon.visible = false;
      addChild(this.discountsIcon);
      shopNotifierService.addEventListener(ShopNotificationEvent.SHOW_NOTIFICATION_ABOUT_NEW_ITEMS,this.onNewItemsAppearedInShop);
      shopNotifierService.addEventListener(ShopNotificationEvent.SHOW_NOTIFICATION_ABOUT_DISCOUNTS,this.onDiscountsInShop);
      shopNotifierService.addEventListener(ShopNotificationEvent.HIDE_NOTIFICATION,this.onNotificationViewed);
    }

    private function onNotificationViewed(param1:ShopNotificationEvent) : void {
      this.newItemsIcon.visible = false;
      this.discountsIcon.visible = false;
    }

    private function onNewItemsAppearedInShop(param1:ShopNotificationEvent) : void {
      this.newItemsIcon.visible = true;
      this.discountsIcon.visible = false;
    }

    private function onDiscountsInShop(param1:ShopNotificationEvent) : void {
      this.newItemsIcon.visible = false;
      this.discountsIcon.visible = true;
    }
  }
}
