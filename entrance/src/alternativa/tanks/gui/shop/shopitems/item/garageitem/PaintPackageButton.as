package alternativa.tanks.gui.shop.shopitems.item.garageitem {
  import alternativa.tanks.gui.shop.shopitems.item.AbstractGarageItemShopItemButton;
  import alternativa.tanks.model.payment.shop.paint.PaintPackage;
  import platform.client.fp10.core.type.IGameObject;

  public class PaintPackageButton extends AbstractGarageItemShopItemButton {
    public function PaintPackageButton(param1:IGameObject) {
      super(param1);
    }

    override protected function getNameLabelValue(param1:IGameObject) : String {
      return PaintPackage(param1.adapt(PaintPackage)).getName();
    }
  }
}
