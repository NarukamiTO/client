package alternativa.tanks.model.payment.shop.lootboxandpaint {
  import alternativa.tanks.gui.shop.shopitems.item.base.ButtonItemSkin;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.kits.SpecialKitIcons;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import controls.base.LabelBase;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.lootboxandpaintkit.LootboxAndPaintCC;

  public class LootboxAndPaintButton extends ShopItemButton {
    private static const SIDE_PADDING:int = 25;
    private static const TOP_PADDING:int = 10;

    private var crystalIcon:Bitmap = new Bitmap(SpecialKitIcons.crystal);
    private var lootbooxIcon:Bitmap;
    private var paintIcon:Bitmap = null;
    private var lastXPosition:int;
    private var crystalCount:int;
    private var lootboxCount:int;

    public function LootboxAndPaintButton(param1:IGameObject, param2:LootboxAndPaintCC) {
      this.crystalCount = param2.crystalCount;
      this.lootboxCount = param2.lootboxCount;
      if(param2.paintPreview != null) {
        this.paintIcon = new Bitmap(param2.paintPreview.data);
      }
      this.lootbooxIcon = new Bitmap(param2.lootBoxPreview.data);
      var local3:ButtonItemSkin = new ButtonItemSkin();
      local3.normalState = param2.button.data;
      local3.overState = param2.buttonOver.data;
      super(param1,local3);
    }

    override protected function initOldPriceParams() : void {
      super.initOldPriceParams();
      strikeoutLineThickness = 3;
      oldPriceLabelSize = 35;
    }

    override protected function initLabels() : void {
      this.addCrystalsAndPriceLabels();
      this.lastXPosition = this.crystalIcon.x + this.crystalIcon.width + 40;
      this.addLootbox();
      this.addPaint();
    }

    private function addCrystalsAndPriceLabels() : void {
      var local1:LabelBase = new LabelBase();
      local1.text = FormatUtils.valueToString(this.crystalCount,0,false);
      local1.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.size = 75;
      local1.x = SIDE_PADDING;
      local1.y = TOP_PADDING;
      local1.bold = true;
      local1.mouseEnabled = false;
      addChild(local1);
      this.crystalIcon.x = local1.x + local1.width + 5;
      this.crystalIcon.y = local1.y + 20;
      addChild(this.crystalIcon);
      addPriceLabel();
      priceLabel.size = 35;
      priceLabel.x = local1.x;
      priceLabel.y = local1.y + local1.height - 12;
    }

    private function addLootbox() : void {
      if(this.lootboxCount < 1) {
        return;
      }
      this.lootbooxIcon.x = this.lastXPosition;
      this.lastXPosition += this.lootbooxIcon.width + 10;
      this.lootbooxIcon.y = TOP_PADDING;
      addChild(this.lootbooxIcon);
      var local1:LabelBase = new MouseDisabledLabel();
      local1.text = "+" + this.lootboxCount;
      local1.x = this.lootbooxIcon.x + this.lootbooxIcon.width - 80;
      local1.y = this.lootbooxIcon.y + this.lootbooxIcon.height - 40;
      local1.color = ColorConstants.WHITE;
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.size = 45;
      local1.bold = true;
      addChild(local1);
    }

    private function addPaint() : void {
      if(this.paintIcon == null) {
        return;
      }
      this.paintIcon.x = this.lastXPosition;
      this.paintIcon.y = TOP_PADDING + 10;
      this.lastXPosition += this.paintIcon.width;
      addChild(this.paintIcon);
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
