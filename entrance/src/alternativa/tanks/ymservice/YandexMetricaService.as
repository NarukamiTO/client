package alternativa.tanks.ymservice {
  public interface YandexMetricaService {
    function reachGoal(param1:String) : void;
    function reachGoalIfPlayerWasInTutorial(param1:String) : void;
    function reachGoalIfPlayerIsNewbie(param1:String) : void;
  }
}
