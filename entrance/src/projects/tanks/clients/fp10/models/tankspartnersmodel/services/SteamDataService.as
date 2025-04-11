package projects.tanks.clients.fp10.models.tankspartnersmodel.services {
  import projects.tanks.clients.fp10.models.tankspartnersmodel.partners.steam.SteamWorks;

  public interface SteamDataService {
    function setSteamId(param1:String) : void;
    function setSessionTicket(param1:String) : void;
    function setLanguage(param1:String) : void;
    function setAppId(param1:String) : void;
    function setSteamWorks(param1:SteamWorks) : void;
    function getSteamId() : String;
    function getSessionTicket() : String;
    function getLanguage() : String;
    function getAppId() : String;
    function getSteamWorks() : SteamWorks;
  }
}
