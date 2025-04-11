package alternativa.tanks.model.payment.shop.itemcategory {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface ShopItemCategory {
    function getCategory() : IGameObject;
  }
}
