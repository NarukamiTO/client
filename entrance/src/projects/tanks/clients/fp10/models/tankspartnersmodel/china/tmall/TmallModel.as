package projects.tanks.clients.fp10.models.tankspartnersmodel.china.tmall {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.tmall.ITmallModelBase;
  import projects.tanks.client.partners.impl.china.tmall.TmallModelBase;

  [ModelInfo]
  public class TmallModel extends TmallModelBase implements ITmallModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private static const PAYMENT_URL:String = "http://game.taobao.com/webgame/pay.htm?game_id=45069435178&service_area_id=";

    private var gatewayId:String;

    public function TmallModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["tbCoopId"] = addressService.getQueryParameter("tbCoopId");
      local2["gameId"] = addressService.getQueryParameter("gameId");
      local2["gatewayId"] = addressService.getQueryParameter("gatewayId");
      this.gatewayId = local2["gatewayId"];
      local2["tbUid"] = unescape(addressService.getQueryParameter("tbUid"));
      local2["isAdult"] = addressService.getQueryParameter("isAdult");
      local2["loginTime"] = addressService.getQueryParameter("loginTime");
      local2["sign"] = addressService.getQueryParameter("sign");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function getFailRedirectUrl() : String {
      return "http://game.taobao.com/webgame/detail.htm?id=45069435178";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasPaymentAction() : Boolean {
      return true;
    }

    public function paymentAction() : void {
      navigateToURL(new URLRequest(PAYMENT_URL + this.gatewayId),"_blank");
    }

    public function hasRatings() : Boolean {
      return false;
    }
  }
}
