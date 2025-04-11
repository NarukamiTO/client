package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.kongregate {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.kongregate.IKongregateLoginModelBase;
  import projects.tanks.client.partners.impl.kongregate.KongregateLoginModelBase;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.guestform.GuestForm;

  [ModelInfo]
  public class KongregateLoginModel extends KongregateLoginModelBase implements IKongregateLoginModelBase, IPartner {
    [Inject]
    public static var launcherParams:ILauncherParams;

    [Inject]
    public static var displayService:IDisplay;

    private var _kongregate:*;
    private var listener:IParametersListener;

    public var kongregateGuestWindow:GuestForm;

    public function KongregateLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      this.listener = param1;
      this.initKongregateApi();
    }

    private function initKongregateApi() : void {
      var local1:String = null;
      var local2:Loader = null;
      if(!this._kongregate) {
        local1 = launcherParams.getParameter("kongregate_api_path") || "http://www.kongregate.com/flash/API_AS3_Local.swf";
        local2 = new Loader();
        local2.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
        local2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
        local2.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
        local2.load(new URLRequest(local1));
        displayService.stage.addChild(local2);
      } else {
        this.loginClient();
      }
    }

    private function onComplete(param1:Event) : void {
      KongregateInstanceWrapper.kongregate = param1.target.content;
      this._kongregate = KongregateInstanceWrapper.kongregate;
      this._kongregate.services.connect();
      this.loginClient();
    }

    private function onError(param1:Event) : void {
      this.listener.onFailSetParameters();
    }

    private function generateParameters() : LoginParameters {
      this._kongregate.stats.submit("initialized",1);
      var local1:Dictionary = new Dictionary();
      local1["user_id"] = this._kongregate.services.getUserId();
      local1["game_auth_token"] = this._kongregate.services.getGameAuthToken();
      return new LoginParameters(local1);
    }

    private function loginClient() : void {
      if(Boolean(this._kongregate.services.isGuest())) {
        this.kongregateGuestWindow = new GuestForm(this._kongregate.services.showSignInBox);
        displayService.stage.addChild(this.kongregateGuestWindow);
        this._kongregate.services.addEventListener("login",this.onLogin);
      } else {
        this.listener.onSetParameters(this.generateParameters());
      }
    }

    private function onLogin(param1:Event) : void {
      displayService.stage.removeChild(this.kongregateGuestWindow);
      this.listener.onSetParameters(this.generateParameters());
    }

    public function getFailRedirectUrl() : String {
      return "http://www.kongregate.com/";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }

    public function hasRatings() : Boolean {
      return true;
    }
  }
}
