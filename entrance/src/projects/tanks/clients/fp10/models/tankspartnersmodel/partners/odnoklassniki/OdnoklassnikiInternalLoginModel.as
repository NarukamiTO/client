package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.odnoklassniki {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.odnoklassniki.IOdnoklassnikiInternalLoginModelBase;
  import projects.tanks.client.partners.impl.odnoklassniki.OdnoklassnikiInternalLoginModelBase;
  import projects.tanks.client.partners.impl.odnoklassniki.OdnoklassnikiUrlParams;

  [ModelInfo]
  public class OdnoklassnikiInternalLoginModel extends OdnoklassnikiInternalLoginModelBase implements IOdnoklassnikiInternalLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    public function OdnoklassnikiInternalLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local3:OdnoklassnikiUrlParams = null;
      var local4:String = null;
      var local2:Dictionary = new Dictionary();
      for each(local3 in OdnoklassnikiUrlParams.values) {
        local2[ParamHelper.name(local3)] = addressService.getQueryParameter(ParamHelper.name(local3));
      }
      local4 = addressService.getQueryParameter(OdnoklassnikiUrlParams.API_SERVER.name.toLocaleLowerCase());
      local2[ParamHelper.name(OdnoklassnikiUrlParams.API_SERVER)] = Boolean(local4) ? unescape(local4) : "https://api.ok.com/";
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
