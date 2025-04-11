package alternativa.tanks.model.payment.paymentstate {
  import alternativa.model.description.IDescription;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.components.paymentview.PaymentView;
  import alternativa.tanks.gui.shop.events.ShopWindowBackButtonEvent;
  import alternativa.tanks.gui.shop.events.ShopWindowJumpButtonEvent;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.gui.shop.payment.PayModeChooseView;
  import alternativa.tanks.gui.shop.payment.PaymentFormOneTimePurchaseView;
  import alternativa.tanks.gui.shop.payment.PaymentFormView;
  import alternativa.tanks.gui.shop.payment.PaymentFormWithoutChosenItemView;
  import alternativa.tanks.gui.shop.payment.event.ApproveFormEvent;
  import alternativa.tanks.gui.shop.payment.event.PayModeChosen;
  import alternativa.tanks.gui.shop.paymentform.item.PaymentFormItemBase;
  import alternativa.tanks.gui.shop.shopitems.GoodsChooseView;
  import alternativa.tanks.gui.shop.shopitems.event.ShopItemChosen;
  import alternativa.tanks.gui.shop.shopitems.item.crystalonlypaymode.CrystalOnlyPayModeButton;
  import alternativa.tanks.gui.shop.windows.ShopWindow;
  import alternativa.tanks.gui.shop.windows.ShopWindowParams;
  import alternativa.tanks.model.emailreminder.EmailReminderService;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.CrystalsOnlyPaymentMode;
  import alternativa.tanks.model.payment.modes.braintree.BraintreePayment;
  import alternativa.tanks.model.payment.modes.paygarden.PayGardenPayment;
  import alternativa.tanks.model.payment.modes.paypal.PayPalPayment;
  import alternativa.tanks.model.payment.modes.pricerange.PriceRange;
  import alternativa.tanks.model.payment.shop.ShopItemView;
  import alternativa.tanks.model.payment.shop.category.ShopCategory;
  import alternativa.tanks.model.payment.shop.crystal.CrystalPackage;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscount;
  import alternativa.tanks.model.payment.shop.emailrequired.ShopItemEmailRequired;
  import alternativa.tanks.model.payment.shop.featuring.ShopItemFeaturing;
  import alternativa.tanks.model.payment.shop.item.ShopItem;
  import alternativa.tanks.model.payment.shop.itemcategory.ShopItemCategory;
  import alternativa.tanks.model.payment.shop.onetimepurchase.ShopItemOneTimePurchase;
  import alternativa.tanks.model.payment.shop.premium.PremiumPackage;
  import alternativa.tanks.model.payment.shop.specialkit.SinglePayMode;
  import alternativa.tanks.model.payment.shop.specialkit.SpecialKitPackage;
  import alternativa.tanks.model.payment.shop.specialkit.view.PayPalKitView;
  import alternativa.tanks.model.promo.ShopPromoCode;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.commons.socialnetwork.SocialNetworkEnum;
  import projects.tanks.client.panel.model.payment.modes.paygarden.PayGardenProductType;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;

  public class PaymentWindowServiceImpl implements PaymentWindowService {
    [Inject]
    public static var userPaymentActionsService:UserPaymentActionsService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var fullscreenService:FullscreenService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var emailReminderService:EmailReminderService;

    private static const FEATURING_FAKE_CATEGORY_ID:Long = Long.ZERO;

    private var window:ShopWindow;
    private var params:ShopWindowParams;
    private var crystalOnlyPayModes:Vector.<IGameObject> = new Vector.<IGameObject>();
    private var currentState:PaymentState;
    private var chosenItem:IGameObject;
    private var chosenPayMode:IGameObject;
    private var alreadyTriedToBuy:Object;
    private var savedScrollPosition:int;
    private var stopOnPaymentForm:Boolean;
    private var singleItemPayment:Boolean;

    public function PaymentWindowServiceImpl() {
      super();
    }

    public function buildWindow(param1:ShopWindowParams) : void {
      var local2:Vector.<IGameObject> = null;
      var local3:IGameObject = null;
      this.params = param1;
      this.window = new ShopWindow(this.params);
      this.alreadyTriedToBuy = {};
      this.stopOnPaymentForm = false;
      this.singleItemPayment = false;
      this.crystalOnlyPayModes = new Vector.<IGameObject>();
      this.window.addEventListener(ShopWindowBackButtonEvent.CLICK,this.onBackButtonClick);
      this.window.addEventListener(ShopWindowJumpButtonEvent.CLICK,this.onJumpButtonClick);
      if(this.params.shopItems.length == 1) {
        this.singleItemPayment = true;
        this.chosenItem = this.params.shopItems[0];
        if(this.params.paymentModes.length == 1) {
          this.stopOnPaymentForm = true;
          this.onItemChosen(new ShopItemChosen(this.chosenItem));
          return;
        }
      } else {
        local2 = new Vector.<IGameObject>();
        for each(local3 in param1.paymentModes) {
          if(local3.hasModel(CrystalsOnlyPaymentMode)) {
            this.crystalOnlyPayModes.push(local3);
          } else {
            local2.push(local3);
          }
        }
        param1.paymentModes = local2;
      }
      this.switchToBeginning();
    }

    public function switchToBeginning() : void {
      if(this.stopOnPaymentForm) {
        return;
      }
      this.switchToState(this.params.shopItems.length == 1 ? PaymentState.PAYMODE_CHOOSE : PaymentState.ITEM_CHOOSE);
    }

    private function switchToState(param1:PaymentState) : void {
      this.removeChooseListeners();
      this.currentState = param1;
      this.window.switchToPaymentState(param1,this.buildStateView(param1));
      this.setupChooseListeners();
    }

    private function buildStateView(param1:PaymentState) : PaymentView {
      switch(param1) {
        case PaymentState.ITEM_CHOOSE:
          return this.createGoodsChooseView();
        case PaymentState.PAYMODE_CHOOSE:
          return this.createPaymentChooseView();
        case PaymentState.PAY_FORM:
          return this.createPayFormView();
        case PaymentState.PAY_FORM_WITHOUT_CHOSEN_ITEM:
          return this.createPayFormWithoutChosenItem();
        case PaymentState.PAY_FORM_ONE_TIME_PURCHASE:
          return this.createPayFormForOneTimePurchase();
        default:
          return null;
      }
    }

    private function onBackButtonClick(param1:ShopWindowBackButtonEvent) : void {
      if(Boolean(this.chosenItem.hasModel(CrystalsOnlyPaymentMode)) && this.currentState == PaymentState.PAY_FORM_WITHOUT_CHOSEN_ITEM) {
        this.switchToState(PaymentState.ITEM_CHOOSE);
        return;
      }
      if(this.params.paymentModes.length == 1) {
        this.switchToState(PaymentState.ITEM_CHOOSE);
        return;
      }
      if(this.currentState == PaymentState.PAY_FORM_WITHOUT_CHOSEN_ITEM || this.currentState == PaymentState.PAY_FORM_ONE_TIME_PURCHASE) {
        this.switchToState(PaymentState.PAYMODE_CHOOSE);
        return;
      }
      var local2:int = int(PaymentState.PAYMENT_FLOW.indexOf(this.currentState));
      var local3:PaymentState = PaymentState.PAYMENT_FLOW[local2 - 1];
      this.switchToState(local3);
    }

    private function onJumpButtonClick(param1:ShopWindowJumpButtonEvent) : void {
      (this.window.currentPaymentView as GoodsChooseView).jumpToCategory(param1.categoryId);
    }

    public function show() : void {
      this.window.show();
      this.window.navigateToCategory(this.params.currentShopCategoryType);
    }

    public function destroy() : void {
      if(Boolean(this.window)) {
        this.removeChooseListeners();
        this.window.removeEventListener(ShopWindowBackButtonEvent.CLICK,this.onBackButtonClick);
        this.window.removeEventListener(ShopWindowJumpButtonEvent.CLICK,this.onJumpButtonClick);
        this.window.destroy();
        this.window = null;
        this.params = null;
        this.chosenItem = null;
        this.chosenPayMode = null;
      }
    }

    private function hasCrystalOnlyPayMode() : Boolean {
      return this.crystalOnlyPayModes.length != 0;
    }

    private function createGoodsChooseView() : GoodsChooseView {
      var local3:IGameObject = null;
      var local6:IGameObject = null;
      var local7:String = null;
      var local8:String = null;
      var local9:IGameObject = null;
      var local10:IGameObject = null;
      var local11:ShopItemFeaturing = null;
      var local1:GoodsChooseView = new GoodsChooseView();
      if(this.hasFeaturedShopItems()) {
        local1.addShopCategory(FEATURING_FAKE_CATEGORY_ID,localeService.getText(TanksLocale.TEXT_SHOP_FEATURING_HEADER),localeService.getText(TanksLocale.TEXT_SHOP_FEATURING_DESCRIPTION));
      }
      var local2:Vector.<IGameObject> = this.params.shopCategories;
      for each(local3 in local2) {
        local7 = IDescription(local3.adapt(IDescription)).getName();
        local8 = IDescription(local3.adapt(IDescription)).getDescription();
        local1.addShopCategory(local3.id,local7,local8);
      }
      if(this.hasCrystalOnlyPayMode()) {
        local9 = this.getLastShopCategory();
        for each(local10 in this.crystalOnlyPayModes) {
          local1.addItem(new CrystalOnlyPayModeButton(local10),local9.id);
        }
      }
      var local4:Vector.<IGameObject> = this.params.shopItems;
      var local5:Vector.<IGameObject> = new Vector.<IGameObject>();
      for each(local6 in local4) {
        local11 = ShopItemFeaturing(local6.adapt(ShopItemFeaturing));
        if(!local11.isHiddenInOriginalCategory()) {
          local1.addItem(ShopItemView(local6.adapt(ShopItemView)).getButtonView(),ShopItemCategory(local6.adapt(ShopItemCategory)).getCategory().id);
        }
        if(local11.isLocatedInFeaturingCategory()) {
          local5.push(local6);
        }
      }
      this.addFeaturedItemsToView(local5,local1);
      return local1;
    }

    private function getLastShopCategory() : IGameObject {
      var local2:IGameObject = null;
      var local3:IGameObject = null;
      var local4:ShopCategory = null;
      var local1:int = int.MIN_VALUE;
      for each(local3 in this.params.shopCategories) {
        local4 = ShopCategory(local3.adapt(ShopCategory));
        if(local1 < local4.getOrderIndex()) {
          local1 = int(local4.getOrderIndex());
          local2 = local3;
        }
      }
      return local2;
    }

    private function addFeaturedItemsToView(param1:Vector.<IGameObject>, param2:GoodsChooseView) : void {
      var shopItemInFeaturing:IGameObject = null;
      var featuringShopItems:Vector.<IGameObject> = param1;
      var view:GoodsChooseView = param2;
      featuringShopItems.sort(function(param1:IGameObject, param2:IGameObject):Number {
        return getItemPosition(param1) - getItemPosition(param2);
      });
      for each(shopItemInFeaturing in featuringShopItems) {
        view.addItem(ShopItemView(shopItemInFeaturing.adapt(ShopItemView)).getButtonView(),FEATURING_FAKE_CATEGORY_ID);
      }
    }

    private function getItemPosition(param1:IGameObject) : int {
      return ShopItemFeaturing(param1.adapt(ShopItemFeaturing)).getPosition();
    }

    private function hasFeaturedShopItems() : Boolean {
      var local1:IGameObject = null;
      for each(local1 in this.params.shopItems) {
        if(ShopItemFeaturing(local1.adapt(ShopItemFeaturing)).isLocatedInFeaturingCategory()) {
          return true;
        }
      }
      return false;
    }

    private function createPaymentChooseView() : PaymentView {
      var local2:IGameObject = null;
      if(this.chosenItem.hasModel(ShopPromoCode)) {
        return ShopPromoCode(this.chosenItem.adapt(ShopPromoCode)).getForm();
      }
      var local1:PayModeChooseView = new PayModeChooseView(this.chosenItem);
      if(partnerService.isRunningInside(SocialNetworkEnum.ODNOKLASSNIKI_INTERNAL.name)) {
        local1.addPaymentCategoriesViewForOdnoklassniki(this.hasPayModeWithDiscountsCategory());
      } else {
        if(this.hasPayModeWithDiscountsCategory()) {
          local1.addPaymentCategoriesWithDiscountView();
        }
        if(this.hasPayModeWithoutDiscountsCategory()) {
          local1.addPaymentCategoriesView();
        }
      }
      for each(local2 in this.params.paymentModes) {
        if(this.payModeCanBeAdded(this.chosenItem,local2)) {
          local1.addPayMode(local2);
        }
      }
      return local1;
    }

    private function hasPayModeWithDiscountsCategory() : Boolean {
      return this.existsPayModeWithTrueFor(function(param1:IGameObject, param2:IGameObject):Boolean {
        return payModeHasDiscount(param2) && payModeCanBeAdded(param1,param2);
      });
    }

    private function hasPayModeWithoutDiscountsCategory() : Boolean {
      return this.existsPayModeWithTrueFor(function(param1:IGameObject, param2:IGameObject):Boolean {
        return !payModeHasDiscount(param2) && payModeCanBeAdded(param1,param2);
      });
    }

    private function existsPayModeWithTrueFor(param1:Function) : Boolean {
      var local2:IGameObject = null;
      for each(local2 in this.params.paymentModes) {
        if(param1(this.chosenItem,local2)) {
          return true;
        }
      }
      return false;
    }

    private function payModeHasDiscount(param1:IGameObject) : Boolean {
      var local2:Boolean = Boolean(this.chosenItem.hasModel(SpecialKitPackage));
      return !local2 && Boolean(ShopDiscount(param1.adapt(ShopDiscount)).isEnabled());
    }

    private function payModeCanBeAdded(param1:IGameObject, param2:IGameObject) : Boolean {
      var local3:PayGardenProductType = null;
      var local4:Number = NaN;
      var local5:Number = NaN;
      if(partnerService.isRunningInside(SocialNetworkEnum.ODNOKLASSNIKI_INTERNAL.name)) {
        return true;
      }
      if(param1.hasModel(PayPalKitView)) {
        return this.isPayPalPayMode(param2);
      }
      if(param1.hasModel(SinglePayMode)) {
        return SinglePayMode(param1.adapt(SinglePayMode)).getPayMode() == param2;
      }
      if(param2.hasModel(PayGardenPayment)) {
        local3 = PayGardenPayment(param2.adapt(PayGardenPayment)).getProductType();
        if(local3 == PayGardenProductType.CRYSTALS) {
          return param1.hasModel(CrystalPackage);
        }
        if(local3 == PayGardenProductType.PREMIUM) {
          return param1.hasModel(PremiumPackage);
        }
        if(local3 == PayGardenProductType.ITEM && (Boolean(param1.hasModel(CrystalPackage)) || Boolean(param1.hasModel(PremiumPackage)))) {
          return false;
        }
      }
      if(param2.hasModel(CrystalsOnlyPaymentMode)) {
        return false;
      }
      if(param2.hasModel(PriceRange)) {
        local4 = Number(ShopItem(param1.adapt(ShopItem)).getPriceWithDiscount());
        local5 = Number(ShopDiscount(param2.adapt(ShopDiscount)).applyDiscount(local4));
        return PriceRange(param2.adapt(PriceRange)).priceIsValid(local5);
      }
      return true;
    }

    private function createPayFormView() : PaymentFormView {
      var local3:PaymentFormItemBase = null;
      var local1:PayModeForm = PayModeView(this.chosenPayMode.adapt(PayModeView)).getView();
      var local2:PaymentFormView = new PaymentFormView(this.chosenItem,local1.shouldBeOmitted() ? null : this.chosenPayMode);
      if(!local1.shouldBeOmitted()) {
        local3 = new PaymentFormItemBase(local1);
        local2.addPaymentForm(local3);
      }
      local1.activate();
      return local2;
    }

    private function createPayFormWithoutChosenItem() : PaymentFormWithoutChosenItemView {
      var local1:PaymentFormWithoutChosenItemView = new PaymentFormWithoutChosenItemView(this.chosenPayMode);
      var local2:PayModeForm = PayModeView(this.chosenPayMode.adapt(PayModeView)).getView();
      local2.activate();
      return local1;
    }

    private function createPayFormForOneTimePurchase() : PaymentFormOneTimePurchaseView {
      var local1:PaymentFormOneTimePurchaseView = new PaymentFormOneTimePurchaseView(this.chosenItem,this.chosenPayMode);
      local1.addEventListener(ApproveFormEvent.EVENT_TYPE,this.onApproveConfirmed);
      return local1;
    }

    private function onApproveConfirmed(param1:ApproveFormEvent) : void {
      this.choosePayMode();
    }

    public function getChosenItem() : IGameObject {
      return this.chosenItem;
    }

    private function setupChooseListeners() : void {
      if(Boolean(this.window.currentPaymentView)) {
        this.window.currentPaymentView.addEventListener(PayModeChosen.EVENT_TYPE,this.onPayModeChosen);
        this.window.currentPaymentView.addEventListener(ShopItemChosen.EVENT_TYPE,this.onItemChosen);
      }
    }

    private function removeChooseListeners() : void {
      if(Boolean(this.window.currentPaymentView)) {
        this.window.currentPaymentView.removeEventListener(ShopItemChosen.EVENT_TYPE,this.onItemChosen);
        this.window.currentPaymentView.removeEventListener(PayModeChosen.EVENT_TYPE,this.onPayModeChosen);
      }
    }

    private function onItemChosen(param1:ShopItemChosen) : void {
      var local2:IGameObject = null;
      this.chosenItem = param1.item;
      userPaymentActionsService.chooseItem(this.chosenItem.id);
      if(this.itemIsRequiredEmail() && Boolean(settingsService.isNeedEmailRemind())) {
        emailReminderService.showNeedEmailAlert();
        return;
      }
      if(this.chosenItem.hasModel(CrystalsOnlyPaymentMode)) {
        this.onPayModeChosen(new PayModeChosen(this.chosenItem));
        return;
      }
      if(this.chosenItem.hasModel(PayPalKitView)) {
        for each(local2 in this.params.paymentModes) {
          if(this.isPayPalPayMode(local2)) {
            this.onPayModeChosen(new PayModeChosen(local2));
            return;
          }
        }
      }
      if(this.chosenItem.hasModel(SinglePayMode)) {
        local2 = SinglePayMode(this.chosenItem.adapt(SinglePayMode)).getPayMode();
        this.onPayModeChosen(new PayModeChosen(local2));
        return;
      }
      if(this.chosenItem.hasModel(ShopPromoCode)) {
        this.switchToState(PaymentState.PAYMODE_CHOOSE);
        return;
      }
      this.switchFullScreenIfNeed();
      if(partnerService.isRunningInside(SocialNetworkEnum.ODNOKLASSNIKI_INTERNAL.name)) {
        this.stopOnPaymentForm = false;
        this.switchToState(PaymentState.PAYMODE_CHOOSE);
        return;
      }
      if(this.params.paymentModes.length == 1) {
        this.onPayModeChosen(new PayModeChosen(this.params.paymentModes[0]));
      } else {
        this.switchToState(PaymentState.PAYMODE_CHOOSE);
      }
    }

    private function switchFullScreenIfNeed() : void {
      if(Boolean(partnerService.isRunningInsidePartnerEnvironment()) && Boolean(fullscreenService.isFullScreenNow())) {
        fullscreenService.switchFullscreen();
      }
    }

    private function onPayModeChosen(param1:PayModeChosen) : void {
      this.chosenPayMode = param1.payMode;
      if(this.chosenItem.hasModel(ShopItemOneTimePurchase)) {
        this.choosePayModeForOneTimePurchase();
      } else {
        this.choosePayMode();
      }
    }

    private function choosePayModeForOneTimePurchase() : void {
      var local2:String = null;
      var local1:ShopItemOneTimePurchase = ShopItemOneTimePurchase(this.chosenItem.adapt(ShopItemOneTimePurchase));
      if(local1.isOneTimePurchase()) {
        local2 = this.chosenItem.id.toString();
        if(Boolean(local1.isTriedToBuy()) || Boolean(this.alreadyTriedToBuy.hasOwnProperty(local2))) {
          this.switchToState(PaymentState.PAY_FORM_ONE_TIME_PURCHASE);
          return;
        }
        this.alreadyTriedToBuy[local2] = true;
      }
      this.choosePayMode();
    }

    private function itemIsRequiredEmail() : Boolean {
      return Boolean(this.chosenItem.hasModel(ShopItemEmailRequired)) && Boolean(ShopItemEmailRequired(this.chosenItem.adapt(ShopItemEmailRequired)).isEmailRequired());
    }

    private function choosePayMode() : void {
      var local1:PayModeForm = PayModeView(this.chosenPayMode.adapt(PayModeView)).getView();
      userPaymentActionsService.choosePaymode(this.chosenPayMode.id,this.chosenItem.id);
      var local2:PaymentState = PaymentState.PAY_FORM;
      if(!this.stopOnPaymentForm) {
        if(local1 is GoToUrlForm) {
          local1.activate();
          local2 = PaymentState.ITEM_CHOOSE;
        }
        if(local1.isWithoutChosenItem()) {
          local2 = PaymentState.PAY_FORM_WITHOUT_CHOSEN_ITEM;
        }
      }
      this.switchToState(local2);
    }

    public function getChosenPayMode() : IGameObject {
      return this.chosenPayMode;
    }

    public function render() : void {
      this.window.render();
    }

    public function saveScrollPosition(param1:int) : void {
      this.savedScrollPosition = param1;
    }

    public function getScrollPosition() : int {
      return this.savedScrollPosition;
    }

    public function isStoppedOnPaymentForm() : Boolean {
      return this.stopOnPaymentForm;
    }

    public function isSingleItemPayment() : Boolean {
      return this.singleItemPayment;
    }

    public function hasBonusForItem(param1:IGameObject) : Boolean {
      return this.hasBonusForCategory(ShopItemCategory(param1.adapt(ShopItemCategory)).getCategory());
    }

    public function hasBonusForCategory(param1:IGameObject) : Boolean {
      return this.params.categoriesWithBonus.indexOf(param1) != -1;
    }

    private function isPayPalPayMode(param1:IGameObject) : Boolean {
      var local2:BraintreePayment = null;
      if(param1.hasModel(BraintreePayment)) {
        local2 = BraintreePayment(param1.adapt(BraintreePayment));
        return local2.isPayPal();
      }
      return param1.hasModel(PayPalPayment);
    }
  }
}
