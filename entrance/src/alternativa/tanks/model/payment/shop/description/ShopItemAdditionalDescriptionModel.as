package alternativa.tanks.model.payment.shop.description {
  import projects.tanks.client.panel.model.shop.description.IShopItemAdditionalDescriptionModelBase;
  import projects.tanks.client.panel.model.shop.description.ShopItemAdditionalDescriptionModelBase;

  [ModelInfo]
  public class ShopItemAdditionalDescriptionModel extends ShopItemAdditionalDescriptionModelBase implements IShopItemAdditionalDescriptionModelBase, ShopItemAdditionalDescription {
    public function ShopItemAdditionalDescriptionModel() {
      super();
    }

    public function getAdditionalDescription() : String {
      return getInitParam().additionalDescription;
    }
  }
}
