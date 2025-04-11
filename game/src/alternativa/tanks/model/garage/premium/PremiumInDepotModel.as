package alternativa.tanks.model.garage.premium {
  import alternativa.tanks.gui.item.actionpanel.SingleActionPanel;
  import alternativa.tanks.model.garage.passtoshop.PassToShopService;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.garage.models.premium.IPremiumInDepotModelBase;
  import projects.tanks.client.garage.models.premium.PremiumInDepotModelBase;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  [ModelInfo]
  public class PremiumInDepotModel extends PremiumInDepotModelBase implements IPremiumInDepotModelBase, ObjectLoadListener, ItemActionPanel {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var passToShop:PassToShopService;

    public function PremiumInDepotModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:SingleActionPanel = null;
      if(passToShop.isPassToShopEnabled()) {
        local1 = new SingleActionPanel(TanksLocale.TEXT_PREMIUM_BUTTON_EXTEND,this.handleDoubleClickOnItemPreview);
        putData(SingleActionPanel,local1);
      }
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      if(passToShop.isPassToShopEnabled()) {
        this.getActionPanel().updateActionElements(param1);
      }
    }

    public function handleDoubleClickOnItemPreview() : void {
      if(passToShop.isPassToShopEnabled()) {
        paymentDisplayService.openPaymentAt(ShopCategoryEnum.PREMIUM);
      }
    }

    private function getActionPanel() : SingleActionPanel {
      return SingleActionPanel(getData(SingleActionPanel));
    }
  }
}
