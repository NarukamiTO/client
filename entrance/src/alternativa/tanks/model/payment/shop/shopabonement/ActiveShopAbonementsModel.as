package alternativa.tanks.model.payment.shop.shopabonement {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shopabonement.ActiveShopAbonementsModelBase;
  import projects.tanks.client.panel.model.shopabonement.IActiveShopAbonementsModelBase;

  [ModelInfo]
  public class ActiveShopAbonementsModel extends ActiveShopAbonementsModelBase implements IActiveShopAbonementsModelBase, ShopAbonements {
    public function ActiveShopAbonementsModel() {
      super();
    }

    public function getCategoriesWithBonus() : Vector.<IGameObject> {
      return getInitParam().categoriesWithBonus;
    }
  }
}
