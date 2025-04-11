package alternativa.tanks.gui.shop.shopitems.item.premiumitem {
  import alternativa.tanks.gui.shop.shopitems.item.CountableItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.LeftPictureAndTextPackageButton;
  import alternativa.tanks.model.payment.shop.premium.PremiumPackage;
  import platform.client.fp10.core.type.IGameObject;

  public class PremiumPackageButton extends LeftPictureAndTextPackageButton implements CountableItemButton {
    public function PremiumPackageButton(param1:IGameObject) {
      super(param1);
    }

    override protected function getText() : String {
      return "+" + timeUnitService.getLocalizedDaysString(PremiumPackage(item.adapt(PremiumPackage)).getDurationInDays());
    }

    override protected function align() : void {
      super.align();
      if(preview != null) {
        oldPriceSprite.x = priceLabel.x = nameLabel.x = nameLabel.x + 8;
      }
    }

    public function getCount() : int {
      return PremiumPackage(item.adapt(PremiumPackage)).getDurationInDays();
    }
  }
}
