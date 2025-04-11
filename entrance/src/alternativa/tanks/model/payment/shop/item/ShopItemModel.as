package alternativa.tanks.model.payment.shop.item {
  import alternativa.tanks.model.payment.shop.discount.ShopDiscount;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.shop.price.IShopItemModelBase;
  import projects.tanks.client.panel.model.shop.price.ShopItemModelBase;

  [ModelInfo]
  public class ShopItemModel extends ShopItemModelBase implements IShopItemModelBase, ShopItem {
    public function ShopItemModel() {
      super();
    }

    public function getPrice() : Number {
      return getInitParam().price;
    }

    public function getPriceWithDiscount() : Number {
      return ShopDiscount(object.adapt(ShopDiscount)).applyDiscount(this.getPrice());
    }

    public function getCurrencyName() : String {
      return getInitParam().currencyName;
    }

    public function getCurrencyRoundingPrecision() : int {
      return getInitParam().roundingPrecision;
    }

    public function getPreview() : ImageResource {
      return getInitParam().preview;
    }
  }
}
