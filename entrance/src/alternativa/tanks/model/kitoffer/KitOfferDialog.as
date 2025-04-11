package alternativa.tanks.model.kitoffer {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.model.quest.common.gui.window.buttons.skin.GreenBigButtonSkin;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.ThreeLineBigButton;
  import controls.windowinner.WindowInner;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import forms.TankWindowWithHeader;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.kitoffer.KitOfferInfo;
  import projects.tanks.client.panel.model.kitoffer.log.KitOfferAction;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class KitOfferDialog extends DialogWindow implements IImageResource {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const IMAGE_WIDTH:int = 700;
    private static const IMAGE_HEIGHT:int = 500;
    private static const IMAGE_HOLDER_MARGIN:int = 2;
    private static const IMAGE_HOLDER_WIDTH:int = IMAGE_WIDTH + IMAGE_HOLDER_MARGIN * 2;
    private static const IMAGE_HOLDER_HEIGHT:int = IMAGE_HEIGHT + IMAGE_HOLDER_MARGIN * 2;
    private static const MARGIN:int = 10;
    private static const FOOTER_HEIGHT:int = 60;
    private static const WIDTH:int = IMAGE_HOLDER_WIDTH + 2 * MARGIN;
    private static const HEIGHT:int = IMAGE_HOLDER_HEIGHT + FOOTER_HEIGHT + 2 * MARGIN;

    private var info:KitOfferInfo;
    private var window:TankWindowWithHeader;
    private var buyButton:ThreeLineBigButton;
    private var closeButton:DefaultButtonBase;
    private var imageHolder:WindowInner;
    private var picture:Bitmap;
    private var priceLabel:LabelBase;

    public function KitOfferDialog(param1:KitOfferInfo) {
      super();
      this.info = param1;
      this.addWindow();
      this.addShopButton();
      this.addWindowInner();
      this.addImage();
      this.addPrice();
      this.addCloseButton();
    }

    private function addPrice() : void {
      this.priceLabel = new LabelBase();
      this.priceLabel.color = ColorConstants.WHITE;
      this.priceLabel.align = TextFormatAlign.CENTER;
      this.priceLabel.size = 26;
      this.priceLabel.bold = true;
      this.priceLabel.text = FormatUtils.valueToString(this.info.price,this.info.currencyRoundPrecision,false) + " " + this.info.currencyName;
      this.priceLabel.x = 592 - this.priceLabel.width / 2;
      this.priceLabel.y = 345 - this.priceLabel.height / 2;
      this.imageHolder.addChild(this.priceLabel);
    }

    private function addImage() : void {
      this.picture = new Bitmap();
      this.imageHolder.addChild(this.picture);
      if(this.info.image.isLazy && !this.info.image.isLoaded) {
        this.info.image.loadLazyResource(new ImageResourceLoadingWrapper(this));
        return;
      }
      this.drawImage(this.info.image.data);
    }

    private function drawImage(param1:BitmapData) : void {
      this.picture.bitmapData = param1;
      this.picture.x = (this.imageHolder.width - this.picture.width) / 2;
      this.picture.y = (this.imageHolder.height - this.picture.height) / 2;
    }

    private function addWindowInner() : void {
      this.imageHolder = new WindowInner(IMAGE_HOLDER_WIDTH,IMAGE_HOLDER_HEIGHT,WindowInner.TRANSPARENT);
      this.window.addChild(this.imageHolder);
      this.imageHolder.x = this.imageHolder.y = MARGIN;
      this.imageHolder.buttonMode = true;
      this.imageHolder.addEventListener(MouseEvent.CLICK,this.pictureClickHandler);
    }

    private function pictureClickHandler(param1:MouseEvent) : void {
      dispatchEvent(new KitOfferResultEvent(KitOfferAction.PICTURE_CLICK));
      this.navigateToShop();
      this.close();
    }

    private function addWindow() : void {
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_ATTENTION,WIDTH,HEIGHT);
      addChild(this.window);
    }

    private function addShopButton() : void {
      this.buyButton = new ThreeLineBigButton();
      this.buyButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_BUY_TEXT));
      this.buyButton.setSkin(GreenBigButtonSkin.GREEN_SKIN);
      this.window.addChild(this.buyButton);
      this.buyButton.x = (this.window.width - this.buyButton.width) / 2;
      this.buyButton.y = this.window.height - this.buyButton.height - MARGIN;
      this.buyButton.addEventListener(MouseEvent.CLICK,this.buyButtonClickHandler);
    }

    private function buyButtonClickHandler(param1:MouseEvent) : void {
      dispatchEvent(new KitOfferResultEvent(KitOfferAction.BUY_BUTTON_CLICK));
      this.navigateToShop();
      this.close();
    }

    private function navigateToShop() : void {
      paymentDisplayService.openPaymentForShopItem(this.info.shopItem);
    }

    private function addCloseButton() : void {
      this.closeButton = new DefaultButtonBase();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.window.addChild(this.closeButton);
      this.closeButton.x = this.window.width - this.closeButton.width - MARGIN;
      this.closeButton.y = this.window.height - this.closeButton.height - MARGIN;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.closeButtonClickHandler);
    }

    private function closeButtonClickHandler(param1:MouseEvent) : void {
      dispatchEvent(new KitOfferResultEvent(KitOfferAction.EXIT_BUTTON_CLICK));
      this.close();
    }

    private function close() : void {
      this.picture.removeEventListener(MouseEvent.CLICK,this.pictureClickHandler);
      this.buyButton.removeEventListener(MouseEvent.CLICK,this.buyButtonClickHandler);
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.closeButtonClickHandler);
      dialogService.removeDialog(this);
      dispatchEvent(new Event(Event.CANCEL));
    }

    public function setPreviewResource(param1:ImageResource) : void {
      this.drawImage(param1.data);
    }

    override protected function cancelKeyPressed() : void {
      dispatchEvent(new KitOfferResultEvent(KitOfferAction.EXIT_BUTTON_CLICK));
      this.close();
    }
  }
}
