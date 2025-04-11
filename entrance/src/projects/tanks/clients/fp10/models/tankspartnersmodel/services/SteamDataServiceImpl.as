package projects.tanks.clients.fp10.models.tankspartnersmodel.services {
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.steam.SteamWorks;

  public class SteamDataServiceImpl implements SteamDataService {
    private var steamId:String;
    private var sessionTicket:String;
    private var language:String;
    private var appId:String;
    private var steamWorks:SteamWorks;

    public function SteamDataServiceImpl() {
      super();
    }

    public function setSteamId(param1:String) : void {
      this.steamId = param1;
    }

    public function setSessionTicket(param1:String) : void {
      this.sessionTicket = param1;
    }

    public function setLanguage(param1:String) : void {
      this.language = param1;
    }

    public function setAppId(param1:String) : void {
      this.appId = param1;
    }

    public function setSteamWorks(param1:SteamWorks) : void {
      this.steamWorks = param1;
    }

    public function getSteamId() : String {
      return this.steamId;
    }

    public function getSessionTicket() : String {
      return this.sessionTicket;
    }

    public function getLanguage() : String {
      return this.language;
    }

    public function getAppId() : String {
      return this.appId;
    }

    public function getSteamWorks() : SteamWorks {
      return this.steamWorks;
    }
  }
}
