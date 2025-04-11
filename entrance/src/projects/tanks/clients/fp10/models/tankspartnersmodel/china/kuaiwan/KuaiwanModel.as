package projects.tanks.clients.fp10.models.tankspartnersmodel.china.kuaiwan {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.kuaiwan.IKuaiwanModelBase;
  import projects.tanks.client.partners.impl.china.kuaiwan.KuaiwanModelBase;

  [ModelInfo]
  public class KuaiwanModel extends KuaiwanModelBase implements IKuaiwanModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const PAYMENT_URL:String = "http://pay.kuaiwan.com/index/?game_id=8400001";

    public function KuaiwanModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["login_name"] = addressService.getQueryParameter("login_name");
      local2["time"] = addressService.getQueryParameter("time");
      local2["server_id"] = addressService.getQueryParameter("server_id");
      local2["isAdult"] = addressService.getQueryParameter("isAdult");
      local2["token"] = addressService.getQueryParameter("token");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://www.kuaiwan.com/game/1/8400001.html";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasPaymentAction() : Boolean {
      return true;
    }

    public function paymentAction() : void {
      navigateToURL(new URLRequest(PAYMENT_URL),"_blank");
    }

    public function hasRatings() : Boolean {
      return false;
    }
  }
}
