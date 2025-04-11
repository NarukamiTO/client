package alternativa.tanks.model.payment.shop {
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;

  [ModelInterface]
  public interface ShopItemDetailsView {
    function getDetailsView() : ShopItemDetails;
    function isDetailedViewRequired() : Boolean;
  }
}
