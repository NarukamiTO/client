package alternativa.tanks.gui.shop.shopitems.item.cashpackage {
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemButton;
  import alternativa.tanks.gui.shop.shopitems.item.base.ShopItemSkins;
  import alternativa.tanks.gui.shop.shopitems.item.crystalitem.CrystalPackageItemIcons;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.model.payment.shop.cashpackage.CashPackage;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class CashPackageButton extends ShopItemButton {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    protected static const LEFT_PADDING:int = 18;

    private static const RIGHT_PADDING:int = 18;
    private static const TOP_PADDING:int = 17;

    protected static const BOTTOM_PADDING:int = 17;

    private static const CASH_ICON_X:int = 153;
    private static const CASH_ICON_Y:int = -2;

    protected var cashLabel:LabelBase;
    protected var cashIcon:Bitmap;

    private var bonusCashLabel:LabelBase;
    private var bonusCashSecondLabel:LabelBase;
    private var bonusCashIcon:Bitmap;

    public function CashPackageButton(param1:IGameObject) {
      super(param1,ShopItemSkins.GREEN);
    }

    override protected function initLabels() : void {
      if(this.hasBonusCash) {
        this.initPackageWithBonusAmount();
      } else {
        this.initPackageWithoutBonus();
      }
      this.initCashAmountAndPriceInnerLabels();
    }

    private function getCashLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 25;
        default:
          return 30;
      }
    }

    private function getBonusSecondCashLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 15;
        default:
          return 19;
      }
    }

    private function getBonusCashLabelSize() : int {
      switch(localeService.language) {
        case "fa":
          return 15;
        default:
          return 22;
      }
    }

    private function initCashAmountAndPriceInnerLabels() : void {
      this.cashLabel = new LabelBase();
      this.cashLabel.text = FormatUtils.valueToString(this.cashPackage.getAmount(),0,false);
      this.cashLabel.color = ColorConstants.SHOP_CRYSTALS_TEXT_LABEL_COLOR;
      this.cashLabel.autoSize = TextFieldAutoSize.LEFT;
      this.cashLabel.size = this.getCashLabelSize();
      this.cashLabel.bold = true;
      this.cashLabel.mouseEnabled = false;
      addChild(this.cashLabel);
      this.cashIcon = new Bitmap(CrystalPackageItemIcons.crystalBlue);
      addChild(this.cashIcon);
      addPriceLabel();
    }

    private function initPackageWithBonusAmount() : void {
      if(paymentWindowService.hasBonusForItem(item)) {
        setSkin(ShopItemSkins.RED);
      }
      this.bonusCashLabel = new LabelBase();
      this.bonusCashLabel.text = "+" + FormatUtils.valueToString(this.cashPackage.getBonusAmount(),0,false);
      this.bonusCashLabel.color = 16777215;
      this.bonusCashLabel.autoSize = TextFieldAutoSize.LEFT;
      this.bonusCashLabel.size = this.getBonusCashLabelSize();
      this.bonusCashLabel.bold = true;
      this.bonusCashLabel.mouseEnabled = false;
      addChild(this.bonusCashLabel);
      this.bonusCashSecondLabel = new LabelBase();
      this.bonusCashSecondLabel.text = localeService.getText(TanksLocale.TEXT_CRYSTALS_PACKAGE_AS_GIFT);
      this.bonusCashSecondLabel.color = 16777215;
      this.bonusCashSecondLabel.autoSize = TextFieldAutoSize.LEFT;
      this.bonusCashSecondLabel.size = this.getBonusSecondCashLabelSize();
      this.bonusCashSecondLabel.mouseEnabled = false;
      addChild(this.bonusCashSecondLabel);
      this.bonusCashIcon = new Bitmap(CrystalPackageItemIcons.crystalWhite);
      addChild(this.bonusCashIcon);
    }

    private function initPackageWithoutBonus() : void {
      setSkin(ShopItemSkins.GREY);
    }

    private function get hasBonusCash() : Boolean {
      return this.cashPackage.getBonusAmount() != 0;
    }

    private function get cashPackage() : CashPackage {
      return CashPackage(item.adapt(CashPackage));
    }

    override protected function align() : void {
      this.cashLabel.x = LEFT_PADDING;
      this.cashLabel.y = TOP_PADDING;
      this.cashIcon.x = this.cashLabel.x + this.cashLabel.width + 3;
      this.cashIcon.y = TOP_PADDING + 8;
      priceLabel.x = LEFT_PADDING;
      priceLabel.y = this.cashLabel.y + this.cashLabel.height - 5;
      if(preview != null) {
        preview.x = CASH_ICON_X;
        preview.y = CASH_ICON_Y;
      }
      if(this.hasBonusCash) {
        this.bonusCashIcon.x = WIDTH - RIGHT_PADDING - this.bonusCashIcon.width;
        this.bonusCashLabel.x = this.bonusCashIcon.x - this.bonusCashLabel.width;
        this.bonusCashSecondLabel.x = this.bonusCashLabel.x;
        this.bonusCashSecondLabel.y = HEIGHT - BOTTOM_PADDING - this.bonusCashSecondLabel.height;
        this.bonusCashLabel.y = this.bonusCashSecondLabel.y - this.bonusCashSecondLabel.height + 4;
        this.bonusCashIcon.y = this.bonusCashLabel.y + 5;
      }
      if(hasDiscount()) {
        oldPriceSprite.x = priceLabel.x;
        oldPriceSprite.y = priceLabel.y + priceLabel.height - 5;
      }
    }
  }
}
