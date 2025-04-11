package projects.tanks.clients.fp10.models.tankspartnersmodel.china.china3rdplatform {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.client.fp10.core.service.address.AddressService;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.china.china3rdplatform.auth.China3rdPlatformLoginModelBase;
  import projects.tanks.client.partners.impl.china.china3rdplatform.auth.IChina3rdPlatformLoginModelBase;

  [ModelInfo]
  public class China3rdPlatformLoginModel extends China3rdPlatformLoginModelBase implements IChina3rdPlatformLoginModelBase, IPartner {
    [Inject]
    public static var addressService:AddressService;

    private var hasRating:Boolean;

    public function China3rdPlatformLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = this.getParams("timestamp","server","sub_partner_id","user_id","cm","sign");
      var local3:String = local2["server"];
      this.hasRating = local3 == null || local3 == "" || local3.charAt(0) == "c";
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "http://3dtank.com";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasRatings() : Boolean {
      return this.hasRating;
    }

    private function getParams(... rest) : Dictionary {
      var local3:String = null;
      var local2:Dictionary = new Dictionary();
      for each(local3 in rest) {
        local2[local3] = addressService.getQueryParameter(local3);
      }
      return local2;
    }
  }
}
