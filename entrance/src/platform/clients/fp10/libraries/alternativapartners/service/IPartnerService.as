package platform.clients.fp10.libraries.alternativapartners.service {
  import platform.client.fp10.core.type.IGameObject;

  public interface IPartnerService {
    function isRunningInsidePartnerEnvironment() : Boolean;
    function getEnvironmentPartnerId() : String;
    function setPartner(param1:IGameObject) : void;
    function hasPaymentAction() : Boolean;
    function makePaymentAction() : void;
    function getFailRedirectUrl() : String;
    function isExternalLoginAllowed() : Boolean;
    function hasRatings() : Boolean;
    function hasOwnPaymentSystem() : Boolean;
    function hasSocialFunction() : Boolean;
    function isRunningInside(param1:String) : Boolean;
  }
}
