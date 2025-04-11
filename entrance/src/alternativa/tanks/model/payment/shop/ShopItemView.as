package alternativa.tanks.model.payment.shop {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;

  [ModelInterface]
  public interface ShopItemView {
    function getButtonView() : ShopButton;
  }
}
