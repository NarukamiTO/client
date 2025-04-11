package alternativa.tanks.gui.shop.shopitems.item.kits {
  import alternativa.tanks.gui.shop.shopitems.item.AbstractGarageItemShopItemButton;
  import alternativa.tanks.model.payment.shop.kit.KitPackage;
  import platform.client.fp10.core.type.IGameObject;

  public class KitPackageButton extends AbstractGarageItemShopItemButton {
    public function KitPackageButton(param1:IGameObject) {
      super(param1);
    }

    override protected function getNameLabelValue(param1:IGameObject) : String {
      return KitPackage(param1.adapt(KitPackage)).getName();
    }
  }
}
