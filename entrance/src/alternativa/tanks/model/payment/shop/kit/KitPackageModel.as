package alternativa.tanks.model.payment.shop.kit {
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import alternativa.tanks.gui.shop.shopitems.item.kits.description.KitPackageDescriptionView;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsView;
  import projects.tanks.client.panel.model.shop.kitpackage.IKitPackageModelBase;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageModelBase;

  [ModelInfo]
  public class KitPackageModel extends KitPackageModelBase implements IKitPackageModelBase, KitPackage, ShopItemDetailsView {
    public function KitPackageModel() {
      super();
    }

    public function getName() : String {
      return getInitParam().name;
    }

    public function getItemInfos() : Vector.<KitPackageItemInfo> {
      return getInitParam().itemInfos;
    }

    public function getDetailsView() : ShopItemDetails {
      return new KitPackageDescriptionView(object);
    }

    public function isDetailedViewRequired() : Boolean {
      return getInitParam().showDetails;
    }
  }
}
