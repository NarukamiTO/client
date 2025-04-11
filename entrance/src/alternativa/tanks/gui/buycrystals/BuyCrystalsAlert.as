package alternativa.tanks.gui.buycrystals {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import forms.base.BaseFormWithInner;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class BuyCrystalsAlert extends DialogWindow {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    private static const bitmapClass:Class = BuyCrystalsAlert_bitmapClass;

    public static const image:Bitmap = new Bitmap(new bitmapClass().bitmapData);

    private static const plusBitmapClass:Class = BuyCrystalsAlert_plusBitmapClass;

    public static const plus:Bitmap = new Bitmap(new plusBitmapClass().bitmapData);

    private static const VERTICAL_MARGIN:int = 8;

    private var baseFormWithInner:BaseFormWithInner;
    private var buyButton:DefaultButtonBase;
    private var closeButton:DefaultButtonBase;
    private var buyCaption:Sprite;
    private var label:LabelBase;
    private var crystals:int;

    public function BuyCrystalsAlert(param1:int) {
      super();
      this.crystals = param1;
      this.baseFormWithInner = new BaseFormWithInner(416,270,30);
      addChild(this.baseFormWithInner);
      this.baseFormWithInner.window.setHeaderId(TanksLocale.TEXT_HEADER_ATTENTION);
      this.buyButton = new DefaultButtonBase();
      this.buyButton.width = 150;
      this.buyCaption = new Sprite();
      this.label = new MouseDisabledLabel();
      this.label.text = localeService.getText(TanksLocale.TEXT_GARAGE_BUY_TEXT);
      this.label.y = 5;
      plus.y = (this.buyButton.height - plus.height) * 0.5;
      this.label.x = plus.width;
      this.buyCaption.addChild(plus);
      this.buyCaption.addChild(this.label);
      this.buyButton.x = this.baseFormWithInner.inner.x;
      this.buyButton.y = this.baseFormWithInner.inner.y + this.baseFormWithInner.inner.height + VERTICAL_MARGIN;
      this.buyCaption.x = int(this.buyButton.x + (this.buyButton.width - this.buyCaption.width) * 0.5);
      this.buyCaption.y = this.buyButton.y;
      this.baseFormWithInner.window.addChild(this.buyButton);
      this.buyCaption.mouseEnabled = false;
      this.buyCaption.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      this.baseFormWithInner.window.addChild(this.buyCaption);
      this.closeButton = new DefaultButtonBase();
      this.closeButton.width = 95;
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_GARAGE_CLOSE_TEXT);
      this.closeButton.y = this.buyButton.y;
      this.closeButton.x = this.baseFormWithInner.inner.x + this.baseFormWithInner.inner.width - this.closeButton.width;
      var local2:Bitmap = new Bitmap(localeService.getImage(TanksLocale.IMAGE_GARAGE_ADD_MORE_CRYSTALS));
      local2.x = int((this.baseFormWithInner.inner.width - local2.width) / 2);
      local2.y = 14;
      this.baseFormWithInner.inner.addChild(local2);
      image.x = (this.baseFormWithInner.inner.width - image.width) * 0.5 + 3;
      image.y = local2.y + local2.height + 3;
      this.baseFormWithInner.inner.addChild(image);
      this.baseFormWithInner.window.addChild(this.closeButton);
      this.buyButton.addEventListener(MouseEvent.CLICK,this.onBuy);
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCancel);
      dialogService.addDialog(this);
    }

    public function onBuy(param1:Event = null) : void {
      this.hide();
      display.stage.focus = null;
      paymentDisplayService.openPaymentAt(ShopCategoryEnum.CRYSTALS);
    }

    public function onCancel(param1:Event = null) : void {
      this.hide();
    }

    private function hide() : void {
      this.buyButton.removeEventListener(MouseEvent.CLICK,this.onBuy);
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCancel);
      dialogService.removeDialog(this);
    }

    override protected function cancelKeyPressed() : void {
      this.onCancel();
    }

    override protected function confirmationKeyPressed() : void {
      this.onBuy();
    }
  }
}
