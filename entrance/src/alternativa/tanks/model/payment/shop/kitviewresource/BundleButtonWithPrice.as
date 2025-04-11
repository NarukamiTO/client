package alternativa.tanks.model.payment.shop.kitviewresource {
  import alternativa.tanks.gui.shop.shopitems.item.base.ButtonItemSkin;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import flash.display.BitmapData;
  import platform.client.fp10.core.type.IGameObject;

  public class BundleButtonWithPrice extends ShopItemButton {
    private static const SIDE_PADDING:int = 25;
    private static const PRICE_BOTTOM_PADDING:int = 56;

    private var WIDTH:int;
    private var HEIGHT:int;

    public function BundleButtonWithPrice(param1:IGameObject, param2:BitmapData, param3:BitmapData) {
      var local4:ButtonItemSkin = null;
      local4 = new ButtonItemSkin();
      local4.normalState = param2;
      local4.overState = param3;
      this.WIDTH = param2.width;
      this.HEIGHT = param2.height;
      super(param1,local4);
    }

    override protected function initOldPriceParams() : void {
      super.initOldPriceParams();
      strikeoutLineThickness = 3;
      oldPriceLabelSize = this.getPriceLabelSize();
    }

    override protected function initLabels() : void {
      addPriceLabel();
      priceLabel.size = this.getPriceLabelSize();
      priceLabel.x = SIDE_PADDING;
      priceLabel.y = this.HEIGHT - PRICE_BOTTOM_PADDING;
    }

    private function getPriceLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 25;
        default:
          return 35;
      }
    }

    override public function get widthInCells() : int {
      return 3;
    }

    override protected function initPreview() : void {
    }

    override protected function setPreview() : void {
    }

    override public function get width() : Number {
      return this.WIDTH;
    }

    override public function get height() : Number {
      return this.HEIGHT;
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
