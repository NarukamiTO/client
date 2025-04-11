package alternativa.tanks.service.payment {
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.panel.model.payment.CrystalsPaymentCC;
  import projects.tanks.client.panel.model.payment.panel.PaymentButtonCC;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public class PaymentService implements IPaymentService {
    [Inject]
    public static var partnerService:IPartnerService;

    private var crystals:int;
    private var locationChooseEnabled:Boolean;
    private var crystalsConfig:CrystalsPaymentCC;
    private var paymentButtonConfig:PaymentButtonCC;
    private var _manualDescription:String;

    public function PaymentService() {
      super();
    }

    public function getAccountId() : String {
      return this.crystalsConfig.accountId;
    }

    public function getManualDescription() : String {
      return this._manualDescription;
    }

    public function getCrystalCost() : Number {
      return this.crystalsConfig.crystalCost;
    }

    public function getLessMinimumCrystalsMessage() : String {
      return this.crystalsConfig.lessMinimumCrystalsMessage;
    }

    public function getLessMinimumMoneyMessage() : String {
      return this.crystalsConfig.lessMinimumMoneyMessage;
    }

    public function getGreaterMaximumCrystalsMessage() : String {
      return this.crystalsConfig.greaterMaximumCrystalsMessage;
    }

    public function getGreaterMaximumMoneyMessage() : String {
      return this.crystalsConfig.greaterMaximumMoneyMessage;
    }

    public function getCrystals() : int {
      return this.crystals;
    }

    public function shouldChooseLocation() : Boolean {
      return this.locationChooseEnabled && !partnerService.hasOwnPaymentSystem();
    }

    public function setCrystals(param1:int) : void {
      this.crystals = param1;
    }

    public function isEnabled() : Boolean {
      return this.isEnabledFullPayment() || partnerService.hasPaymentAction() || partnerService.hasOwnPaymentSystem() || this.isPaymentInLinkMode();
    }

    public function initManualDescription(param1:String) : void {
      this._manualDescription = param1;
    }

    public function setShouldChooseLocation(param1:Boolean) : void {
      this.locationChooseEnabled = param1;
    }

    public function init(param1:CrystalsPaymentCC) : void {
      this.crystalsConfig = param1;
      this.crystals = param1.defaultAmountOfCrystals;
    }

    public function initPaymentMode(param1:PaymentButtonCC) : void {
      this.paymentButtonConfig = param1;
    }

    public function isEnabledFullPayment() : Boolean {
      if(Boolean(this.paymentButtonConfig)) {
        return this.paymentButtonConfig.enabledFullPayment && !partnerService.hasPaymentAction();
      }
      return false;
    }

    public function isPaymentInLinkMode() : Boolean {
      if(Boolean(this.paymentButtonConfig)) {
        return !this.paymentButtonConfig.enabledFullPayment && this.paymentButtonConfig.paymentUrl != null;
      }
      return false;
    }

    public function getPaymentUrl() : PaymentRequestUrl {
      return this.paymentButtonConfig.paymentUrl;
    }
  }
}
