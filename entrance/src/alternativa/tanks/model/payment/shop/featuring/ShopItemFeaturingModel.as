package alternativa.tanks.model.payment.shop.featuring {
  import projects.tanks.client.panel.model.shop.featuring.IShopItemFeaturingModelBase;
  import projects.tanks.client.panel.model.shop.featuring.ShopItemFeaturingModelBase;

  [ModelInfo]
  public class ShopItemFeaturingModel extends ShopItemFeaturingModelBase implements IShopItemFeaturingModelBase, ShopItemFeaturing {
    public function ShopItemFeaturingModel() {
      super();
    }

    public function isLocatedInFeaturingCategory() : Boolean {
      return getInitParam().locatedInFeaturingCategory;
    }

    public function isHiddenInOriginalCategory() : Boolean {
      return getInitParam().hiddenInOriginalCategory;
    }

    public function getPosition() : int {
      return getInitParam().position;
    }
  }
}
