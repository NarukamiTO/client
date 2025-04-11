package alternativa.tanks.model.payment.shop.notification {
  import alternativa.tanks.model.payment.shop.notification.service.ShopNotifierService;
  import projects.tanks.client.panel.model.shop.notification.IShopNotifierModelBase;
  import projects.tanks.client.panel.model.shop.notification.ShopNotifierModelBase;

  [ModelInfo]
  public class ShopNotifierModel extends ShopNotifierModelBase implements IShopNotifierModelBase {
    [Inject]
    public static var shopNotifierService:ShopNotifierService;

    public function ShopNotifierModel() {
      super();
    }

    public function notifyNewItemsInShop() : void {
      shopNotifierService.showNotificationAboutNewItems();
    }

    public function notifyDiscountsInShop() : void {
      shopNotifierService.showNotificationAboutDiscounts();
    }
  }
}
