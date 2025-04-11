package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.armorgames {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.armorgames.ArmorGamesLoginModelBase;
  import projects.tanks.client.partners.impl.armorgames.IArmorGamesLoginModelBase;

  [ModelInfo]
  public class ArmorGamesLoginModel extends ArmorGamesLoginModelBase implements IArmorGamesLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    public function ArmorGamesLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["user_id"] = addressService.getQueryParameter("user_id");
      local2["auth_token"] = addressService.getQueryParameter("auth_token");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "http://armorgames.com/tanki-online-game/17724";
    }

    public function isExternalLoginAllowed() : Boolean {
      return true;
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
