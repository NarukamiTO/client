package projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner7k7k {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.partner7k7k.IPartner7k7kModelBase;
  import projects.tanks.client.partners.impl.china.partner7k7k.Partner7k7kModelBase;

  [ModelInfo]
  public class Partner7k7kModel extends Partner7k7kModelBase implements IPartner7k7kModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const PAYMENT_URL:String = "http://pay.web.7k7k.com/?g=293&s=";

    private var server_id:String;
    private var userid:String;

    public function Partner7k7kModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      this.userid = addressService.getQueryParameter("userid");
      local2["userid"] = this.userid;
      local2["username"] = addressService.getQueryParameter("username");
      local2["time"] = addressService.getQueryParameter("time");
      this.server_id = addressService.getQueryParameter("server_id");
      local2["server_id"] = this.server_id;
      local2["isAdult"] = addressService.getQueryParameter("isAdult");
      local2["flag"] = addressService.getQueryParameter("flag");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://web.7k7k.com/games/3dtk";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasPaymentAction() : Boolean {
      return true;
    }

    public function paymentAction() : void {
      navigateToURL(new URLRequest(PAYMENT_URL + this.server_id + "&uid=" + this.userid),"_blank");
    }

    public function hasRatings() : Boolean {
      return false;
    }
  }
}
