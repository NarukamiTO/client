package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.rambler {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.rambler.IRamblerLoginModelBase;
  import projects.tanks.client.partners.impl.rambler.RamblerLoginModelBase;

  [ModelInfo]
  public class RamblerLoginModel extends RamblerLoginModelBase implements IRamblerLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const USER_ID_PARAM:String = "user_id";
    private static const GAME_ID_PARAM:String = "game_id";
    private static const SLUG_PARAM:String = "slug";
    private static const TIMESTAMP_PARAM:String = "timestamp";
    private static const SIG_PARAM:String = "sig";

    public function RamblerLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2[USER_ID_PARAM] = addressService.getQueryParameter(USER_ID_PARAM);
      local2[GAME_ID_PARAM] = addressService.getQueryParameter(GAME_ID_PARAM);
      local2[SLUG_PARAM] = addressService.getQueryParameter(SLUG_PARAM);
      local2[TIMESTAMP_PARAM] = addressService.getQueryParameter(TIMESTAMP_PARAM);
      local2[SIG_PARAM] = addressService.getQueryParameter(SIG_PARAM);
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://www.tankionline.com/";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
