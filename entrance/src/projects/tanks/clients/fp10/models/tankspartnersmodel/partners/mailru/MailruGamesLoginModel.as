package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.mailru {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.mailru.login.IMailruGamesLoginModelBase;
  import projects.tanks.client.partners.impl.mailru.login.MailruGamesLoginModelBase;

  [ModelInfo]
  public class MailruGamesLoginModel extends MailruGamesLoginModelBase implements IMailruGamesLoginModelBase, IPartner {
    [Inject]
    public static var paramsService:ILauncherParams;

    public function MailruGamesLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      var local2:Dictionary = new Dictionary();
      local2["tokenUrl"] = paramsService.getParameter("tokenUrl").replace(/\|/g,"&");
      param1.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "https://games.mail.ru/app/3436";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasRatings() : Boolean {
      return false;
    }
  }
}
