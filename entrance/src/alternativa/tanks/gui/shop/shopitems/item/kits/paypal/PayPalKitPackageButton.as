package alternativa.tanks.gui.shop.shopitems.item.kits.paypal {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.SpecialKitIcons;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackage;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;

  public class PayPalKitPackageButton extends ShopItemButton {
    private static const SIDE_PADDING:int = 25;
    private static const TOP_PADDING:int = 10;

    private var crystalIcon:Bitmap;
    private var premiumIcon:Bitmap;
    private var payPalIcon:Bitmap;

    public function PayPalKitPackageButton(param1:IGameObject) {
      super(param1,new PayPallKitShopItemSkin());
    }

    override protected function initOldPriceParams() : void {
      super.initOldPriceParams();
      strikeoutLineThickness = 3;
      oldPriceLabelSize = 35;
    }

    override protected function initLabels() : void {
      this.addCrystalsAndPriceLabels();
      this.addPremiumIconAndLabel();
      this.addSuppliesIconAndLabel();
    }

    private function addCrystalsAndPriceLabels() : void {
      var local1:LabelBase = null;
      local1 = new LabelBase();
      local1.text = FormatUtils.valueToString(this.newbieKitPackage.getCrystalsAmount(),0,false);
      local1.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.size = 75;
      local1.x = SIDE_PADDING;
      local1.y = TOP_PADDING;
      local1.bold = true;
      local1.mouseEnabled = false;
      addChild(local1);
      this.crystalIcon = new Bitmap(SpecialKitIcons.crystal);
      this.crystalIcon.x = local1.x + local1.width + 5;
      this.crystalIcon.y = local1.y + 20;
      addChild(this.crystalIcon);
      addPriceLabel();
      priceLabel.size = 35;
      priceLabel.x = local1.x;
      priceLabel.y = local1.y + local1.height - 12;
      this.addPayPalIcon();
    }

    private function addPayPalIcon() : void {
      this.payPalIcon = new Bitmap(PayPalKitPackageItemIcons.payPalIcon);
      this.payPalIcon.x = priceLabel.x + 206;
      this.payPalIcon.y = priceLabel.y + 5;
      addChild(this.payPalIcon);
    }

    private function addPremiumIconAndLabel() : void {
      var local1:LabelBase = null;
      this.premiumIcon = new Bitmap(SpecialKitIcons.premium);
      this.premiumIcon.x = this.crystalIcon.x + this.crystalIcon.height + 100;
      this.premiumIcon.y = TOP_PADDING + 5;
      addChild(this.premiumIcon);
      local1 = new LabelBase();
      local1.text = "+" + timeUnitService.getLocalizedDaysString(this.newbieKitPackage.getPremiumDurationInDays());
      local1.x = this.premiumIcon.x + 12;
      local1.y = this.premiumIcon.y + this.premiumIcon.height - 10;
      local1.color = ColorConstants.WHITE;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.size = 35;
      local1.bold = true;
      local1.mouseEnabled = false;
      addChild(local1);
    }

    private function addSuppliesIconAndLabel() : void {
      var local1:Bitmap = new Bitmap(SpecialKitIcons.supplies);
      local1.x = this.premiumIcon.x + this.premiumIcon.width + 30;
      local1.y = -8;
      addChild(local1);
      var local2:LabelBase = new LabelBase();
      local2.text = "+" + this.newbieKitPackage.getEverySupplyAmount().toString();
      local2.x = local1.x - 12;
      local2.y = TOP_PADDING;
      local2.color = ColorConstants.WHITE;
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.size = 71;
      local2.bold = true;
      local2.mouseEnabled = false;
      addChild(local2);
    }

    private function get newbieKitPackage() : SpecialKitPackage {
      return SpecialKitPackage(item.adapt(SpecialKitPackage));
    }

    override public function get widthInCells() : int {
      return 3;
    }

    override protected function initPreview() : void {
    }

    override protected function setPreview() : void {
    }

    override protected function align() : void {
      if(hasDiscount()) {
        oldPriceSprite.x = SIDE_PADDING;
        priceLabel.x = oldPriceSprite.x + oldPriceSprite.width + 10;
        oldPriceSprite.y = priceLabel.y;
      }
    }
  }
}
