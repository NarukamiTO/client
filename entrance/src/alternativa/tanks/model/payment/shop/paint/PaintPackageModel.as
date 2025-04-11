package alternativa.tanks.model.payment.shop.paint {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.details.ShopItemDetails;
  import alternativa.tanks.gui.shop.shopitems.item.garageitem.PaintPackageButton;
  import alternativa.tanks.gui.shop.shopitems.item.garageitem.PaintPackageDescriptionView;
  import alternativa.tanks.model.payment.shop.ShopItemDetailsView;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import projects.tanks.client.panel.model.shop.paintpackage.IPaintPackageModelBase;
  import projects.tanks.client.panel.model.shop.paintpackage.PaintPackageModelBase;

  [ModelInfo]
  public class PaintPackageModel extends PaintPackageModelBase implements IPaintPackageModelBase, PaintPackage, ShopItemView, ShopItemDetailsView {
    public function PaintPackageModel() {
      super();
    }

    public function getName() : String {
      return getInitParam().name;
    }

    public function getDescription() : String {
      return getInitParam().description;
    }

    public function getButtonView() : ShopButton {
      return new PaintPackageButton(object);
    }

    public function getDetailsView() : ShopItemDetails {
      return new PaintPackageDescriptionView(object);
    }

    public function isDetailedViewRequired() : Boolean {
      return true;
    }
  }
}
