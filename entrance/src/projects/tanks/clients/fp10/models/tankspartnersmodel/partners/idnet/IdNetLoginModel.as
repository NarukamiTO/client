package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.idnet {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.idnet.IIdNetLoginModelBase;
  import projects.tanks.client.partners.impl.idnet.IdNetLoginModelBase;

  [ModelInfo]
  public class IdNetLoginModel extends IdNetLoginModelBase implements IIdNetLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const ACCESS_TOKEN_PARAM:String = "access_token";

    public function IdNetLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2[ACCESS_TOKEN_PARAM] = addressService.getQueryParameter(ACCESS_TOKEN_PARAM);
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "http://apps.id.net/tankionline";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
