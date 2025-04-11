package alternativa.tanks.gui.shop.shopitems.item.kits.newbie {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.SpecialKitIcons;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackage;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;

  public class NewbieKitPackageButton extends ShopItemButton {
    private static const SIDE_PADDING:int = 25;
    private static const TOP_PADDING:int = 10;
    private static const CENTER:int = 400;

    private var premiumIcon:Bitmap;
    private var goldIcon:Bitmap;

    public function NewbieKitPackageButton(param1:IGameObject) {
      super(param1,new NewbieKitShopItemSkin());
    }

    override protected function initOldPriceParams() : void {
      super.initOldPriceParams();
      strikeoutLineThickness = 3;
      oldPriceLabelSize = this.getPriceLabelSize();
    }

    override protected function initLabels() : void {
      this.addCrystalsAndPriceLabels();
      this.addPremiumAndGoldIconAndLabel();
      this.addSuppliesIconAndLabel();
    }

    private function getPriceLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 25;
        default:
          return 35;
      }
    }

    private function getCrystalsLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 55;
        default:
          return 75;
      }
    }

    private function addCrystalsAndPriceLabels() : void {
      var local1:LabelBase = new LabelBase();
      local1.text = FormatUtils.valueToString(this.newbieKitPackage.getCrystalsAmount(),0,false);
      local1.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.size = this.getCrystalsLabelSize();
      local1.x = SIDE_PADDING;
      local1.y = TOP_PADDING;
      local1.bold = true;
      local1.mouseEnabled = false;
      addChild(local1);
      var local2:Bitmap = new Bitmap(SpecialKitIcons.crystal);
      local2.x = local1.x + local1.width + 5;
      local2.y = local1.y + 20;
      addChild(local2);
      addPriceLabel();
      priceLabel.size = this.getPriceLabelSize();
      priceLabel.x = local1.x;
      priceLabel.y = local1.y + local1.height - 12;
    }

    private function addPremiumAndGoldIconAndLabel() : void {
      var local2:LabelBase = null;
      var local3:LabelBase = null;
      this.premiumIcon = new Bitmap();
      this.premiumIcon.x = CENTER;
      addChild(this.premiumIcon);
      var local1:int = int(this.newbieKitPackage.getPremiumDurationInDays());
      local2 = new LabelBase();
      local2.text = "+" + timeUnitService.getLocalizedDaysString(local1);
      local2.color = ColorConstants.WHITE;
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.bold = true;
      local2.mouseEnabled = false;
      addChild(local2);
      if(this.packageHasGold()) {
        this.premiumIcon.bitmapData = SpecialKitIcons.premiumSmall;
        this.premiumIcon.y = TOP_PADDING + 20;
        local2.x = this.premiumIcon.x;
        local2.y = this.premiumIcon.y + this.premiumIcon.height - 5;
        local2.size = 26;
        this.goldIcon = new Bitmap(SpecialKitIcons.gold);
        this.goldIcon.x = this.premiumIcon.x + this.premiumIcon.width + 15;
        this.goldIcon.y = TOP_PADDING + 20;
        addChild(this.goldIcon);
        local3 = new LabelBase();
        local3.text = "+" + this.newbieKitPackage.getGoldAmount();
        local3.x = this.goldIcon.x + 7;
        local3.y = this.goldIcon.y + this.goldIcon.height - 15;
        local3.color = ColorConstants.WHITE;
        local3.autoSize = TextFieldAutoSize.LEFT;
        local3.size = 26;
        local3.bold = true;
        local3.mouseEnabled = false;
        addChild(local3);
      } else {
        this.premiumIcon.bitmapData = SpecialKitIcons.premium;
        this.premiumIcon.y = TOP_PADDING + 5;
        addChild(this.premiumIcon);
        local2.x = this.premiumIcon.x + 12;
        local2.y = this.premiumIcon.y + this.premiumIcon.height - 10;
        local2.size = this.getPriceLabelSize();
      }
      this.premiumIcon.visible = local2.visible = this.packageHasPremium();
    }

    private function addSuppliesIconAndLabel() : void {
      var local1:Bitmap = new Bitmap(SpecialKitIcons.supplies);
      local1.y = -8;
      addChild(local1);
      var local2:LabelBase = new LabelBase();
      local2.text = "+" + this.newbieKitPackage.getEverySupplyAmount().toString();
      local2.y = TOP_PADDING;
      local2.color = ColorConstants.WHITE;
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.size = 71;
      local2.bold = true;
      local2.mouseEnabled = false;
      addChild(local2);
      if(this.packageHasGold()) {
        local1.x = CENTER + 180;
        local2.x = local1.x + 20;
      } else {
        local1.x = this.premiumIcon.x + this.premiumIcon.width + 30;
        local2.x = local1.x - 12;
      }
    }

    private function get newbieKitPackage() : SpecialKitPackage {
      return SpecialKitPackage(item.adapt(SpecialKitPackage));
    }

    private function packageHasPremium() : Boolean {
      return this.newbieKitPackage.getPremiumDurationInDays() > 0;
    }

    private function packageHasGold() : Boolean {
      return this.newbieKitPackage.getGoldAmount() > 0;
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
