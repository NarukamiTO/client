package platform.clients.fp10.libraries.alternativapartners.type {
  [ModelInterface]
  public interface IPartner {
    function getLoginParameters(param1:IParametersListener) : void;
    function hasPaymentAction() : Boolean;
    function paymentAction() : void;
    function getFailRedirectUrl() : String;
    function isExternalLoginAllowed() : Boolean;
    function hasRatings() : Boolean;
  }
}
