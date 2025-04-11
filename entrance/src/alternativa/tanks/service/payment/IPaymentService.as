package alternativa.tanks.service.payment {
  import projects.tanks.client.panel.model.payment.CrystalsPaymentCC;
  import projects.tanks.client.panel.model.payment.panel.PaymentButtonCC;
  import projects.tanks.client.panel.model.payment.types.PaymentRequestUrl;

  public interface IPaymentService {
    function getAccountId() : String;
    function getManualDescription() : String;
    function getCrystalCost() : Number;
    function getLessMinimumCrystalsMessage() : String;
    function getLessMinimumMoneyMessage() : String;
    function getGreaterMaximumCrystalsMessage() : String;
    function getGreaterMaximumMoneyMessage() : String;
    function getCrystals() : int;
    function setCrystals(param1:int) : void;
    function initManualDescription(param1:String) : void;
    function init(param1:CrystalsPaymentCC) : void;
    function setShouldChooseLocation(param1:Boolean) : void;
    function isEnabled() : Boolean;
    function initPaymentMode(param1:PaymentButtonCC) : void;
    function isEnabledFullPayment() : Boolean;
    function isPaymentInLinkMode() : Boolean;
    function getPaymentUrl() : PaymentRequestUrl;
    function shouldChooseLocation() : Boolean;
  }
}
