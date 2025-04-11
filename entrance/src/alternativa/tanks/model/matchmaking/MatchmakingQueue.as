package alternativa.tanks.model.matchmaking {
  [ModelInterface]
  public interface MatchmakingQueue {
    function registrationSuccessful() : void;
    function registrationCancelled() : void;
  }
}
