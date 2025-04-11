package alternativa.tanks.gui.shop.shopitems.item.kits.serverlayoutkit {
  import alternativa.tanks.gui.shop.shopitems.event.ShopItemChosen;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButtonClickDisable;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopButtonDiscount;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.model.payment.shop.item.ShopItem;
  import controls.Label;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.text.TextFormat;
  import platform.client.fp10.core.resource.BatchResourceLoader;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.clientlayoutkit.KitBundleViewCC;

  public class KitBundleButton extends ShopButton implements ShopButtonClickDisable, ShopButtonDiscount {
    private var cc:KitBundleViewCC;

    protected var item:IGameObject;

    private const BUNDLE_WIDTH:Number = 279;
    private const BUNDLE_HEIGHT:Number = 143;
    private const DEFAULT_FONT_SIZE:Number = 22;

    public function KitBundleButton(param1:IGameObject, param2:KitBundleViewCC) {
      super(new KitBundleSkin(param2));
      this.cc = param2;
      this.item = param1;
      this.initImages();
      addEventListener(MouseEvent.CLICK,this.onMouseClick);
    }

    override public function get widthInCells() : int {
      return 3;
    }

    private function onMouseClick(param1:MouseEvent) : void {
      dispatchEvent(new ShopItemChosen(this.item));
    }

    private function initImages() : * {
      var i:* = undefined;
      var image:* = undefined;
      var resources:Vector.<Resource> = new Vector.<Resource>();
      for(i in this.cc.imageBlocks) {
        image = this.cc.imageBlocks[i].image;
        if(image.isLazy && !image.isLoaded && resources.indexOf(image) < 0) {
          resources.push(image);
        }
      }
      if(resources.length > 0) {
        new BatchResourceLoader(function():void {
          onImageLoaded();
        }).load(resources);
      } else {
        this.onImageLoaded();
      }
    }

    private function onImageLoaded() : * {
      var local1:* = undefined;
      var local2:* = undefined;
      var local3:* = undefined;
      for(local1 in this.cc.imageBlocks) {
        local2 = this.cc.imageBlocks[local1];
        local3 = new Bitmap(local2.image.data);
        local3.x = this.getXPosition(local2.positionPercentX);
        local3.y = this.getYPosition(local2.positionPercentY);
        addChild(local3);
      }
      this.initTexts();
      this.initPrice();
    }

    private function initTexts() : * {
      var local1:* = undefined;
      var local2:* = undefined;
      var local3:Label = null;
      var local4:* = undefined;
      for(local1 in this.cc.textBlocks) {
        local2 = this.cc.textBlocks[local1];
        local3 = new LabelBase();
        local4 = this.getFontSize(local2.fontPercentSize);
        local3.color = local2.color;
        local3.size = local4;
        local3.bold = true;
        local3.setTextFormat(new TextFormat());
        local3.text = local2.text;
        local3.mouseEnabled = false;
        local3.x = this.getXPosition(local2.positionPercentX);
        local3.y = this.getYPosition(local2.positionPercentY) - local3.height + local4;
        addChild(local3);
      }
    }

    private function initPrice() : * {
      var local1:Label = new LabelBase();
      local1.color = this.cc.priceLabelColor;
      var local2:Number = this.getFontSize(this.cc.priceLabelFontPercentSize);
      local1.size = local2;
      local1.bold = true;
      local1.htmlText = this.getPriceLabelText();
      local1.mouseEnabled = false;
      local1.x = this.getXPosition(this.cc.priceLabelPositionPercentX);
      local1.y = this.getYPosition(this.cc.priceLabelPositionPercentY) - local1.height + local2;
      addChild(local1);
    }

    protected function get shopItem() : ShopItem {
      return ShopItem(this.item.adapt(ShopItem));
    }

    private function getPriceLabelText() : String {
      return this.getFormattedPriceText(this.getPriceWithDiscount()) + " " + this.shopItem.getCurrencyName();
    }

    private function getFormattedPriceText(param1:Number) : String {
      return FormatUtils.valueToString(param1,this.shopItem.getCurrencyRoundingPrecision(),false);
    }

    protected function getPriceWithDiscount() : Number {
      return this.shopItem.getPriceWithDiscount();
    }

    private function getFontSize(param1:int) : Number {
      return param1 == int.MIN_VALUE ? this.DEFAULT_FONT_SIZE : this.DEFAULT_FONT_SIZE * param1 / 100;
    }

    private function getYPosition(param1:int) : Number {
      return this.BUNDLE_HEIGHT * param1 / 100;
    }

    private function getXPosition(param1:int) : Number {
      return (this.BUNDLE_WIDTH + 2) * this.widthInCells * param1 / 100;
    }

    public function disableClick() : * {
      alpha = 0.9;
      mouseEnabled = false;
    }

    public function applyPayModeDiscountAndUpdatePriceLabel(param1:IGameObject) : void {
    }
  }
}
