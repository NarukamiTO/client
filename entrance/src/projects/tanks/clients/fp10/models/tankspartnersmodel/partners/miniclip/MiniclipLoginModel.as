package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.miniclip {
  import alternativa.osgi.service.display.IDisplay;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.miniclip.IMiniclipLoginModelBase;
  import projects.tanks.client.partners.impl.miniclip.MiniclipLoginModelBase;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.guestform.GuestForm;

  [ModelInfo]
  public class MiniclipLoginModel extends MiniclipLoginModelBase implements IMiniclipLoginModelBase, IPartner {
    [Inject]
    public static var displayService:IDisplay;

    public var guestWindow:GuestForm;

    private var listener:IParametersListener;

    public function MiniclipLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      this.listener = param1;
      this.guestWindow = new GuestForm(this.onLogin);
      displayService.stage.addChild(this.guestWindow);
      if(ExternalInterface.available) {
        Security.allowDomain("*");
        ExternalInterface.addCallback("onReceive",this.setToken);
      }
    }

    private function onLogin() : void {
      if(ExternalInterface.available) {
        ExternalInterface.call("miniclipLogin");
      }
    }

    public function setToken(param1:String) : void {
      displayService.stage.removeChild(this.guestWindow);
      var local2:Dictionary = new Dictionary();
      local2["token"] = param1;
      this.listener.onSetParameters(new LoginParameters(local2));
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function getFailRedirectUrl() : String {
      return "http://tankionline.com";
    }

    public function isExternalLoginAllowed() : Boolean {
      return true;
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
