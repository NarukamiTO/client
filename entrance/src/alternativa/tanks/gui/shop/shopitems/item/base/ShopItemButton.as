package alternativa.tanks.gui.shop.shopitems.item.base {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.font.services.TanksFontsFormatService;
  import alternativa.tanks.gui.shop.shopitems.event.ShopItemChosen;
  import alternativa.tanks.gui.shop.shopitems.item.CountableItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscount;
  import alternativa.tanks.model.payment.shop.item.ShopItem;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackage;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.CapsStyle;
  import flash.display.LineScaleMode;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.services.timeunit.ITimeUnitService;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class ShopItemButton extends ShopButton implements IImageResource, ShopButtonClickDisable, ShopButtonDiscount {
    [Inject]
    public static var fontService:TanksFontsFormatService;

    [Inject]
    public static var timeUnitService:ITimeUnitService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    private static const bonusIconClass:Class = ShopItemButton_bonusIconClass;

    protected static const WIDTH:int = 279;
    protected static const HEIGHT:int = 143;
    protected static const COMMON_LEFT_MARGIN:int = 30;

    protected var bonusIcon:Bitmap = new Bitmap(new bonusIconClass().bitmapData);
    protected var item:IGameObject;
    protected var preview:Bitmap;
    protected var priceLabel:LabelBase;
    protected var oldPriceSprite:Sprite;
    protected var oldPriceLabel:LabelBase;
    protected var strikeoutLineThickness:Number;
    protected var strikeoutLineColor:uint;
    protected var oldPriceLabelSize:uint;

    private var discountEnabled:Boolean;
    private var priceWithDiscount:Number;
    private var buttonSkin:ButtonItemSkin;

    public function ShopItemButton(param1:IGameObject, param2:ButtonItemSkin) {
      this.item = param1;
      addEventListener(MouseEvent.CLICK,this.onMouseClick);
      this.buttonSkin = param2;
      super(this.buttonSkin);
    }

    override protected function init() : void {
      super.init();
      var local1:ImageResource = this.shopItem.getPreview();
      if(local1 != null) {
        if(local1.isLazy && !local1.isLoaded) {
          local1.loadLazyResource(new ImageResourceLoadingWrapper(this));
        } else {
          this.preview = new Bitmap(local1.data);
        }
      }
      this.discountEnabled = this.isShopItemDiscountEnabled();
      this.priceWithDiscount = this.shopItem.getPriceWithDiscount();
      this.initOldPriceParams();
      this.initOldPriceLabel();
      this.initLabels();
      this.initPreview();
      this.align();
      this.addDiscountLabelIfHasDiscount();
    }

    protected function initLabels() : void {
    }

    protected function initOldPriceParams() : void {
      this.strikeoutLineThickness = 1;
      this.strikeoutLineColor = ColorConstants.SHOP_MONEY_TEXT_LABEL_COLOR;
      this.oldPriceLabelSize = 16;
    }

    private function initOldPriceLabel() : void {
      this.oldPriceSprite = new Sprite();
      this.oldPriceLabel = new LabelBase();
      this.oldPriceLabel.text = this.getOldPriceLabelText();
      this.oldPriceLabel.color = this.strikeoutLineColor;
      this.oldPriceLabel.autoSize = TextFieldAutoSize.LEFT;
      this.oldPriceLabel.size = this.oldPriceLabelSize;
      this.oldPriceLabel.bold = true;
      this.oldPriceLabel.mouseEnabled = false;
      this.oldPriceSprite.addChild(this.oldPriceLabel);
      var local1:int = 2;
      var local2:int = local1 + this.oldPriceLabel.textWidth;
      var local3:int = int(this.oldPriceLabel.height / 2);
      var local4:Shape = new Shape();
      local4.graphics.lineStyle(this.strikeoutLineThickness,this.strikeoutLineColor,1,true,LineScaleMode.NONE,CapsStyle.NONE);
      local4.graphics.moveTo(local1,local3);
      local4.graphics.lineTo(local2,local3);
      this.oldPriceSprite.addChild(local4);
    }

    private function getPriceLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 16;
        default:
          return 22;
      }
    }

    protected function addPriceLabel() : void {
      this.priceLabel = new LabelBase();
      this.priceLabel.text = this.getPriceLabelText();
      this.priceLabel.color = ColorConstants.SHOP_MONEY_TEXT_LABEL_COLOR;
      this.priceLabel.size = this.getPriceLabelSize();
      this.priceLabel.autoSize = TextFieldAutoSize.LEFT;
      this.priceLabel.bold = true;
      this.priceLabel.mouseEnabled = false;
      addChild(this.priceLabel);
      this.fixChineseCurrencyLabelRendering(this.priceLabel);
    }

    public function setPreviewResource(param1:ImageResource) : void {
      this.preview = new Bitmap(param1.data);
      this.updateLazyLoadedPreview();
    }

    protected function updateLazyLoadedPreview() : void {
      this.setPreview();
      this.align();
    }

    protected function initPreview() : void {
      if(this.preview != null) {
        this.setPreview();
      }
    }

    protected function setPreview() : void {
      addChildAt(this.preview,2);
    }

    protected function get shopItem() : ShopItem {
      return ShopItem(this.item.adapt(ShopItem));
    }

    protected function fixChineseCurrencyLabelRendering(param1:LabelBase) : void {
      if(this.shopItem.getCurrencyName() == "元") {
        param1.embedFonts = fontService.isEmbeddedFontsInLang("cn");
        param1.setTextFormat(fontService.getFontsFormatInLang("cn"));
      }
    }

    private function onMouseClick(param1:MouseEvent) : void {
      dispatchEvent(new ShopItemChosen(this.item));
    }

    public function applyPayModeDiscountAndUpdatePriceLabel(param1:IGameObject) : void {
      if(this.item.hasModel(SpecialKitPackage)) {
        this.priceLabel.text = this.getPriceLabelText();
        return;
      }
      var local2:ShopDiscount = ShopDiscount(param1.adapt(ShopDiscount));
      this.priceWithDiscount = local2.applyDiscount(this.priceWithDiscount);
      this.discountEnabled = this.discountEnabled || Boolean(local2.isEnabled());
      if(this.isShopItemDiscountEnabled()) {
        this.priceLabel.text = this.getPriceLabelText();
      } else {
        this.addDiscountLabelIfHasDiscount();
      }
    }

    private function addDiscountLabelIfHasDiscount() : void {
      var local1:Bitmap = null;
      if(this.hasDiscount()) {
        this.priceLabel.text = this.getPriceLabelText();
        addChild(this.oldPriceSprite);
        this.align();
        local1 = salesIcon;
      }
      if(paymentWindowService.hasBonusForItem(this.item)) {
        if(this is CountableItemButton) {
          if(CountableItemButton(this).getCount() > 1) {
            local1 = this.bonusIcon;
          }
        } else {
          local1 = this.bonusIcon;
        }
      }
      if(local1 != null) {
        this.addCornerIcon(local1);
      }
    }

    private function addCornerIcon(param1:Bitmap) : void {
      param1.x = x + this.buttonSkin.normalState.width - param1.width - 8;
      param1.y = y + 7;
      addChild(param1);
    }

    protected function getPriceWithDiscount() : Number {
      return this.priceWithDiscount;
    }

    protected function hasDiscount() : Boolean {
      return this.discountEnabled;
    }

    private function isShopItemDiscountEnabled() : Boolean {
      return ShopDiscount(this.item.adapt(ShopDiscount)).isEnabled();
    }

    protected function getPriceLabelText() : String {
      return this.getFormattedPriceText(this.getPriceWithDiscount()) + " " + this.shopItem.getCurrencyName();
    }

    protected function getOldPriceLabelText() : String {
      return this.getFormattedPriceText(this.shopItem.getPrice()) + " " + this.shopItem.getCurrencyName();
    }

    protected function getFormattedPriceText(param1:Number) : String {
      return FormatUtils.valueToString(param1,this.shopItem.getCurrencyRoundingPrecision(),false);
    }

    protected function align() : void {
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function destroy() : void {
      super.destroy();
      this.item = null;
      removeEventListener(MouseEvent.CLICK,this.onMouseClick);
    }

    public function disableClick() : * {
      alpha = 0.9;
      mouseEnabled = false;
    }
  }
}
