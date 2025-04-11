package alternativa.tanks.model.payment.shop.quantityrestriction {
  import alternativa.tanks.model.payment.shop.onetimepurchase.ShopItemOneTimePurchase;
  import projects.tanks.client.panel.model.shop.quantityrestriction.IQuantityRestrictionModelBase;
  import projects.tanks.client.panel.model.shop.quantityrestriction.QuantityRestrictionModelBase;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;

  [ModelInfo]
  public class QuantityRestrictionModel extends QuantityRestrictionModelBase implements IQuantityRestrictionModelBase, QuantityRestriction, ShopItemOneTimePurchase {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    public function QuantityRestrictionModel() {
      super();
    }

    public function reservationAbort() : void {
      paymentDisplayService.reloadPayment();
    }

    public function isOneTimePurchase() : Boolean {
      return true;
    }

    public function isTriedToBuy() : Boolean {
      return true;
    }
  }
}
