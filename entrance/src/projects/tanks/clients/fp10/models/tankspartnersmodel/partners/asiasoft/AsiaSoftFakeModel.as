package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.asiasoft {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.asiasoft.AsiasoftLoginModelBase;
  import projects.tanks.client.partners.impl.asiasoft.IAsiasoftLoginModelBase;

  [ModelInfo]
  public class AsiaSoftFakeModel extends AsiasoftLoginModelBase implements IAsiasoftLoginModelBase, IPartner {
    public function AsiaSoftFakeModel() {
      super();
    }

    public function gotoInitialUrl() : void {
    }

    public function gotoUrl(param1:String) : void {
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      param1.onSetParameters(new LoginParameters(new Dictionary()));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasRatings() : Boolean {
      return false;
    }
  }
}
