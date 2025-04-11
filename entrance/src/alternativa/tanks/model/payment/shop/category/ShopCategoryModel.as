package alternativa.tanks.model.payment.shop.category {
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.panel.model.shop.shopcategory.IShopCategoryModelBase;
  import projects.tanks.client.panel.model.shop.shopcategory.ShopCategoryModelBase;

  [ModelInfo]
  public class ShopCategoryModel extends ShopCategoryModelBase implements IShopCategoryModelBase, ShopCategory {
    public function ShopCategoryModel() {
      super();
    }

    public function getOrderIndex() : int {
      return getInitParam().orderIndex;
    }

    public function isWithJumpButton() : Boolean {
      return getInitParam().withJumpButton;
    }

    public function getType() : ShopCategoryEnum {
      return getInitParam().type;
    }
  }
}
