package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.steam {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.GoToUrlForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.partners.impl.steam.ISteamPaymentModelBase;
  import projects.tanks.client.partners.impl.steam.SteamPaymentModelBase;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.services.SteamDataService;

  [ModelInfo]
  public class SteamPaymentModel extends SteamPaymentModelBase implements ISteamPaymentModelBase, PayModeView, AsyncUrlPayMode, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    [Inject]
    public static var steamDataService:SteamDataService;

    private static const TRANSACTION_REQUEST_CODE:int = 28;
    private static const STEAM_RESPONSE:String = "steamResponse";

    public function SteamPaymentModel() {
      super();
    }

    public function requestAsyncUrl() : void {
      server.makePaymentRequest(paymentWindowService.getChosenItem().id);
    }

    private function onResponse(param1:Object) : void {
      if(param1.req_type != TRANSACTION_REQUEST_CODE) {
        return;
      }
      var local2:Object = steamDataService.getSteamWorks().microTxnResult();
      if(local2 == null) {
        return;
      }
      var local3:String = local2.orderID;
      var local4:String = local2.appID.toString();
      if(local4 != steamDataService.getAppId()) {
        return;
      }
      if(Boolean(local2.authorized)) {
        server.finalizePayment(local3);
      }
    }

    public function getView() : PayModeForm {
      return PayModeForm(getData(PayModeForm));
    }

    public function objectLoaded() : void {
      steamDataService.getSteamWorks().addEventListener(STEAM_RESPONSE,getFunctionWrapper(this.onResponse));
      putData(PayModeForm,new GoToUrlForm(object));
    }

    public function objectUnloaded() : void {
      steamDataService.getSteamWorks().removeEventListener(STEAM_RESPONSE,getFunctionWrapper(this.onResponse));
      this.getView().destroy();
      clearData(PayModeForm);
    }
  }
}
