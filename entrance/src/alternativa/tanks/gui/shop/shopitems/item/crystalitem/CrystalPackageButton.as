package alternativa.tanks.gui.shop.shopitems.item.crystalitem {
  import alternativa.tanks.gui.shop.shopitems.item.cashpackage.CashPackageButton;
  import alternativa.tanks.model.payment.shop.crystal.CrystalPackage;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;

  public class CrystalPackageButton extends CashPackageButton {
    private var premiumLabel:LabelBase;
    private var premiumIcon:Bitmap;

    public function CrystalPackageButton(param1:IGameObject) {
      super(param1);
    }

    private function get hasPremium() : Boolean {
      return this.crystalPackage.getPremiumDurationInDays() != 0;
    }

    private function get crystalPackage() : CrystalPackage {
      return CrystalPackage(item.adapt(CrystalPackage));
    }

    override protected function initLabels() : void {
      super.initLabels();
      if(this.hasPremium) {
        this.initPackageWithPremium();
      }
    }

    override protected function align() : void {
      super.align();
      if(this.hasPremium) {
        this.premiumLabel.x = LEFT_PADDING;
        this.premiumIcon.x = this.premiumLabel.x + this.premiumLabel.width + 5;
        this.premiumIcon.y = HEIGHT - BOTTOM_PADDING - this.premiumIcon.height;
        this.premiumLabel.y = this.premiumIcon.y + 4;
      }
      if(hasDiscount()) {
        if(this.hasPremium) {
          cashLabel.y -= 5;
          cashIcon.y -= 5;
          priceLabel.y -= 5;
          this.premiumIcon.y += 5;
          this.premiumLabel.y += 5;
        }
      }
    }

    private function getPremiumLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 16;
        default:
          return 20;
      }
    }

    private function initPackageWithPremium() : void {
      this.premiumLabel = new LabelBase();
      this.premiumLabel.text = "+" + this.crystalPackage.getPremiumDurationInDays() + " " + timeUnitService.getLocalizedShortDaysName(this.crystalPackage.getPremiumDurationInDays());
      this.premiumLabel.color = ColorConstants.WHITE;
      this.premiumLabel.autoSize = TextFieldAutoSize.LEFT;
      this.premiumLabel.size = this.getPremiumLabelSize();
      this.premiumLabel.mouseEnabled = false;
      this.premiumLabel.bold = true;
      addChild(this.premiumLabel);
      this.premiumIcon = new Bitmap(CrystalPackageItemIcons.premium);
      addChild(this.premiumIcon);
    }
  }
}
