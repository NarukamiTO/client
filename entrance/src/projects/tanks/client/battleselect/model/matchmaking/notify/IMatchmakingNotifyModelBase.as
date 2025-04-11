package projects.tanks.client.battleselect.model.matchmaking.notify {
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;

  public interface IMatchmakingNotifyModelBase {
    function registrationCancelled() : void;
    function registrationTimeout() : void;
    function userRegistrationSuccessful(param1:int, param2:MatchmakingMode) : void;
  }
}
