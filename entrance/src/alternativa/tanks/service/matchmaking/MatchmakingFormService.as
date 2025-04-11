package alternativa.tanks.service.matchmaking {
  import alternativa.tanks.view.mainview.HolidayParams;
  import flash.events.IEventDispatcher;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public interface MatchmakingFormService extends IEventDispatcher {
    function showMatchmakingLayout(param1:Dictionary, param2:HolidayParams, param3:int) : void;
    function hideMatchmakingLayout() : void;
    function showRegistrationWindow(param1:int, param2:MatchmakingMode) : void;
    function hideRegistrationWindow() : void;
    function getLastRegistrationMode() : MatchmakingMode;
    function getModeName(param1:MatchmakingMode) : String;
  }
}
