package projects.tanks.clients.flash.commons.services.timeunit {
  public interface ITimeUnitService {
    function getLocalizedTimeString(param1:int, param2:int, param3:int) : String;
    function getTimeUnitNames(param1:int, param2:int, param3:int) : TimeUnitNames;
    function getLocalizedDaysString(param1:int) : String;
    function getLocalizedDaysName(param1:int) : String;
    function getLocalizedShortDaysName(param1:int) : String;
  }
}
