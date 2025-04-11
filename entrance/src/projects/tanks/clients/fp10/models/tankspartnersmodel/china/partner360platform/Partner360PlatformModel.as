package projects.tanks.clients.fp10.models.tankspartnersmodel.china.partner360platform {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.partner360platform.IPartner360PlatformModelBase;
  import projects.tanks.client.partners.impl.china.partner360platform.Partner360PlatformModelBase;

  [ModelInfo]
  public class Partner360PlatformModel extends Partner360PlatformModelBase implements IPartner360PlatformModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private var qid:String;
    private var server_id:String;

    public function Partner360PlatformModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["qid"] = addressService.getQueryParameter("qid");
      this.qid = local2["qid"];
      local2["server_id"] = addressService.getQueryParameter("server_id");
      this.server_id = local2["server_id"];
      local2["time"] = addressService.getQueryParameter("time");
      local2["sign"] = addressService.getQueryParameter("sign");
      local2["isAdult"] = addressService.getQueryParameter("isAdult");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://game.1360.com/game/tk3d";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasPaymentAction() : Boolean {
      return true;
    }

    public function paymentAction() : void {
      navigateToURL(new URLRequest("http://pay.game.1360.com/order.html?gkey=tk3d&skey=" + this.server_id + "&sqid=" + this.qid + "&dqid=" + this.qid + "&plat=17419372" + this.server_id),"_blank");
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
