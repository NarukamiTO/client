package alternativa.tanks.model.item.shopabonement {
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  [ModelInterface]
  public interface ShopAbonement {
    function getShopCategory() : ShopCategoryEnum;
  }
}
