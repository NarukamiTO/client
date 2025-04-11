package alternativa.tanks.model.payment.shop.onetimepurchase {
  [ModelInterface]
  public interface ShopItemOneTimePurchase {
    function isOneTimePurchase() : Boolean;
    function isTriedToBuy() : Boolean;
  }
}
