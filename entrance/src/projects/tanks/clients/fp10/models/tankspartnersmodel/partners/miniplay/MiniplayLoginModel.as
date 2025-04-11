package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.miniplay {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.miniplay.IMiniplayLoginModelBase;
  import projects.tanks.client.partners.impl.miniplay.MiniplayLoginModelBase;

  [ModelInfo]
  public class MiniplayLoginModel extends MiniplayLoginModelBase implements IMiniplayLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    [Inject]
    public static var paramsService:ILauncherParams;

    private static const USER_TOKEN_PARAM:String = "mp_api_user_token";
    private static const USER_ID_PARAM:String = "mp_api_user_id";

    public function MiniplayLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2[USER_TOKEN_PARAM] = paramsService.getParameter(USER_TOKEN_PARAM);
      local2[USER_ID_PARAM] = paramsService.getParameter(USER_ID_PARAM);
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "http://tankionline.com/pt_BR";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
