package alternativa.tanks.model.payment.shop.itemcategory {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.shopitemcategory.IShopItemCategoryModelBase;
  import projects.tanks.client.panel.model.shop.shopitemcategory.ShopItemCategoryModelBase;

  [ModelInfo]
  public class ShopItemCategoryModel extends ShopItemCategoryModelBase implements IShopItemCategoryModelBase, ShopItemCategory {
    public function ShopItemCategoryModel() {
      super();
    }

    public function getCategory() : IGameObject {
      return getInitParam().category;
    }
  }
}
