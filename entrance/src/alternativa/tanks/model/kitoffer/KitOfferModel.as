package alternativa.tanks.model.kitoffer {
  import projects.tanks.client.panel.model.kitoffer.IKitOfferModelBase;
  import projects.tanks.client.panel.model.kitoffer.KitOfferInfo;
  import projects.tanks.client.panel.model.kitoffer.KitOfferModelBase;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;

  [ModelInfo]
  public class KitOfferModel extends KitOfferModelBase implements IKitOfferModelBase {
    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    public function KitOfferModel() {
      super();
    }

    public function showOffer(param1:KitOfferInfo) : void {
      this.showDialog(param1);
    }

    private function showDialog(param1:KitOfferInfo) : void {
      var local2:KitOfferDialog = new KitOfferDialog(param1);
      local2.addEventListener(KitOfferResultEvent.CLOSE,getFunctionWrapper(this.closeHandler));
      putData(KitOfferInfo,param1);
      putData(KitOfferDialog,local2);
    }

    private function closeHandler(param1:KitOfferResultEvent) : void {
      var local2:KitOfferInfo = getData(KitOfferInfo) as KitOfferInfo;
      server.logAction(local2.shopItem,param1.action);
      var local3:KitOfferDialog = getData(KitOfferDialog) as KitOfferDialog;
      local3.removeEventListener(KitOfferResultEvent.CLOSE,getFunctionWrapper(this.closeHandler));
      clearData(KitOfferInfo);
      clearData(KitOfferDialog);
    }
  }
}
