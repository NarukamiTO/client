package alternativa.tanks.model.panel.payment.load {
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.loader.IPaymentLoaderModelBase;
  import projects.tanks.client.panel.model.payment.loader.PaymentLoaderModelBase;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentLoadWithCategoryEvent;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentLoadWithGarageItemEvent;
  import projects.tanks.clients.flash.commons.services.payment.event.PaymentLoadWithShopItemEvent;

  [ModelInfo]
  public class PaymentLoaderModel extends PaymentLoaderModelBase implements IPaymentLoaderModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    public function PaymentLoaderModel() {
      super();
    }

    public function objectLoadedPost() : void {
      this.subscribe(PaymentLoadWithCategoryEvent.LOAD_PAYMENT,this.loadWithCategoryHandler);
      this.subscribe(PaymentLoadWithGarageItemEvent.LOAD_PAYMENT,this.loadWithGarageItemHandler);
      this.subscribe(PaymentLoadWithShopItemEvent.LOAD_PAYMENT,this.loadWithShopItemHandler);
    }

    public function objectUnloaded() : void {
      this.unsubscribe(PaymentLoadWithCategoryEvent.LOAD_PAYMENT,this.loadWithCategoryHandler);
      this.unsubscribe(PaymentLoadWithGarageItemEvent.LOAD_PAYMENT,this.loadWithGarageItemHandler);
      this.unsubscribe(PaymentLoadWithShopItemEvent.LOAD_PAYMENT,this.loadWithShopItemHandler);
    }

    private function subscribe(param1:String, param2:Function) : void {
      paymentDisplayService.addEventListener(param1,getFunctionWrapper(param2));
    }

    private function unsubscribe(param1:String, param2:Function) : void {
      paymentDisplayService.removeEventListener(param1,getFunctionWrapper(param2));
    }

    private function loadWithCategoryHandler(param1:PaymentLoadWithCategoryEvent) : void {
      server.loadPayment(param1.shopCategoryType);
    }

    private function loadWithGarageItemHandler(param1:PaymentLoadWithGarageItemEvent) : void {
      server.loadPaymentWithGarageItem(param1.garageItem);
    }

    private function loadWithShopItemHandler(param1:PaymentLoadWithShopItemEvent) : void {
      server.loadPaymentWithShopItem(param1.shopItem);
    }
  }
}
