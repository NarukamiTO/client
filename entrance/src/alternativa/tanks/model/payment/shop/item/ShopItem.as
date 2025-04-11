package alternativa.tanks.model.payment.shop.item {
  import platform.client.fp10.core.resource.types.ImageResource;

  [ModelInterface]
  public interface ShopItem {
    function getPrice() : Number;
    function getPriceWithDiscount() : Number;
    function getCurrencyName() : String;
    function getCurrencyRoundingPrecision() : int;
    function getPreview() : ImageResource;
  }
}
