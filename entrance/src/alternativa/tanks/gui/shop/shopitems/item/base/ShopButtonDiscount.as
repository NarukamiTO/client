package alternativa.tanks.gui.shop.shopitems.item.base {
  import platform.client.fp10.core.type.IGameObject;

  public interface ShopButtonDiscount {
    function applyPayModeDiscountAndUpdatePriceLabel(param1:IGameObject) : void;
  }
}
