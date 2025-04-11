package alternativa.tanks.model.payment.shop.category {
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  [ModelInterface]
  public interface ShopCategory {
    function getOrderIndex() : int;
    function isWithJumpButton() : Boolean;
    function getType() : ShopCategoryEnum;
  }
}
