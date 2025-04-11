package alternativa.tanks.model.item.shopabonement {
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.client.garage.models.shopabonement.IShopAbonementModelBase;
  import projects.tanks.client.garage.models.shopabonement.ShopAbonementModelBase;

  [ModelInfo]
  public class ShopAbonementModel extends ShopAbonementModelBase implements ShopAbonement, IShopAbonementModelBase {
    public function ShopAbonementModel() {
      super();
    }

    public function getShopCategory() : ShopCategoryEnum {
      return getInitParam().shopCategory;
    }
  }
}
