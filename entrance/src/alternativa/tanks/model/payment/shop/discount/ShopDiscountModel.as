package alternativa.tanks.model.payment.shop.discount {
  import projects.tanks.client.panel.model.shop.discount.IShopDiscountModelBase;
  import projects.tanks.client.panel.model.shop.discount.ShopDiscountModelBase;

  [ModelInfo]
  public class ShopDiscountModel extends ShopDiscountModelBase implements IShopDiscountModelBase, ShopDiscount {
    public function ShopDiscountModel() {
      super();
    }

    public function isEnabled() : Boolean {
      return getInitParam().enabled;
    }

    public function applyDiscount(param1:Number) : Number {
      if(this.isEnabled()) {
        return param1 * (1 - getInitParam().discountInPercent * 0.01);
      }
      return param1;
    }
  }
}
