package alternativa.tanks.gui.shop.shopitems.item.kits.singleitem {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.SpecialKitIcons;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackage;
  import controls.base.LabelBase;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.specialkit.ShopKitText;
  import projects.tanks.client.panel.model.shop.specialkit.view.singleitem.SingleItemKitViewCC;

  public class SingleKitButton extends ShopItemButton {
    private static const SIDE_PADDING:int = 25;
    private static const TOP_PADDING:int = 10;

    private var crystalIcon:Bitmap = new Bitmap(SpecialKitIcons.crystal);
    private var premiumIcon:Bitmap = new Bitmap(SpecialKitIcons.premiumSmall);
    private var suppliesIcon:Bitmap = new Bitmap(SpecialKitIcons.supplies);
    private var goldIcon:Bitmap = new Bitmap(SpecialKitIcons.gold);
    private var itemIcon:Bitmap;
    private var brandIcon:Bitmap;
    private var lastXPosition:int;

    public function SingleKitButton(param1:IGameObject, param2:SingleItemKitViewCC) {
      if(param2.preview != null) {
        this.itemIcon = new Bitmap(param2.preview.data);
      }
      if(param2.brandIcon != null) {
        this.brandIcon = new Bitmap(param2.brandIcon.data);
      }
      super(param1,new SingleShopItemSkin(param2));
    }

    override protected function initOldPriceParams() : void {
      super.initOldPriceParams();
      strikeoutLineThickness = 3;
      oldPriceLabelSize = 35;
    }

    override protected function initLabels() : void {
      this.addCrystalsAndPriceLabels();
      this.addBrandIcon();
      this.lastXPosition = this.crystalIcon.x + this.crystalIcon.width + 40;
      this.addPremiumIconAndLabel();
      this.addGoldIconAndLabel();
      this.addItemIcon();
      this.addSuppliesIconAndLabel();
      this.addText();
    }

    private function addText() : void {
      var local2:* = undefined;
      var local3:* = undefined;
      var local4:MouseDisabledLabel = null;
      var local1:Vector.<ShopKitText> = this.specialKit.getPackageData().texts;
      for(local2 in local1) {
        local3 = local1[local2];
        local4 = new MouseDisabledLabel();
        local4.color = local3.color;
        local4.autoSize = TextFieldAutoSize.LEFT;
        local4.multiline = true;
        local4.wordWrap = false;
        local4.text = local3.text;
        local4.size = local3.size;
        local4.x = local3.x;
        local4.y = local3.y;
        local4.bold = true;
        addChild(local4);
      }
    }

    private function addBrandIcon() : void {
      if(Boolean(this.brandIcon)) {
        addChild(this.brandIcon);
        this.brandIcon.x = priceLabel.x + 206;
        this.brandIcon.y = priceLabel.y + 5;
      }
    }

    private function addCrystalsAndPriceLabels() : void {
      var local1:LabelBase = new MouseDisabledLabel();
      local1.text = FormatUtils.valueToString(this.specialKit.getCrystalsAmount(),0,false);
      local1.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.size = 75;
      local1.x = SIDE_PADDING;
      local1.y = TOP_PADDING;
      local1.bold = true;
      if(this.specialKit.getCrystalsAmount() > 0) {
        addChild(local1);
      }
      this.crystalIcon.x = local1.x + local1.width + 5;
      this.crystalIcon.y = local1.y + 20;
      if(this.specialKit.getCrystalsAmount() > 0) {
        addChild(this.crystalIcon);
      }
      addPriceLabel();
      priceLabel.size = 35;
      priceLabel.x = local1.x;
      priceLabel.y = local1.y + local1.height - 12;
    }

    private function addPremiumIconAndLabel() : void {
      var local1:int = int(this.specialKit.getPremiumDurationInDays());
      if(local1 == 0 || !this.specialKit.getPackageData().showPremiumIcon) {
        return;
      }
      this.premiumIcon.x = this.lastXPosition;
      this.lastXPosition += this.premiumIcon.width + 10;
      this.premiumIcon.y = TOP_PADDING + 20;
      addChild(this.premiumIcon);
      var local2:LabelBase = new MouseDisabledLabel();
      local2.text = "+" + timeUnitService.getLocalizedDaysString(local1);
      local2.x = this.premiumIcon.x + 2;
      local2.y = this.premiumIcon.y + this.premiumIcon.height + 5;
      local2.color = ColorConstants.WHITE;
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.size = 26;
      local2.bold = true;
      addChild(local2);
    }

    private function addGoldIconAndLabel() : void {
      var local1:int = int(this.specialKit.getGoldAmount());
      if(local1 == 0) {
        return;
      }
      this.goldIcon.x = this.lastXPosition + 10;
      this.goldIcon.y = TOP_PADDING + 20;
      this.lastXPosition += this.goldIcon.width;
      addChild(this.goldIcon);
      var local2:LabelBase = new MouseDisabledLabel();
      local2.text = "+" + local1;
      local2.x = this.goldIcon.x + 16;
      local2.y = this.goldIcon.y + this.goldIcon.height - 5;
      local2.color = ColorConstants.WHITE;
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.size = 26;
      local2.bold = true;
      addChild(local2);
    }

    private function addItemIcon() : void {
      var local2:LabelBase = null;
      if(this.itemIcon == null) {
        return;
      }
      this.itemIcon.x = this.lastXPosition;
      if(this.specialKit.getEverySupplyAmount() < 1) {
        this.itemIcon.x += 100;
      }
      this.itemIcon.y = TOP_PADDING + 10;
      this.lastXPosition += this.itemIcon.width;
      addChild(this.itemIcon);
      var local1:int = int(this.specialKit.getItemsCount());
      if(local1 > 1) {
        local2 = new MouseDisabledLabel();
        local2.text = "+" + local1.toString();
        local2.x = this.itemIcon.x + 100;
        local2.y = this.itemIcon.y;
        local2.color = ColorConstants.WHITE;
        local2.autoSize = TextFieldAutoSize.LEFT;
        local2.size = 45;
        local2.bold = true;
        addChild(local2);
      }
    }

    private function addSuppliesIconAndLabel() : void {
      var local1:LabelBase = null;
      if(this.specialKit.getEverySupplyAmount() > 0) {
        this.suppliesIcon.x = Math.min(this.lastXPosition,WIDTH * this.widthInCells - this.suppliesIcon.width);
        this.suppliesIcon.y = -5;
        addChild(this.suppliesIcon);
        local1 = new MouseDisabledLabel();
        local1.text = "+" + this.specialKit.getEverySupplyAmount().toString();
        local1.x = this.suppliesIcon.x + 140;
        local1.y = this.suppliesIcon.y + 83;
        local1.color = ColorConstants.WHITE;
        local1.autoSize = TextFieldAutoSize.LEFT;
        local1.size = 45;
        local1.bold = true;
        addChild(local1);
      }
    }

    private function get specialKit() : SpecialKitPackage {
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
