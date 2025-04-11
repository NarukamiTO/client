package alternativa.tanks.service.payment.display {
  import alternativa.tanks.loader.IModalLoaderService;
  import alternativa.tanks.model.payment.PaymentUtils;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.country.CountryService;
  import alternativa.tanks.service.payment.IPaymentService;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import platform.client.fp10.core.type.IGameObject;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentDisplayServiceUnloadEvent;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentLoadWithCategoryEvent;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentLoadWithGarageItemEvent;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentLoadWithShopItemEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;

  public class PaymentDisplayServiceImpl extends EventDispatcher implements PaymentDisplayService {
    [Inject]
    public static var countryService:CountryService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    [Inject]
    public static var userPaymentActionsService:UserPaymentActionsService;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var achievementService:IAchievementService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    private var paymentDisplayed:Boolean = false;
    private var reloadingState:Boolean = false;
    private var loadEvent:Event;

    public function PaymentDisplayServiceImpl() {
      super();
    }

    public function openPaymentAt(param1:ShopCategoryEnum) : void {
      this.openPaymentForAnyPurpose(new PaymentLoadWithCategoryEvent(param1));
    }

    public function openPaymentForGarageItem(param1:IGameObject) : void {
      this.openPaymentForAnyPurpose(new PaymentLoadWithGarageItemEvent(param1));
    }

    public function openPayment() : void {
      this.openPaymentForAnyPurpose(new PaymentLoadWithCategoryEvent(ShopCategoryEnum.NO_CATEGORY));
    }

    public function openPaymentForShopItem(param1:IGameObject) : void {
      this.openPaymentForAnyPurpose(new PaymentLoadWithShopItemEvent(param1));
    }

    private function openPaymentForAnyPurpose(param1:Event) : void {
      if(!paymentService.isEnabled()) {
        return;
      }
      if(this.loadEvent != null) {
        return;
      }
      userChangeGameScreenService.paymentWindowOpened();
      userPaymentActionsService.openPayment(this.getCurrentStateName());
      if(partnerService.hasPaymentAction()) {
        partnerService.makePaymentAction();
        return;
      }
      if(paymentService.isPaymentInLinkMode()) {
        this.openPaymentLink();
        return;
      }
      this.loadEvent = param1;
      countryService.chooseCountryForPayment();
    }

    public function closePayment() : void {
      userPaymentActionsService.closePayment(this.getCurrentStateName());
      userChangeGameScreenService.paymentWindowClosed();
      this.unloadPayment();
    }

    public function reloadPayment() : void {
      this.reloadingState = true;
      this.unloadPayment();
      this.loadPayment();
    }

    private function unloadPayment() : void {
      dispatchEvent(new PaymentDisplayServiceUnloadEvent());
      this.paymentDisplayed = false;
    }

    public function loadPayment() : void {
      blurService.blurGameContent();
      modalLoaderService.show();
      this.paymentDisplayed = true;
      this.sendLoadEvent();
    }

    public function handlePaymentLoadingComplete() : void {
      this.reloadingState = false;
      modalLoaderService.hideForcibly();
    }

    public function handlePaymentUnloadingComplete() : void {
      if(this.reloadingState) {
        blurService.blurGameContent();
      }
    }

    private function sendLoadEvent() : void {
      dispatchEvent(this.loadEvent);
      this.loadEvent = null;
    }

    public function isPaymentDisplayed() : Boolean {
      return this.paymentDisplayed;
    }

    private function openPaymentLink() : void {
      var local1:URLRequest = PaymentUtils.createUrlRequest(paymentService.getPaymentUrl());
      navigateToURL(local1,"_blank");
    }

    private function getCurrentStateName() : String {
      return lobbyLayoutService.getCurrentState().name;
    }
  }
}
