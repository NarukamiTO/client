package alternativa.tanks.gui.shop.windows {
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.components.paymentview.PaymentView;
  import alternativa.tanks.gui.shop.components.window.ShopWindowHeader;
  import alternativa.tanks.gui.shop.components.window.ShopWindowNavigationBar;
  import alternativa.tanks.gui.shop.windows.bugreport.PaymentBugReportBlock;
  import alternativa.tanks.model.coin.CoinInfoService;
  import alternativa.tanks.model.coin.CoinsChangedEvent;
  import alternativa.tanks.model.payment.paymentstate.PaymentState;
  import alternativa.tanks.model.payment.shop.notification.service.ShopNotifierService;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.tracker.ITrackerService;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.TankWindowWithHeader;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.commons.socialnetwork.SocialNetworkEnum;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class ShopWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var clientLog:IClientLog;

    [Inject]
    public static var dialogsService:IDialogsService;

    [Inject]
    public static var userPropertyService:IUserPropertiesService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var shopNotifierService:ShopNotifierService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var coinInfoService:CoinInfoService;

    public static const WINDOW_PADDING:int = 11;
    public static const WINDOW_WIDTH:int = 915;

    private static const WINDOW_MAX_HEIGHT:int = 691;
    private static const WINDOW_MIN_HEIGHT:int = 580;

    private var window:TankWindowWithHeader;
    private var header:ShopWindowHeader;
    private var headerLayerIndex:int;
    private var navigationBar:ShopWindowNavigationBar;
    private var paymentView:PaymentView;
    private var bugReportBlock:PaymentBugReportBlock;
    private var closeButton:DefaultButtonBase;
    private var eulaLink:LabelBase = new LabelBase();
    private var privacyAndCookiesLink:LabelBase = new LabelBase();
    private var purchaseInstructionLink:LabelBase = new LabelBase();
    private var params:ShopWindowParams;
    private var nextXPosition:Number = 11;
    private var coinsLabel:LabelBase = new LabelBase();

    public function ShopWindow(param1:ShopWindowParams) {
      super();
      this.params = param1;
      this.createWindow();
      this.createWindowHeader();
      this.createNavigationBar();
      this.createBugReportBlock();
      this.createCloseButton();
      if(this.needLinks()) {
        this.createLinks();
      }
      this.createCoinLabel();
      shopNotifierService.hideNotification();
    }

    private function createCoinLabel() : void {
      this.coinsLabel.x = this.nextXPosition;
      this.coinsLabel.text = coinInfoService.getCoins().toString();
      coinInfoService.addEventListener(CoinsChangedEvent.EVENT_TYPE,this.onCoinsChanged);
      if(coinInfoService.enabled) {
        addChild(this.coinsLabel);
      }
    }

    private function onCoinsChanged(param1:CoinsChangedEvent) : void {
      this.coinsLabel.text = param1.coins.toString();
    }

    private function needLinks() : Boolean {
      return partnerService.getEnvironmentPartnerId() != SocialNetworkEnum.ODNOKLASSNIKI_INTERNAL.name.toLocaleLowerCase();
    }

    private function createWindow() : void {
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_MONEYSHOP);
      this.window.width = WINDOW_WIDTH;
      addChild(this.window);
    }

    private function createWindowHeader() : void {
      this.header = new ShopWindowHeader(localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_HEADER_DESCRIPTION));
      this.header.x = WINDOW_PADDING;
      this.header.y = WINDOW_PADDING;
      this.header.resize(WINDOW_WIDTH - WINDOW_PADDING * 2);
      addChild(this.header);
      this.headerLayerIndex = numChildren;
    }

    private function createNavigationBar() : void {
      this.navigationBar = new ShopWindowNavigationBar(this.params.shopCategories,this.params.shopItems);
      this.navigationBar.y = this.header.y + this.header.height;
      this.navigationBar.resize(WINDOW_WIDTH);
      addChild(this.navigationBar);
    }

    private function createBugReportBlock() : void {
      this.bugReportBlock = new PaymentBugReportBlock();
      this.bugReportBlock.x = WINDOW_PADDING;
      addChild(this.bugReportBlock);
    }

    private function createCloseButton() : void {
      this.closeButton = new DefaultButtonBase();
      this.closeButton.tabEnabled = false;
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.x = WINDOW_WIDTH - this.closeButton.width - 2 * WINDOW_PADDING;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCancelClick);
      addChild(this.closeButton);
    }

    private function createLinks() : void {
      var local1:String = localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_PURCHASE_INSTRUCTION);
      if(local1 != "") {
        this.purchaseInstructionLink.htmlText = local1;
        this.purchaseInstructionLink.x = this.nextXPosition;
        addChild(this.purchaseInstructionLink);
        this.nextXPosition += this.purchaseInstructionLink.textWidth + WINDOW_PADDING * 2;
      }
      var local2:String = localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_EULA_LINK);
      if(local2 != "") {
        this.eulaLink.htmlText = local2;
        this.eulaLink.x = this.nextXPosition;
        addChild(this.eulaLink);
        this.nextXPosition += this.eulaLink.textWidth + WINDOW_PADDING * 2;
      }
      var local3:String = localeService.getText(TanksLocale.TEXT_SHOP_WINDOW_PRIVACY_AND_COOKIES_POLICY_LINK);
      if(local3 != "") {
        this.privacyAndCookiesLink.htmlText = local3;
        this.privacyAndCookiesLink.x = this.nextXPosition;
        addChild(this.privacyAndCookiesLink);
        this.nextXPosition += this.privacyAndCookiesLink.textWidth + WINDOW_PADDING * 2;
      }
    }

    public function show() : void {
      display.stage.addEventListener(Event.RESIZE,this.render);
      this.render();
      dialogsService.addDialog(this);
    }

    public function navigateToCategory(param1:ShopCategoryEnum) : void {
      if(param1 != ShopCategoryEnum.NO_CATEGORY) {
        this.navigationBar.navigateToCategoryByType(param1);
      }
    }

    public function switchToPaymentState(param1:PaymentState, param2:PaymentView) : void {
      if(Boolean(this.paymentView) && contains(this.paymentView)) {
        removeChild(this.paymentView);
        this.paymentView.destroy();
      }
      this.paymentView = param2;
      this.paymentView.window = this;
      addChildAt(this.paymentView,this.headerLayerIndex - 1);
      this.navigationBar.switchToState(param1);
      this.render();
      this.paymentView.postRender();
    }

    public function get currentPaymentView() : PaymentView {
      return this.paymentView;
    }

    private function onCancelClick(param1:MouseEvent) : void {
      this.cancelKeyPressed();
    }

    override protected function cancelKeyPressed() : void {
      paymentDisplayService.closePayment();
    }

    public function destroy() : void {
      if(Boolean(this.paymentView)) {
        this.paymentView.destroy();
      }
      this.navigationBar.destroy();
      display.stage.removeEventListener(Event.RESIZE,this.render);
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCancelClick);
      coinInfoService.removeEventListener(CoinsChangedEvent.EVENT_TYPE,this.onCoinsChanged);
      dialogsService.removeDialog(this);
      display.stage.focus = null;
    }

    public function render(param1:Event = null) : void {
      this.window.height = Math.round(Math.max(WINDOW_MIN_HEIGHT,Math.min(display.stage.stageHeight - 60,WINDOW_MAX_HEIGHT)));
      this.closeButton.y = this.window.height - this.closeButton.height - WINDOW_PADDING;
      this.eulaLink.y = this.privacyAndCookiesLink.y = this.purchaseInstructionLink.y = this.window.height - this.eulaLink.height - WINDOW_PADDING;
      this.coinsLabel.y = this.eulaLink.y;
      this.bugReportBlock.y = this.closeButton.y - this.bugReportBlock.height - 3;
      this.bugReportBlock.width = WINDOW_WIDTH - WINDOW_PADDING - this.bugReportBlock.x;
      if(Boolean(this.paymentView)) {
        this.paymentView.x = WINDOW_PADDING;
        this.paymentView.y = this.header.y + this.header.height + this.navigationBar.height;
        this.paymentView.render(WINDOW_WIDTH - WINDOW_PADDING * 2,this.bugReportBlock.y - this.paymentView.y - 3);
      }
    }

    override public function get height() : Number {
      return this.window.height;
    }

    override public function get width() : Number {
      return this.window.width;
    }
  }
}
