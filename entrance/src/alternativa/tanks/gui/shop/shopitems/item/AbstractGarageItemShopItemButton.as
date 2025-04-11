package alternativa.tanks.gui.shop.shopitems.item {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemSkins;
  import controls.base.LabelBase;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;

  public class AbstractGarageItemShopItemButton extends ShopItemButton {
    private static const LEFT_PADDING:int = 17;

    private var nameLabel:LabelBase;
    private var currencyLabel:LabelBase;

    public function AbstractGarageItemShopItemButton(param1:IGameObject) {
      super(param1,ShopItemSkins.GREY);
    }

    override protected function initOldPriceParams() : void {
      super.initOldPriceParams();
      oldPriceLabelSize = 22;
      strikeoutLineColor = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      strikeoutLineThickness = 3;
    }

    override protected function initLabels() : void {
      this.nameLabel = new LabelBase();
      this.nameLabel.text = this.getNameLabelValue(item);
      this.nameLabel.color = ColorConstants.SHOP_MONEY_TEXT_LABEL_COLOR;
      this.nameLabel.autoSize = TextFieldAutoSize.LEFT;
      this.nameLabel.size = 18;
      this.nameLabel.mouseEnabled = false;
      addChild(this.nameLabel);
      addPriceLabel();
      priceLabel.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      priceLabel.size = this.getPriceLabelSize();
      this.currencyLabel = new LabelBase();
      fixChineseCurrencyLabelRendering(this.currencyLabel);
      this.currencyLabel.text = shopItem.getCurrencyName();
      this.currencyLabel.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      this.currencyLabel.autoSize = TextFieldAutoSize.LEFT;
      this.currencyLabel.size = 23;
      this.currencyLabel.bold = true;
      this.currencyLabel.mouseEnabled = false;
      addChild(this.currencyLabel);
    }

    private function getPriceLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 18;
        default:
          return 31;
      }
    }

    protected function getNameLabelValue(param1:IGameObject) : String {
      return "";
    }

    override protected function getPriceLabelText() : String {
      return getFormattedPriceText(getPriceWithDiscount());
    }

    override protected function getOldPriceLabelText() : String {
      return getFormattedPriceText(shopItem.getPrice());
    }

    override protected function align() : void {
      this.nameLabel.y = 12;
      priceLabel.y = 36;
      this.currencyLabel.y = 64;
      this.nameLabel.x = priceLabel.x = this.currencyLabel.x = LEFT_PADDING;
      if(preview != null) {
        preview.x = 105;
        preview.y = 28;
      }
      if(hasDiscount()) {
        oldPriceSprite.x = priceLabel.x;
        oldPriceSprite.y = priceLabel.y + priceLabel.height - 10;
        this.currencyLabel.y = oldPriceSprite.y + oldPriceSprite.height - 10;
      }
    }
  }
}
