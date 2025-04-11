package projects.tanks.clients.fp10.models.tankspartnersmodel.partners.steam {
  import flash.utils.ByteArray;
  import flash.utils.Dictionary;
  import platform.client.core.general.socialnetwork.types.LoginParameters;
  import platform.clients.fp10.libraries.alternativapartners.type.IParametersListener;
  import platform.clients.fp10.libraries.alternativapartners.type.IPartner;
  import projects.tanks.client.partners.impl.steam.ISteamLoginModelBase;
  import projects.tanks.client.partners.impl.steam.SteamLoginModelBase;
  import projects.tanks.clients.fp10.models.tankspartnersmodel.services.SteamDataService;

  [ModelInfo]
  public class SteamLoginModel extends SteamLoginModelBase implements ISteamLoginModelBase, IPartner {
    [Inject]
    public static var steamDataService:SteamDataService;

    private static const STEAM_RESPONSE:String = "steamResponse";
    private static const RESPONSE_OnUserStatsReceived:int = 0;
    private static const RESPONSE_OnGetAuthSessionTicketResponse:int = 25;
    private static const STEAM_RESULT_OK:int = 1;
    private static const AUTHTICKET_Invalid:int = 0;

    private var listener:IParametersListener;
    private var steamWorks:SteamWorks;
    private var authTicketId:uint;
    private var authTicket:ByteArray;
    private var loginParameters:LoginParameters;

    public function SteamLoginModel() {
      super();
    }

    public function getLoginParameters(param1:IParametersListener) : void {
      if(Boolean(this.loginParameters)) {
        param1.onSetParameters(this.loginParameters);
        return;
      }
      this.listener = param1;
      this.initSteam();
    }

    private function initSteam() : void {
      this.steamWorks = new SteamWorks();
      steamDataService.setSteamWorks(this.steamWorks);
      this.steamWorks.addEventListener(STEAM_RESPONSE,this.onResponse);
      if(!this.steamWorks.init()) {
        this.wrongAuthentication();
      }
    }

    private function onResponse(param1:Object) : void {
      if(param1.req_type == RESPONSE_OnUserStatsReceived) {
        this.authTicket = new ByteArray();
        this.authTicketId = this.steamWorks.getAuthSessionTicket(this.authTicket);
      }
      if(param1.req_type == RESPONSE_OnGetAuthSessionTicketResponse) {
        this.steamWorks.removeEventListener(STEAM_RESPONSE,this.onResponse);
        if(param1.response != STEAM_RESULT_OK) {
          this.wrongAuthentication();
          return;
        }
        if(this.authTicketId == AUTHTICKET_Invalid) {
          this.wrongAuthentication();
          return;
        }
        this.loginParameters = this.createLoginParameters();
        this.listener.onSetParameters(this.loginParameters);
      }
    }

    private function createLoginParameters() : LoginParameters {
      var local1:String = this.steamWorks.getUserID();
      var local2:String = this.ticketToHex();
      steamDataService.setAppId(this.steamWorks.getAppID().toString());
      steamDataService.setSteamId(local1);
      steamDataService.setSessionTicket(local2);
      steamDataService.setLanguage(this.steamWorks.getCurrentGameLanguage());
      var local3:Dictionary = new Dictionary();
      local3["userId"] = local1;
      local3["authSessionTicket"] = local2;
      return new LoginParameters(local3);
    }

    private function wrongAuthentication() : void {
      this.listener.onFailSetParameters();
    }

    private function ticketToHex() : String {
      var local3:int = 0;
      var local1:String = "";
      var local2:int = 0;
      while(local2 < this.authTicket.length) {
        local3 = int(this.authTicket.readUnsignedByte());
        local1 += (local3 < 16 ? "0" : "") + local3.toString(16);
        local2++;
      }
      return local1;
    }

    public function getFailRedirectUrl() : String {
      return "https://store.steampowered.com/login/";
    }

    public function isExternalLoginAllowed() : Boolean {
      return false;
    }

    public function hasRatings() : Boolean {
      return false;
    }

    public function hasPaymentAction() : Boolean {
      return false;
    }

    public function paymentAction() : void {
    }
  }
}
