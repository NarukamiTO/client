package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.vkontakte {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.vkontakte.IVkontakteInternalLoginModelBase;
  import projects.tanks.client.partners.impl.vkontakte.VkontakteInternalLoginModelBase;

  [ModelInfo]
  public class VkontakteInternalLoginModel extends VkontakteInternalLoginModelBase implements IVkontakteInternalLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    public function VkontakteInternalLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["api_url"] = addressService.getQueryParameter("api_url");
      local2["api_id"] = addressService.getQueryParameter("api_id");
      local2["user_id"] = addressService.getQueryParameter("user_id");
      local2["sid"] = addressService.getQueryParameter("sid");
      local2["secret"] = addressService.getQueryParameter("secret");
      local2["group_id"] = addressService.getQueryParameter("group_id");
      local2["viewer_id"] = addressService.getQueryParameter("viewer_id");
      local2["is_app_user"] = addressService.getQueryParameter("is_app_user");
      local2["is_secure"] = addressService.getQueryParameter("is_secure");
      local2["viewer_type"] = addressService.getQueryParameter("viewer_type");
      local2["auth_key"] = addressService.getQueryParameter("auth_key");
      local2["language"] = addressService.getQueryParameter("language");
      local2["api_result"] = addressService.getQueryParameter("api_result");
      local2["api_settings"] = addressService.getQueryParameter("api_settings");
      local2["referrer"] = addressService.getQueryParameter("referrer");
      local2["access_token"] = addressService.getQueryParameter("access_token");
      local2["hash"] = addressService.getQueryParameter("hash");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "http://tankionline.com";
    }

    public function isExternalLoginAllowed() : Boolean {
      return true;
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
