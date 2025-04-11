package alternativa.tanks.model.payment.shop.shopabonement {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface ShopAbonements {
    function getCategoriesWithBonus() : Vector.<IGameObject>;
  }
}
