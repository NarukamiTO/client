package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.fakepartner {
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.fakepartner.FakePartnerLoginModelBase;
  import projects.tanks.client.partners.impl.fakepartner.IFakePartnerLoginModelBase;

  [ModelInfo]
  public class FakePartnerLoginModel extends FakePartnerLoginModelBase implements IFakePartnerLoginModelBase, IPartner {
    public function FakePartnerLoginModel() {
      super();
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
