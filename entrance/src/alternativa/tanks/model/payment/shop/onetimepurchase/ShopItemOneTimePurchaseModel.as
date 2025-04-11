package alternativa.tanks.model.payment.shop.onetimepurchase {
  import projects.tanks.client.panel.model.shop.onetimepurchase.IShopItemOneTimePurchaseModelBase;
  import projects.tanks.client.panel.model.shop.onetimepurchase.ShopItemOneTimePurchaseModelBase;

  [ModelInfo]
  public class ShopItemOneTimePurchaseModel extends ShopItemOneTimePurchaseModelBase implements IShopItemOneTimePurchaseModelBase, ShopItemOneTimePurchase {
    public function ShopItemOneTimePurchaseModel() {
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
