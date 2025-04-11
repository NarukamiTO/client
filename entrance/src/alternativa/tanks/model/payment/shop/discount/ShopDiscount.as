package alternativa.tanks.model.payment.shop.discount {
  [ModelInterface]
  public interface ShopDiscount {
    function isEnabled() : Boolean;
    function applyDiscount(param1:Number) : Number;
  }
}
