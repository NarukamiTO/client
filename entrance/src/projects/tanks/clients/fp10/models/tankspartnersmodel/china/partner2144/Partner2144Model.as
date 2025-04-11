package projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner2144 {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.partner2144.IPartner2144ModelBase;
  import projects.tanks.client.partners.impl.china.partner2144.Partner2144ModelBase;

  [ModelInfo]
  public class Partner2144Model extends Partner2144ModelBase implements IPartner2144ModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const PAYMENT_URL:String = "http://web.2144.cn/orders/index/gid/60";

    private var server_id:String;

    public function Partner2144Model() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["userid"] = addressService.getQueryParameter("userid");
      local2["username"] = addressService.getQueryParameter("username");
      local2["time"] = addressService.getQueryParameter("time");
      local2["server_id"] = addressService.getQueryParameter("server_id");
      local2["isAdult"] = addressService.getQueryParameter("isAdult");
      local2["flag"] = addressService.getQueryParameter("flag");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://web.2144.cn/3Dtk";
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
