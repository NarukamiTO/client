package projects.tanks.clients.fp10.models.tankspartnersmodel.china.ifeng {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.ifeng.IIfengModelBase;
  import projects.tanks.client.partners.impl.china.ifeng.IfengModelBase;

  [ModelInfo]
  public class IfengModel extends IfengModelBase implements IIfengModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const PAYMENT_URL:String = "http://play.ifeng.com/ipay/?turl=yxn&game=sdtk&area=1";

    public function IfengModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["username"] = unescape(addressService.getQueryParameter("username"));
      local2["server"] = addressService.getQueryParameter("server");
      local2["time"] = addressService.getQueryParameter("time");
      local2["cm"] = addressService.getQueryParameter("cm");
      local2["flag"] = addressService.getQueryParameter("flag");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://games.ifeng.com/webgame/sdtk/";
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
