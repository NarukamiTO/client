package alternativa.tanks.gui.notinclan.dialogs {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.models.user.ClanUserService;
  import controls.base.LabelBase;
  import controls.base.ThreeLineBigButton;
  import controls.windowinner.WindowInner;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.text.TextFormatAlign;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ClanLicenseDialog extends ClanDialog {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var clanUserService:ClanUserService;

    [Inject]
    public static var localeService:ILocaleService;

    public static const WIDTH:Number = 550;
    public static const HEIGHT:Number = 320;

    private var licenseImageClass:Class = ClanLicenseDialog_licenseImageClass;
    private var licenseImage:Bitmap = new this.licenseImageClass() as Bitmap;
    private var buyButton:ThreeLineBigButton;
    private var windowInner:WindowInner;
    private var textInfo:LabelBase;

    public function ClanLicenseDialog() {
      super();
      this.buyButton = new ThreeLineBigButton();
      this.buyButton.setText(localeService.getText(TanksLocale.TEXT_CLAN_BUY_LICENCE));
      this.textInfo = new LabelBase();
      this.textInfo.wordWrap = true;
      this.textInfo.align = TextFormatAlign.CENTER;
      this.textInfo.text = localeService.getText(TanksLocale.TEXT_CLAN_PURCHASE_INFORMATION);
      this.buyButton.x = WIDTH - this.buyButton.width >> 1;
      this.buyButton.y = HEIGHT - this.buyButton.height - MARGIN;
      this.windowInner = new WindowInner(0,0,WindowInner.GREEN);
      this.windowInner.x = MARGIN;
      this.windowInner.y = MARGIN;
      this.windowInner.width = WIDTH - 2 * MARGIN;
      this.windowInner.height = HEIGHT - this.buyButton.height - SMALL_MARGIN - 2 * MARGIN;
      this.licenseImage.x = SMALL_MARGIN;
      this.licenseImage.y = SMALL_MARGIN;
      this.licenseImage.width = this.windowInner.width - 2 * SMALL_MARGIN;
      this.licenseImage.height = this.licenseImage.bitmapData.height * this.licenseImage.width / this.licenseImage.bitmapData.width;
      this.textInfo.x = SMALL_MARGIN;
      this.textInfo.y = this.licenseImage.y + this.licenseImage.height + SMALL_MARGIN;
      this.textInfo.width = WIDTH - 2 * MARGIN;
      this.textInfo.height = this.windowInner.height - this.licenseImage.height - 3 * SMALL_MARGIN;
      window.addChild(this.buyButton);
      window.addChild(this.windowInner);
      this.windowInner.addChild(this.licenseImage);
      this.windowInner.addChild(this.textInfo);
      this.buyButton.addEventListener(MouseEvent.CLICK,this.onBuyButtonClick);
      this.buyButton.enabled = clanUserService.showBuyLicenseButton;
    }

    protected function onBuyButtonClick(param1:MouseEvent) : void {
      onCloseClick(param1);
      paymentDisplayService.openPaymentForGarageItem(clanUserService.licenseGarageObject);
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override protected function getImageHeaderId() : String {
      return TanksLocale.TEXT_HEADER_CLAN_LICENSE;
    }
  }
}
