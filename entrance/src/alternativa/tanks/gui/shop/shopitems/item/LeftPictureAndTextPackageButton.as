package alternativa.tanks.gui.shop.shopitems.item {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemSkins;
  import controls.base.LabelBase;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;

  public class LeftPictureAndTextPackageButton extends ShopItemButton {
    private static const LEFT_PADDING:int = 18;

    protected var nameLabel:LabelBase;

    public function LeftPictureAndTextPackageButton(param1:IGameObject) {
      super(param1,ShopItemSkins.GREY);
    }

    override protected function initLabels() : void {
      this.nameLabel = new LabelBase();
      this.nameLabel.text = this.getText();
      this.nameLabel.color = ColorConstants.SHOP_ITEM_NAME_LABEL_COLOR;
      this.nameLabel.autoSize = TextFieldAutoSize.LEFT;
      this.nameLabel.size = this.getNameLabelFontSize();
      this.nameLabel.bold = true;
      this.nameLabel.mouseEnabled = false;
      addChild(this.nameLabel);
      addPriceLabel();
    }

    protected function getText() : String {
      return "";
    }

    override protected function align() : void {
      if(preview != null) {
        preview.x = this.getPreviewLeftPadding();
        preview.y = HEIGHT - preview.height >> 1;
        this.nameLabel.x = preview.x + preview.width - 15;
        priceLabel.x = this.nameLabel.x;
      } else {
        this.nameLabel.x = COMMON_LEFT_MARGIN;
        priceLabel.x = this.nameLabel.x;
      }
      this.nameLabel.y = int(HEIGHT / 2) - this.nameLabel.height;
      priceLabel.y = int(HEIGHT / 2);
      if(hasDiscount()) {
        this.nameLabel.y -= 5;
        priceLabel.y -= 10;
        oldPriceSprite.x = priceLabel.x;
        oldPriceSprite.y = priceLabel.y + priceLabel.height - 5;
      }
    }

    protected function getPreviewLeftPadding() : int {
      return LEFT_PADDING - 5;
    }

    protected function getNameLabelFontSize() : int {
      return 30;
    }
  }
}
