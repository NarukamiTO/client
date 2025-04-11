package alternativa.tanks.model.payment.saveprocessed {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.gui.shop.shopitems.item.utils.FormatUtils;
  import alternativa.tanks.model.payment.modes.PayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import alternativa.tanks.model.payment.shop.discount.ShopDiscount;
  import alternativa.tanks.model.payment.shop.item.ShopItem;
  import flash.globalization.DateTimeFormatter;
  import flash.globalization.DateTimeStyle;
  import projects.tanks.client.tanksservices.model.logging.payment.PaymentAction;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class ProcessedPaymentServiceImp implements ProcessedPaymentService {
    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    private var dateFormatter:DateTimeFormatter;
    private var timeFormatter:DateTimeFormatter;

    public function ProcessedPaymentServiceImp() {
      super();
      this.dateFormatter = new DateTimeFormatter(DateTimeStyle.SHORT);
      this.dateFormatter.setDateTimePattern("dd-MM-yyyy");
      this.timeFormatter = new DateTimeFormatter(DateTimeStyle.SHORT);
      this.timeFormatter.setDateTimePattern("HH:mm");
      var local1:UserPaymentActionsService = UserPaymentActionsService(OSGi.getInstance().getService(UserPaymentActionsService));
      local1.addEventListener(UserPaymentActionEvent.TYPE,this.onPaymentProcessed);
    }

    public function getLastProcessedPaymentInfo() : ProcessedPaymentInfo {
      var local1:Object = storageService.getStorage().data.processedPayment;
      return Boolean(local1) ? this.restoreProcessedPaymentInfo(local1) : null;
    }

    private function restoreProcessedPaymentInfo(param1:Object) : ProcessedPaymentInfo {
      var local2:ProcessedPaymentInfo = new ProcessedPaymentInfo();
      local2.currencyName = param1.currencyName;
      local2.itemFinalPrice = param1.itemFinalPrice;
      local2.itemId = param1.itemId;
      local2.payModeId = param1.payModeId;
      local2.payModeName = param1.payModeName;
      local2.date = param1.date;
      local2.time = param1.time;
      return local2;
    }

    private function onPaymentProcessed(param1:UserPaymentActionEvent) : void {
      if(param1.getPaymentAction() == PaymentAction.PROCEED) {
        this.writeProcessedPayment();
      }
    }

    private function writeProcessedPayment() : void {
      var local1:ProcessedPaymentInfo = new ProcessedPaymentInfo();
      var local2:ShopItem = ShopItem(paymentWindowService.getChosenItem().adapt(ShopItem));
      var local3:PayMode = PayMode(paymentWindowService.getChosenPayMode().adapt(PayMode));
      if(!local2 || !local3) {
        return;
      }
      local1.currencyName = local2.getCurrencyName();
      local1.itemFinalPrice = this.getFinalItemPrice(local3,local2);
      local1.itemId = paymentWindowService.getChosenItem().id.toString();
      local1.payModeId = paymentWindowService.getChosenPayMode().id.toString();
      local1.payModeName = local3.getName();
      var local4:Date = new Date();
      local1.date = this.dateFormatter.format(local4);
      local1.time = this.timeFormatter.format(local4);
      storageService.getStorage().data.processedPayment = local1;
    }

    private function getFinalItemPrice(param1:PayMode, param2:ShopItem) : String {
      var local3:Number = Number(param2.getPrice());
      if(ShopDiscount(paymentWindowService.getChosenItem().adapt(ShopDiscount)).isEnabled()) {
        local3 = Number(param2.getPriceWithDiscount());
      }
      if(param1.isDiscount()) {
        local3 = Number(ShopDiscount(paymentWindowService.getChosenPayMode().adapt(ShopDiscount)).applyDiscount(local3));
      }
      return FormatUtils.valueToString(local3,param2.getCurrencyRoundingPrecision(),false);
    }
  }
}
