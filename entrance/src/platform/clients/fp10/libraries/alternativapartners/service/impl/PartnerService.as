package platform.clients.fp10.libraries.alternativapartners.service.impl {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.logging.LogService;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.client.fp10.core.type.IGameObject;
  import platform.clients.fp10.libraries.alternativapartners.models.socialnetworkparameters.SocialNetworkParameters;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;

  public class PartnerService implements IPartnerService {
    [Inject]
    public static var addressService:AddressService;

    [Inject]
    public static var log:LogService;

    [Inject]
    public static var paramsService:ILauncherParams;

    private var _partner:IPartner;
    private var _hasOwnPaymentSystem:Boolean = false;
    private var _hasSocialFunction:Boolean = false;

    public function PartnerService() {
      super();
    }

    public function isRunningInsidePartnerEnvironment() : Boolean {
      var local1:String = this.getEnvironmentPartnerId();
      return Boolean(local1);
    }

    public function getEnvironmentPartnerId() : String {
      var local1:String = addressService.getQueryParameter("partnerId");
      if(!local1) {
        local1 = paramsService.getParameter("partnerId");
        if(!local1) {
          local1 = "";
        }
      }
      return local1.toLowerCase();
    }

    public function hasPaymentAction() : Boolean {
      return Boolean(this._partner) ? Boolean(this._partner.hasPaymentAction()) : false;
    }

    public function makePaymentAction() : void {
      if(Boolean(this._partner)) {
        this._partner.paymentAction();
      }
    }

    public function hasOwnPaymentSystem() : Boolean {
      return this._hasOwnPaymentSystem;
    }

    public function hasSocialFunction() : Boolean {
      return this._hasSocialFunction;
    }

    public function getFailRedirectUrl() : String {
      return Boolean(this._partner) ? this._partner.getFailRedirectUrl() : "";
    }

    public function isExternalLoginAllowed() : Boolean {
      return Boolean(this._partner) ? Boolean(this._partner.isExternalLoginAllowed()) : true;
    }

    public function setPartner(param1:IGameObject) : void {
      this._partner = IPartner(param1.adapt(IPartner));
      this._hasOwnPaymentSystem = SocialNetworkParameters(param1.adapt(SocialNetworkParameters)).hasOwnPaymentSystem();
      this._hasSocialFunction = SocialNetworkParameters(param1.adapt(SocialNetworkParameters)).hasSocialFunction();
    }

    public function hasRatings() : Boolean {
      return Boolean(this._partner) ? Boolean(this._partner.hasRatings()) : false;
    }

    public function isRunningInside(param1:String) : Boolean {
      var local2:String = this.getEnvironmentPartnerId();
      if(local2 == null) {
        return null;
      }
      return local2.toLocaleLowerCase() == param1.toLocaleLowerCase();
    }
  }
}
