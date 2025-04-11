package alternativa.tanks.model.payment.shop.onetimepurchase {
  import projects.tanks.client.panel.model.shop.onetimepurchase.event.EventOneTimePurchaseModelBase;
  import projects.tanks.client.panel.model.shop.onetimepurchase.event.IEventOneTimePurchaseModelBase;

  [ModelInfo]
  public class EventOneTimePurchaseModel extends EventOneTimePurchaseModelBase implements IEventOneTimePurchaseModelBase, ShopItemOneTimePurchase {
    public function EventOneTimePurchaseModel() {
      super();
    }

    public function isOneTimePurchase() : Boolean {
      return getInitParam().oneTimePurchase;
    }

    public function isTriedToBuy() : Boolean {
      return getInitParam().triedToBuy;
    }
  }
}
