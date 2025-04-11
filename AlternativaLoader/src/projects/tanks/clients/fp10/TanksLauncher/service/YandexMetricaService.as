package projects.tanks.clients.fp10.TanksLauncher.service {
  import flash.external.ExternalInterface;

  public class YandexMetricaService {
    private static const YM_REACH_GOAL:String = "YMReachGoal";
    private static const YM_LOADED:String = "checkYMLoaded";
    private static const COOKIE_EXISTS_FUNC:String = "Cookie.exists";
    private static const WAS_IN_TUTORIAL:String = "FROM_TUTORIAL";

    public function YandexMetricaService() {
      super();
    }

    public static function reachGoalIfPlayerWasInTutorial(param1:String) : void {
      if(ExternalInterface.available && ExternalInterface.call(YM_LOADED) && ExternalInterface.call(COOKIE_EXISTS_FUNC,WAS_IN_TUTORIAL) > 0) {
        ExternalInterface.call(YM_REACH_GOAL,param1);
      }
    }
  }
}
