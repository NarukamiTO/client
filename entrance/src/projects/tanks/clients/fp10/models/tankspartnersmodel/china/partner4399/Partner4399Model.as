package projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner4399 {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.partner4399.IPartner4399ModelBase;
  import projects.tanks.client.partners.impl.china.partner4399.Partner4399ModelBase;

  [ModelInfo]
  public class Partner4399Model extends Partner4399ModelBase implements IPartner4399ModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const PAYMENT_URL:String = "http://cz.4399.com/3dtk/?je=50";

    public function Partner4399Model() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["username"] = addressService.getQueryParameter("username");
      local2["serverid"] = addressService.getQueryParameter("serverid");
      local2["time"] = addressService.getQueryParameter("time");
      local2["site"] = addressService.getQueryParameter("site");
      local2["flag"] = addressService.getQueryParameter("flag");
      local2["cm"] = addressService.getQueryParameter("cm");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://my.4399.com/yxtk/";
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
