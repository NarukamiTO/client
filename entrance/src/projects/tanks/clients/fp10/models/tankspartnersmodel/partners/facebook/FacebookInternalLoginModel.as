package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.facebook {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.facebook.login.FacebookInternalLoginModelBase;
  import projects.tanks.client.partners.impl.facebook.login.IFacebookInternalLoginModelBase;

  [ModelInfo]
  public class FacebookInternalLoginModel extends FacebookInternalLoginModelBase implements IFacebookInternalLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    public function FacebookInternalLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["access_token"] = addressService.getQueryParameter("access_token");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "https://apps.facebook.com/tankionline/";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasRatings() : Boolean {
      return false;
    }
  }
}
