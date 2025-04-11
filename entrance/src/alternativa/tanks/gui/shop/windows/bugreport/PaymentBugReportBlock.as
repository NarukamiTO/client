package alternativa.tanks.gui.shop.windows.bugreport {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.emailreminder.EmailReminderService;
  import alternativa.tanks.model.payment.saveprocessed.ProcessedPaymentInfo;
  import alternativa.tanks.model.payment.saveprocessed.ProcessedPaymentService;
  import alternativa.tanks.service.settings.ISettingsService;
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.URLVariables;
  import flash.net.navigateToURL;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.UidUtil;

  public class PaymentBugReportBlock extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var emailReminderService:EmailReminderService;

    [Inject]
    public static var processedPaymentService:ProcessedPaymentService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private static const WINDOW_MARGIN:int = 11;
    private static const SPACE_MODULE:int = 7;
    private static const HEIGHT:int = 45;

    private var errorInner:TankWindowInner;
    private var errorButton:DefaultButtonBase;
    private var errorLabel:LabelBase;
    private var _width:Number;

    public function PaymentBugReportBlock() {
      super();
      this.errorInner = new TankWindowInner(0,0,TankWindowInner.TRANSPARENT);
      this.errorInner.height = HEIGHT;
      addChild(this.errorInner);
      this.errorLabel = new LabelBase();
      this.errorLabel.multiline = true;
      this.errorLabel.wordWrap = true;
      this.errorLabel.text = localeService.getText(TanksLocale.TEXT_PAYMENT_BUG_REPORT_INFO);
      this.errorLabel.x = WINDOW_MARGIN;
      addChild(this.errorLabel);
      this.errorButton = new DefaultButtonBase();
      this.errorButton.label = localeService.getText(TanksLocale.TEXT_PAYMENT_BUTTON_SEND_BUG_REPORT_TEXT);
      this.errorButton.addEventListener(MouseEvent.CLICK,this.onErrorButtonClick);
      this.errorButton.y = SPACE_MODULE;
      addChild(this.errorButton);
    }

    private function onErrorButtonClick(param1:MouseEvent) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_SHOP_PAYMENT_BUG_REPORT_LINK);
      if(settingsService.isNeedEmailRemind()) {
        emailReminderService.showEmailReminder();
        return;
      }
      var local3:URLRequest = new URLRequest(local2);
      var local4:ProcessedPaymentInfo = processedPaymentService.getLastProcessedPaymentInfo();
      local3.data = Boolean(local4) ? this.fillURLParamsForSendError(local4) : new URLVariables();
      local3.data.user = UidUtil.userNameWithoutClanTag(userPropertiesService.userName);
      navigateToURL(local3,"_blank");
    }

    private function fillURLParamsForSendError(param1:ProcessedPaymentInfo) : URLVariables {
      var local2:URLVariables = new URLVariables();
      local2.currencyName = param1.currencyName;
      local2.itemFinalPrice = param1.itemFinalPrice;
      local2.itemId = param1.itemId;
      local2.payModeId = param1.payModeId;
      local2.payModeName = param1.payModeName;
      local2.date = param1.date;
      local2.time = param1.time;
      return local2;
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function set height(param1:Number) : void {
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.errorInner.width = this._width;
      this.errorButton.x = this._width - this.errorButton.width - WINDOW_MARGIN;
      this.errorLabel.width = this.errorButton.x - this.errorLabel.x - WINDOW_MARGIN;
      this.errorLabel.y = int((HEIGHT - this.errorLabel.height) * 0.5);
    }
  }
}
