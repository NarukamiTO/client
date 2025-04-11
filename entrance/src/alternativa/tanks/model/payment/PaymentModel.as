package alternativa.tanks.model.payment {
  import alternativa.tanks.gui.shop.windows.ShopWindowParams;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.model.payment.modes.PayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.model.payment.shop.category.ShopCategory;
  import alternativa.tanks.model.payment.shop.item.ShopItem;
  import alternativa.tanks.model.payment.shop.shopabonement.ShopAbonements;
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.service.payment.IPaymentService;
  import alternativa.tanks.tracker.ITrackerService;
  import flash.geom.Point;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.IPaymentModelBase;
  import projects.tanks.client.panel.model.payment.PaymentCC;
  import projects.tanks.client.panel.model.payment.PaymentModelBase;
  import projects.tanks.clients.flash.commons.models.detach.Detach;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentDisplayServiceUnloadEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;

  [ModelInfo]
  public class PaymentModel extends PaymentModelBase implements IPaymentModelBase, IObjectLoadListener {
    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var achievementService:IAchievementService;

    [Inject]
    public static var trackerService:ITrackerService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    [Inject]
    public static var userPaymentActionService:UserPaymentActionsService;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var paymentWindow:PaymentWindowService;

    public function PaymentModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:PaymentCC = getInitParam();
      paymentService.initManualDescription(local1.manualDescription);
      paymentDisplayService.addEventListener(PaymentDisplayServiceUnloadEvent.UNLOAD_PAYMENT,getFunctionWrapper(this.unloadPayment));
    }

    private function unloadPayment(param1:PaymentDisplayServiceUnloadEvent) : void {
      Detach(object.adapt(Detach)).detach();
    }

    public function objectLoadedPost() : void {
      paymentDisplayService.handlePaymentLoadingComplete();
      this.sortPaymentData();
      var local1:ShopWindowParams = this.preparePaymentParams();
      paymentWindow.buildWindow(local1);
      paymentWindow.show();
    }

    private function preparePaymentParams() : ShopWindowParams {
      var local1:PaymentCC = getInitParam();
      var local2:ShopWindowParams = new ShopWindowParams();
      local2.paymentObject = object;
      local2.shopCategories = local1.shopCategories;
      local2.shopItems = local1.shopItems;
      local2.paymentModes = local1.payModes;
      local2.categoriesWithBonus = ShopAbonements(object.adapt(ShopAbonements)).getCategoriesWithBonus();
      local2.currentShopCategoryType = getInitParam().currentCategoryType;
      return local2;
    }

    private function sortPaymentData() : void {
      getInitParam().shopCategories.sort(function(param1:IGameObject, param2:IGameObject):int {
        return ShopCategory(param1.adapt(ShopCategory)).getOrderIndex() - ShopCategory(param2.adapt(ShopCategory)).getOrderIndex();
      });
      getInitParam().shopItems.sort(function(param1:IGameObject, param2:IGameObject):Number {
        return ShopItem(param1.adapt(ShopItem)).getPrice() - ShopItem(param2.adapt(ShopItem)).getPrice();
      });
      getInitParam().payModes.sort(function(param1:IGameObject, param2:IGameObject):int {
        return PayMode(param1.adapt(PayMode)).getOrderIndex() - PayMode(param2.adapt(PayMode)).getOrderIndex();
      });
    }

    public function objectUnloaded() : void {
      paymentWindow.destroy();
      paymentDisplayService.removeEventListener(PaymentDisplayServiceUnloadEvent.UNLOAD_PAYMENT,getFunctionWrapper(this.unloadPayment));
      paymentDisplayService.handlePaymentUnloadingComplete();
    }

    public function objectUnloadedPost() : void {
      achievementService.setPaymentResumeButtonTargetPoint(new Point(-1,-1));
    }
  }
}
