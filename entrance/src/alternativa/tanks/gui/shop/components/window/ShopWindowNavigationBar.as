package alternativa.tanks.gui.shop.components.window {
  import alternativa.model.description.IDescription;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.events.ShopWindowBackButtonEvent;
  import alternativa.tanks.gui.shop.events.ShopWindowJumpButtonEvent;
  import alternativa.tanks.model.payment.paymentstate.PaymentState;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.model.payment.shop.category.ShopCategory;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscount;
  import alternativa.tanks.model.payment.shop.featuring.ShopItemFeaturing;
  import alternativa.tanks.model.payment.shop.itemcategory.ShopItemCategory;
  import alternativa.tanks.service.payment.IPaymentService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.base.DefaultButtonBase;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ShopWindowNavigationBar extends DiscreteSprite {
    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    private static const HEIGHT:int = 37;
    private static const PADDING_VERTICAL:int = 4;
    private static const BUTTON_WIDTH:int = 120;
    private static const BUTTON_SPACING:int = 8;
    private static const BUTTONS_LEFT_PADDING:int = 11;

    private var jumpButtons:Vector.<ShopWindowJumpButton>;
    private var backButton:DefaultButtonBase;
    private var shopCategoryNameToId:Dictionary;
    private var categoriesWithDiscount:Dictionary;

    public function ShopWindowNavigationBar(param1:Vector.<IGameObject>, param2:Vector.<IGameObject>) {
      super();
      this.initCategoryDiscounts(param2);
      this.initNavigation(param1);
      this.initBackButton();
    }

    private function initCategoryDiscounts(param1:Vector.<IGameObject>) : void {
      var local2:IGameObject = null;
      var local3:IGameObject = null;
      this.categoriesWithDiscount = new Dictionary();
      for each(local2 in param1) {
        local3 = ShopItemCategory(local2.adapt(ShopItemCategory)).getCategory();
        if(this.needMarkCategory(local3,local2)) {
          this.categoriesWithDiscount[local3.id.toString()] = true;
        }
      }
    }

    private function needMarkCategory(param1:IGameObject, param2:IGameObject) : Boolean {
      if(paymentWindowService.hasBonusForCategory(param1)) {
        return true;
      }
      return Boolean(ShopDiscount(param2.adapt(ShopDiscount)).isEnabled()) && !ShopItemFeaturing(param2.adapt(ShopItemFeaturing)).isHiddenInOriginalCategory();
    }

    private function initNavigation(param1:Vector.<IGameObject>) : void {
      var local2:IGameObject = null;
      var local3:ShopCategory = null;
      var local4:IDescription = null;
      var local5:ShopWindowJumpButton = null;
      this.jumpButtons = new Vector.<ShopWindowJumpButton>();
      this.shopCategoryNameToId = new Dictionary();
      for each(local2 in param1) {
        local3 = ShopCategory(local2.adapt(ShopCategory));
        if(local3.isWithJumpButton()) {
          local4 = IDescription(local2.adapt(IDescription));
          local5 = this.addCategoryJumpButton(local2.id,local4.getName());
          if(this.hasDiscount(local2.id)) {
            local5.activateDiscountsIcon();
          }
        }
        this.shopCategoryNameToId[local3.getType()] = local2.id;
      }
    }

    private function addCategoryJumpButton(param1:Long, param2:String) : ShopWindowJumpButton {
      var local3:ShopWindowJumpButton = new ShopWindowJumpButton(param1,param2);
      local3.addEventListener(MouseEvent.CLICK,this.onJumpButtonPressed,false,0,true);
      local3.width = BUTTON_WIDTH;
      addChild(local3);
      this.jumpButtons.push(local3);
      return local3;
    }

    private function hasDiscount(param1:Long) : Boolean {
      return this.categoriesWithDiscount[param1.toString()];
    }

    private function onJumpButtonPressed(param1:MouseEvent) : void {
      this.navigateToCategoryById((param1.currentTarget as ShopWindowJumpButton).categoryId);
    }

    public function navigateToCategoryByType(param1:ShopCategoryEnum) : void {
      var local2:Long = this.shopCategoryNameToId[param1];
      if(Boolean(local2)) {
        this.navigateToCategoryById(local2);
      }
    }

    public function navigateToCategoryById(param1:Long) : void {
      dispatchEvent(new ShopWindowJumpButtonEvent(ShopWindowJumpButtonEvent.CLICK,param1));
    }

    private function initBackButton() : void {
      this.backButton = new DefaultButtonBase();
      this.backButton.tabEnabled = false;
      this.backButton.label = localeService.getText(TanksLocale.TEXT_BACK_BUTTON);
      this.backButton.visible = false;
      this.backButton.addEventListener(MouseEvent.CLICK,this.onBackButtonPressed);
      addChild(this.backButton);
    }

    private function onBackButtonPressed(param1:MouseEvent) : void {
      dispatchEvent(new ShopWindowBackButtonEvent(ShopWindowBackButtonEvent.CLICK));
    }

    public function resize(param1:int) : void {
      var local2:int = 0;
      var local3:ShopWindowJumpButton = null;
      local2 = BUTTONS_LEFT_PADDING;
      for each(local3 in this.jumpButtons) {
        local3.y = PADDING_VERTICAL;
        local3.x = local2;
        local2 += local3.width + (local3.activeDiscounts ? 0 : BUTTON_SPACING);
      }
      this.backButton.y = PADDING_VERTICAL;
      this.backButton.x = BUTTONS_LEFT_PADDING;
    }

    public function switchToState(param1:PaymentState) : void {
      this.setJumpButtonsVisible(!paymentWindowService.isStoppedOnPaymentForm() && param1 == PaymentState.ITEM_CHOOSE && !paymentWindowService.isSingleItemPayment());
      this.backButton.visible = !paymentWindowService.isStoppedOnPaymentForm() && param1 != PaymentState.ITEM_CHOOSE && (!paymentWindowService.isSingleItemPayment() || param1 != PaymentState.PAYMODE_CHOOSE);
    }

    private function setJumpButtonsVisible(param1:Boolean) : void {
      var local2:ShopWindowJumpButton = null;
      for each(local2 in this.jumpButtons) {
        local2.visible = param1;
      }
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    public function destroy() : void {
      var local1:ShopWindowJumpButton = null;
      for each(local1 in this.jumpButtons) {
        local1.removeEventListener(MouseEvent.CLICK,this.onJumpButtonPressed);
      }
      this.backButton.removeEventListener(MouseEvent.CLICK,this.onBackButtonPressed);
      this.jumpButtons = null;
    }
  }
}
